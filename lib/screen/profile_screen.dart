import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaylity_app/bloc/login_bloc/login_bloc.dart';
import 'package:loaylity_app/bloc/login_bloc/login_event.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_state.dart';
import 'package:loaylity_app/model/profile.dart';

import 'detail_screen.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Profile profile;
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (BlocProvider.of<ProfileBloc>(context).state is ProfileLoadSuccess) {
        profile = (state as ProfileLoadSuccess).profile;
        return Scaffold(
          appBar: AppBar(
            title: Text('Профиль'),
            actions: [
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EditScreen(
                            profile: profile,
                            onEdit: (Profile profile) {
                              BlocProvider.of<LoginBloc>(context)
                                  .add(ProfileUpdated(profile));
                            },
                          );
                        },
                      ),
                    );
                  })
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        '${profile.name}',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        child: Text(
                          '${profile.loyaltyName}',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailLoyaltyScreen(
                                  loyaltyName: profile.loyaltyName,
                                ),
                              ));
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('${profile.login}'),
                Text('${profile.birthDate}'),
                Text('${profile.cardNumber}'),
                Text('${profile.telephoneNumber}'),
              ],
            ),
          ),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}

class LoadingIndicator extends StatelessWidget {
  LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
