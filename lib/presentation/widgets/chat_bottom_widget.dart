// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ChatBottomWidget extends StatefulWidget {
  const ChatBottomWidget({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<ChatBottomWidget> createState() => _ChatBottomWidgetState();
}

class _ChatBottomWidgetState extends State<ChatBottomWidget> {
  bool show = false;
  bool sentButton = false;
  FocusNode focusNode = FocusNode();
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (show) {
          setState(() {
            show = false;
          });
        } else {
          Navigator.pop(context);
        }
        return Future.value(false);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    onTap: () {
                      widget.scrollController.animateTo(
                        widget.scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          sentButton = true;
                        });
                      } else {
                        setState(() {
                          sentButton = false;
                        });
                      }
                      widget.scrollController.animateTo(
                        widget.scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 100),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    controller: controller,
                    focusNode: focusNode,
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      prefix: const SizedBox(width: 10),
                      border: InputBorder.none,
                      hintText: 'Type here...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send_outlined,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
