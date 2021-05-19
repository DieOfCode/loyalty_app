import 'package:equatable/equatable.dart';
import 'package:loaylity_app/model/profile.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

// class CreateProfileEvent extends ProfileEvent {
//   final Profile profile;
//
//   CreateProfileEvent(this.profile);
// }

// class ProfileLoadSuccess extends ProfileEvent {
//   final Profile profile;
//
//   ProfileLoadSuccess(this.profile);
//
//   @override
//   List<Object> get props => [profile];
// }

// class ProfileLoadFailure extends ProfileEvent {}

class ProfileSet extends ProfileEvent {
  final Profile profile;

  ProfileSet(this.profile);

  @override
  List<Object> get props => [profile];
}

class SetProfileEvent extends ProfileEvent {
  final Profile profile;

  SetProfileEvent(this.profile);

  @override
  List<Object> get props => [profile];
}

class UpdateProfile extends ProfileEvent {
  final Profile profile;

  UpdateProfile(this.profile);

  @override
  List<Object> get props => [profile];
}

class GetProfileById extends ProfileEvent {
  final int idProfile;

  GetProfileById(this.idProfile);

  @override
  // TODO: implement props
  List<Object> get props => [idProfile];
}
