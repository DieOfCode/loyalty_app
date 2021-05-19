import 'package:equatable/equatable.dart';
import 'package:loaylity_app/model/profile.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class ProfileCreated extends LoginEvent {
  final Profile profile;

  const ProfileCreated(this.profile);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'HabitAdded { habit: $profile }';
}

class AuthenticationLoginRequested extends LoginEvent {
  final String login;
  final String password;

  AuthenticationLoginRequested({this.login, this.password});

  @override
  List<Object> get props => [login, password];
}

class ProfileLogin extends LoginEvent {
  final Profile profile;

  const ProfileLogin(this.profile);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'HabitCompleted { habit: $profile }';
}

class CreateProfileEvent extends LoginEvent {
  final Profile profile;

  CreateProfileEvent(this.profile);
}

class ProfileUpdated extends LoginEvent {
  final Profile profile;

  ProfileUpdated(this.profile);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'HabitUpdated { updatedHabit: $profile }';
}
