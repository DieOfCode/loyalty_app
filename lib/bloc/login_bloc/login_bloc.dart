import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:loaylity_app/model/profile.dart';
import 'package:loaylity_app/repository/profile_repository.dart';
import 'package:meta/meta.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ProfileRepository profileRepository;

  LoginBloc({@required this.profileRepository})
      : super(ProfileLoadInProgress());

  @override
  Stream<LoginState> mapEventToState(event) async* {
    if (event is ProfileLogin) {
      yield* _mapLoginUpdateCompletedToState(event);
    } else if (event is AuthenticationLoginRequested) {
      yield* _loginRequestToState(event);
    } else if (event is ProfileUpdated) {
      yield* _updateProfileToState(event);
    } else if (event is CreateProfileEvent) {
      yield* _createProfileToState(event);
    }
  }

  Stream<LoginState> _createProfileToState(CreateProfileEvent event) async* {
    try {
      await profileRepository.createProfile(event.profile);
      final Profile createdProfile =
          await profileRepository.getProfileByLogin(event.profile.login);
      yield ProfileLoginSuccess(createdProfile);
    } catch (_) {}
  }

  Stream<LoginState> _updateProfileToState(ProfileUpdated event) async* {
    int result = await _updateProfile(event.profile);
    yield ProfileLoginSuccess(event.profile);
  }

  Future _updateProfile(Profile profile) async {
    await profileRepository.updateProfile(profile);
  }

  Stream<LoginState> _mapLoginUpdateCompletedToState(
      ProfileLogin event) async* {
    if (state is ProfileLoginSuccess) {
      yield ProfileLoginSuccess(event.profile);
    }
  }

  Stream<LoginState> _loginRequestToState(
      AuthenticationLoginRequested event) async* {
    try {
      Profile checkProfile =
          await _checkProfileExist(event.login, event.password);
      if (checkProfile == null) {
        yield ProfileLoginFailure();
      } else {
        yield ProfileLoginSuccess(checkProfile);
      }
    } on Exception catch (_) {}
  }

  Future _checkProfileExist(String login, String password) async {
    Profile profileFromDB = await profileRepository.getProfileByLogin(login);
    if (profileFromDB.password == password) return profileFromDB;
    return null;
  }
}
