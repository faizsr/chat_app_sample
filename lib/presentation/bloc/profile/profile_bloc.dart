import 'dart:async';

import 'package:chat_app_test/data/models/user_model.dart';
import 'package:chat_app_test/domain/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileInitialFetchEvent>(userDetailInitialFetchEvent);
  }

  FutureOr<void> userDetailInitialFetchEvent(
      ProfileInitialFetchEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileFetchingLoadingState());
    UserModel? currentUser = await ProfileRepo.fetchUserDetails();
    if (currentUser != null) {
      emit(ProfileFetchingSucessState(currentUser: currentUser));
    } else {
      emit(ProfileFetchingErrorState());
    }
  }
}
