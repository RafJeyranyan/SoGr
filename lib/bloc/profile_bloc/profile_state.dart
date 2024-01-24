part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileLoading extends ProfileState {

  @override
  List<Object> get props => [];
}



class ProfileLoadedState extends ProfileState {
  final User user;
  const ProfileLoadedState({required this.user});


  @override
  List<Object> get props => [user];
}
