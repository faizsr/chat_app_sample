// ignore_for_file: library_prefixes

import 'package:chat_app_test/data/models/user_model.dart';
import 'package:chat_app_test/presentation/widgets/chat_bottom_widget.dart';
import 'package:chat_app_test/presentation/widgets/own_message_card.dart';
import 'package:chat_app_test/presentation/widgets/reply_card.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    required this.chatUser,
  });

  final UserModel chatUser;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final IO.Socket _socket = IO.io(
      'ws://10.0.2.2:3000',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setExtraHeaders({'foo': 'bar'})
          .build());
  final scrollController = ScrollController();

  _connectSocket() {
    _socket.connect();
    _socket.onConnect((data) => print('Connection established'));
    _socket.onConnectError((data) => print('Connect Error: $data'));
    _socket.onDisconnect((data) => print('Socket.IO server disconnected'));
  }

  @override
  void initState() {
    _connectSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.chatUser.fullName!,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              widget.chatUser.id!,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                controller: scrollController,
                padding: const EdgeInsets.all(15),
                shrinkWrap: true,
                itemCount: 20,
                itemBuilder: (context, index) {
                  if (index % 3 == 0) {
                    return const ReplyCard(
                      message: 'Reply message',
                    );
                  }
                  return const OwnMessageCard(message: 'own message');
                },
              ),
            ),
          ),
          ChatBottomWidget(
            scrollController: scrollController,
          ),
        ],
      ),
    );
  }
}
