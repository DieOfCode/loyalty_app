import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loaylity_app/bloc/login_bloc/login_bloc.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_event.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_state.dart';
import 'package:loaylity_app/bloc/tab_bloc/tab_bloc.dart';
import 'package:loaylity_app/bloc/tab_bloc/tab_event.dart';
import 'package:loaylity_app/model/app_tab.dart';
import 'package:loaylity_app/model/loyalty_program.dart';
import 'package:loaylity_app/model/purchase.dart';
import 'package:loaylity_app/repository/profile_repository.dart';
import 'package:loaylity_app/screen/detail_screen.dart';
import 'package:loaylity_app/screen/login_screen.dart';
import 'package:loaylity_app/screen/main_screen.dart';
import 'package:loaylity_app/screen/profile_screen.dart';
import 'package:loaylity_app/screen/signup_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'model/profile.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) {
        return LoginBloc(profileRepository: ProfileRepository());
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) {
          return MultiBlocProvider(providers: [
            BlocProvider.value(value: BlocProvider.of<LoginBloc>(context)),
            BlocProvider<TabBloc>(
              create: (context) => TabBloc(),
            ),
            BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                loginBloc: BlocProvider.of<LoginBloc>(context),
              ),
            )
          ], child: LoginScreen());
        },
        '/profile_screen': (context) {
          return BlocProvider<ProfileBloc>(
            create: (BuildContext context) =>
                ProfileBloc(loginBloc: BlocProvider.of<LoginBloc>(context)),
            child: ProfileScreen(),
          );
        },
        '/main': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => TabBloc(),
              ),
              BlocProvider<ProfileBloc>(
                create: (context) => ProfileBloc(
                  loginBloc: BlocProvider.of<LoginBloc>(context),
                ),
              )
            ],
            child: AppScreen(),
          );
        },
        '/create_profile': (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(value: BlocProvider.of<LoginBloc>(context))
            ],
            child: SignUpScreen(),
          );
        }
      },
    );
  }
}

class AppScreen extends StatelessWidget {
  const AppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile profile = ModalRoute.of(context).settings.arguments;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return BlocBuilder<TabBloc, AppTab>(builder: (context, activeTab) {
          BlocProvider.of<ProfileBloc>(context).add(SetProfileEvent(profile));
          return Scaffold(
            body: activeTab == AppTab.main ? MainScreen() : ProfileScreen(),
            bottomNavigationBar: TabSelector(
              activeTab: activeTab,
              onTabSelected: (AppTab tab) =>
                  BlocProvider.of<TabBloc>(context).add(
                TabUpdated(tab),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Qr Code'),
                    content: Container(
                      width: 280,
                      height: 280,
                      child: QrImage(
                        data: 'test QR',
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Назад'),
                      )
                    ],
                  ),
                );
              },
              child: Icon(Icons.qr_code),
            ),
          );
        });
      },
    );
  }
}

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map(
        (tab) {
          return BottomNavigationBarItem(
              icon: Icon(tab == AppTab.main
                  ? Icons.shopping_bag_outlined
                  : Icons.person),
              label: tab == AppTab.main ? 'Кабинет' : 'Профиль');
        },
      ).toList(),
    );
  }
}
