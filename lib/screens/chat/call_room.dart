import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CallRoomScreen extends StatefulWidget {
  final String scope;
  final String alias;
  const CallRoomScreen({super.key, required this.scope, required this.alias});

  @override
  State<CallRoomScreen> createState() => _CallRoomScreenState();
}

class _CallRoomScreenState extends State<CallRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Voice Chat')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Start Call'),
        ),
      ),
    );
  }
}
