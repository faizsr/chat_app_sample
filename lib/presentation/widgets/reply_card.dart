import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  const ReplyCard({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 100,
        ),
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: const Text(
            'Good yeahhhhh!!!',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
