part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitialState extends ProfileState {}

class ProfileFetchingLoadingState extends ProfileState {}

class ProfileFetchingSucessState extends ProfileState {
  final UserModel currentUser;

  ProfileFetchingSucessState({required this.currentUser});
}

class ProfileFetchingErrorState extends ProfileState {}
