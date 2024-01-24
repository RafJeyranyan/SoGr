part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileLoadUser extends ProfileEvent {

  @override
  List<Object?> get props => [];
}

class ChangeUserNameEvent extends ProfileEvent{
  final String newName;
  const ChangeUserNameEvent({required this.newName});

  @override
  List<Object?> get props => [];

}


class ChangeUserSurnameEvent extends ProfileEvent{
  final String newSurname;
  const ChangeUserSurnameEvent({required this.newSurname});

  @override
  List<Object?> get props => [];

}


class ChangeUserImageEvent extends ProfileEvent{
  final String newDirUrl;
  const ChangeUserImageEvent({required this.newDirUrl});

  @override
  List<Object?> get props => [];

}
