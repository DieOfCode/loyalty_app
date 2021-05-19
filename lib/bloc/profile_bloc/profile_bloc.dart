import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loaylity_app/bloc/login_bloc/login_bloc.dart';
import 'package:loaylity_app/bloc/login_bloc/login_state.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_event.dart';
import 'package:loaylity_app/bloc/profile_bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LoginBloc loginBloc;
  StreamSubscription loginSubscription;

  ProfileBloc({@required this.loginBloc})
      : super(
          loginBloc.state is ProfileLoginSuccess
              ? ProfileLoadSuccess(
                  (loginBloc.state as ProfileLoginSuccess).profile,
                )
              : ProfileLoadFailure(),
        ) {
    loginSubscription = loginBloc.stream.listen((state) {
      if (state is ProfileLoginSuccess) {
        add(ProfileSet((loginBloc.state as ProfileLoginSuccess).profile));
      }
    });
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileSet) {
      yield* _mapHabitsUpdatedToState(event);
    }
  }

  Stream<ProfileState> _mapHabitsUpdatedToState(
    ProfileSet event,
  ) async* {
    yield ProfileLoadSuccess(event.profile);
  }

  @override
  Future<void> close() {
    loginSubscription.cancel();
    return super.close();
  }
}
