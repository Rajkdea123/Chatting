import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/constants.dart';
import 'package:wechat/models/last_message_model.dart';
import 'package:wechat/providers/authentication_provider.dart';
import 'package:wechat/providers/chat_provider.dart';
import 'package:wechat/streams/chats_stream.dart';
import 'package:wechat/streams/search_stream.dart';
import 'package:wechat/widgets/chat_widget.dart';
import 'package:provider/provider.dart';

class MyChatsScreen extends StatefulWidget {
  const MyChatsScreen({super.key});

  @override
  State<MyChatsScreen> createState() => _MyChatsScreenState();
}

class _MyChatsScreenState extends State<MyChatsScreen> {
  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthenticationProvider>().userModel!.uid;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          return Column(
            children: [
              // cupertinosearchbar
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                ),
                child: CupertinoSearchTextField(
                  placeholder: 'Search',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                  onChanged: (value) {
                    chatProvider.setSearchQuery(value);
                  },
                ),
              ),
              Expanded(
                child: chatProvider.searchQuery.isEmpty
                    ? ChatsStream(uid: uid)
                    : SearchStream(uid: uid),
              ),
            ],
          );
        },
      ),
    );
  }
}
