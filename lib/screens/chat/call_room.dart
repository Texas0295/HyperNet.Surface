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

const _kLocalWebRtcBaseUrl = 'http://localhost:8001';

class _CallRoomScreenState extends State<CallRoomScreen> {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  WebSocketChannel? _wsChannel;

  @override
  void initState() {
    super.initState();
    _initWebRtc();
  }

  Future<void> _initWebRtc() async {
    final client = Dio();
    client.options.baseUrl = _kLocalWebRtcBaseUrl;

    final configResp = await client.get('/.well-known/webrtc');

    // Get user media (audio only)
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': true,
      'video': false,
    });

    // Configure Peer Connection
    Map<String, dynamic> config = {
      'iceServers': configResp.data['ice_servers']
    };

    _peerConnection = await createPeerConnection(config);

    // Add local stream to peer connection
    _peerConnection?.addStream(_localStream!);

    // Listen for ICE candidates
    _peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      print('New ICE candidate: ${candidate.candidate}');
      // Send the candidate to the signaling server
    };

    // Handle remote stream
    _peerConnection?.onAddStream = (MediaStream stream) {
      print('Remote stream added');
      // Play the remote stream
    };

    _wsChannel = WebSocketChannel.connect(
      Uri.parse('$_kLocalWebRtcBaseUrl/webrtc'),
    );
    await _wsChannel!.ready;

    _wsChannel!.stream.listen((event) {
      final Map<String, dynamic> data = jsonDecode(event);

      switch (data['type']) {
        case 'offer':
          _handleOffer(data);
          break;
        case 'answer':
          _handleAnswer(data);
          break;
        case 'candidate':
          _handleCandidate(data);
          break;
      }
    });
  }

  Future<void> _handleOffer(Map<String, dynamic> data) async {
    // Set remote description
    final offer = RTCSessionDescription(data['sdp'], data['type']);
    await _peerConnection?.setRemoteDescription(offer);

    // Create and send answer
    final answer = await _peerConnection?.createAnswer();
    await _peerConnection?.setLocalDescription(answer!);

    _wsChannel?.sink.add({
      'type': 'answer',
      'sdp': answer?.sdp,
    });
  }

  Future<void> _handleAnswer(Map<String, dynamic> data) async {
    // Set remote description
    final answer = RTCSessionDescription(data['sdp'], data['type']);
    await _peerConnection?.setRemoteDescription(answer);
  }

  Future<void> _handleCandidate(Map<String, dynamic> data) async {
    // Add ICE candidate
    final candidate = RTCIceCandidate(
      data['candidate'],
      data['sdpMid'],
      data['sdpMLineIndex'],
    );
    await _peerConnection?.addCandidate(candidate);
  }

  @override
  void dispose() {
    _wsChannel?.sink.close();
    _localStream?.dispose();
    _peerConnection?.close();
    super.dispose();
  }

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
