import 'package:chat_app_test/data/models/user_model.dart';
import 'package:chat_app_test/presentation/bloc/profile/profile_bloc.dart';
import 'package:chat_app_test/presentation/bloc/user/user_bloc.dart';
import 'package:chat_app_test/presentation/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    context.read<UserBloc>().add(FetchAllUserEvent());
    context.read<ProfileBloc>().add(ProfileInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: 20),
            currentUser(),
            const SizedBox(height: 20),
            usersList(),
          ],
        ),
      ),
    );
  }

  Widget usersList() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserDetailFetchingLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserDetailFetchingSuccessState) {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              UserModel user = state.users[index];
              return ListTile(
                title: Text(user.fullName!),
                subtitle: Text(user.username!),
                leading: CircleAvatar(
                  radius: 30,
                  child: Text(
                    user.fullName![0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatScreen(chatUser: user),
                  ));
                },
              );
            },
          );
        }
        return const SizedBox(
          child: Center(
            child: Text('No Users found'),
          ),
        );
      },
    );
  }

  BlocBuilder<ProfileBloc, ProfileState> currentUser() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileFetchingSucessState) {
          return Column(
            children: [
              Text('Current User Full Name: ${state.currentUser.fullName}'),
              Text('Current Username: ${state.currentUser.username}'),
              Text('Current User Id: ${state.currentUser.id}')
            ],
          );
        }
        return Container();
      },
    );
  }
}
