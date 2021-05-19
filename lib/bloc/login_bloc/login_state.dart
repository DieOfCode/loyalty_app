import 'package:equatable/equatable.dart';
import 'package:loaylity_app/model/profile.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class ProfileLoadInProgress extends LoginState {}

class ProfileLoginSuccess extends LoginState {
  final Profile profile;

  const ProfileLoginSuccess([this.profile]);

  @override
  List<Object> get props => [profile];

  @override
  String toString() => 'HabitsLoadSuccess { habits: $profile }';
}

class ProfileLoginFailure extends LoginState {}
