import 'package:flutter/material.dart';

class MessageScreenView extends StatefulWidget {
  const MessageScreenView({super.key});

  @override
  State<MessageScreenView> createState() => _MessageScreenViewState();
}

class _MessageScreenViewState extends State<MessageScreenView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Message Body"),
      ),
    );
  }
}
