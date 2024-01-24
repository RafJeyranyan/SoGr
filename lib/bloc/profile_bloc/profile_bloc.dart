
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:so_group/core/service/shared_preferences/sh_prefs.dart';

import '../../core/entities/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<ProfileEvent>((event, emit) {

    });

    on<ProfileLoadUser>((event, emit) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        final User user = User(
          name: prefs.getString(SPUserData.name),
          surname: prefs.getString(SPUserData.surname),
          email: prefs.getString(SPUserData.email),
          imageUrl: prefs.getString(SPUserData.imageUrl),
        );
        emit(ProfileLoadedState(user: user));
      }catch(e){
        emit(ProfileLoadedState(user: User()));
      }
    });



    on<ChangeUserNameEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(SPUserData.name, event.newName);
      if(state is ProfileLoadedState){

        final User user = User(
          name:  event.newName,
          surname:  (state as ProfileLoadedState).user.surname,
          email:  (state as ProfileLoadedState).user.email,
          imageUrl:  (state as ProfileLoadedState).user.imageUrl,
        );

        emit(ProfileLoadedState(user: user));
      }
    });

    on<ChangeUserSurnameEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(SPUserData.surname, event.newSurname);
      if(state is ProfileLoadedState){

        final User user = User(
          name:  (state as ProfileLoadedState).user.name,
          surname:  event.newSurname,
          email:  (state as ProfileLoadedState).user.email,
          imageUrl:  (state as ProfileLoadedState).user.imageUrl,
        );

        emit(ProfileLoadedState(user: user));
      }
    });


    on<ChangeUserImageEvent>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(SPUserData.imageUrl, event.newDirUrl);
      if(state is ProfileLoadedState){

        final User user = User(
          name:  (state as ProfileLoadedState).user.name,
          surname:  (state as ProfileLoadedState).user.surname,
          email:  (state as ProfileLoadedState).user.email,
          imageUrl:  event.newDirUrl,
        );

        emit(ProfileLoadedState(user: user));
      }
    });

  }
}
