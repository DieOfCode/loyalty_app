import 'package:equatable/equatable.dart';
import 'package:loaylity_app/model/profile.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileLoadSuccess extends ProfileState {
  final Profile profile;

  ProfileLoadSuccess([this.profile]);

  @override
  List<Object> get props => [profile];
}

class ProfileLoadFailure extends ProfileState {}

class ProfileLoadInProgress extends ProfileState {}
