import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_bloc.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_state.dart';
import 'package:loaylity_app/model/profile.dart';
import 'package:loaylity_app/widget/widget.dart';

import 'detail_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      if (BlocProvider.of<ProfileBloc>(context).state is ProfileLoadSuccess) {
        Profile profile = (state as ProfileLoadSuccess).profile;
        return Scaffold(
          appBar: AppBar(
            title: Text('Кабинет'),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailLoyaltyScreen(
                                      loyaltyName: profile.loyaltyName,
                                    ),
                                  ));
                            },
                            child: Text('${profile.loyaltyName}')),
                      ],
                    ),
                  ),
                ),
                Flexible(flex: 2, child: PurchaseTable())
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
