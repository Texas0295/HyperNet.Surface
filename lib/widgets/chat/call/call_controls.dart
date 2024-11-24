import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:surface/providers/chat_call.dart';
import 'package:surface/widgets/dialog.dart';

class ControlsWidget extends StatefulWidget {
  final Room room;
  final LocalParticipant participant;

  const ControlsWidget(
    this.room,
    this.participant, {
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _ControlsWidgetState();
}

class _ControlsWidgetState extends State<ControlsWidget> {
  CameraPosition _position = CameraPosition.front;

  List<MediaDevice>? _audioInputs;
  List<MediaDevice>? _audioOutputs;
  List<MediaDevice>? _videoInputs;

  StreamSubscription? _subscription;

  bool _speakerphoneOn = false;

  @override
  void initState() {
    super.initState();
    _participant.addListener(onChange);
    _subscription = Hardware.instance.onDeviceChange.stream
        .listen((List<MediaDevice> devices) {
      _revertDevices(devices);
    });
    Hardware.instance.enumerateDevices().then(_revertDevices);
    _speakerphoneOn = Hardware.instance.speakerOn ?? false;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _participant.removeListener(onChange);
    super.dispose();
  }

  LocalParticipant get _participant => widget.participant;

  void _revertDevices(List<MediaDevice> devices) async {
    _audioInputs = devices.where((d) => d.kind == 'audioinput').toList();
    _audioOutputs = devices.where((d) => d.kind == 'audiooutput').toList();
    _videoInputs = devices.where((d) => d.kind == 'videoinput').toList();
    setState(() {});
  }

  void onChange() => setState(() {});

  bool get isMuted => _participant.isMuted;

  Future<bool?> showDisconnectDialog() {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('callDisconnect').tr(),
        content: Text('callDisconnectDescription').tr(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text('cancel').tr(),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text('dialogConfirm').tr(),
          ),
        ],
      ),
    );
  }

  void _disconnect() async {
    if (await showDisconnectDialog() != true) return;
    if (!mounted) return;

    final call = context.read<ChatCallProvider>();
    if (call.current != null) {
      call.disposeRoom();
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  void _disableAudio() async {
    await _participant.setMicrophoneEnabled(false);
  }

  void _enableAudio() async {
    await _participant.setMicrophoneEnabled(true);
  }

  void _disableVideo() async {
    await _participant.setCameraEnabled(false);
  }

  void _enableVideo() async {
    await _participant.setCameraEnabled(true);
  }

  void _selectAudioOutput(MediaDevice device) async {
    await widget.room.setAudioOutputDevice(device);
    setState(() {});
  }

  void _selectAudioInput(MediaDevice device) async {
    await widget.room.setAudioInputDevice(device);
    setState(() {});
  }

  void _selectVideoInput(MediaDevice device) async {
    await widget.room.setVideoInputDevice(device);
    setState(() {});
  }

  void _toggleSpeakerphoneOn() {
    _speakerphoneOn = !_speakerphoneOn;
    Hardware.instance.setSpeakerphoneOn(_speakerphoneOn);
    setState(() {});
  }

  void _toggleCamera() async {
    final track = _participant.videoTrackPublications.firstOrNull?.track;
    if (track == null) return;

    try {
      final newPosition = _position.switched();
      await track.setCameraPosition(newPosition);
      setState(() {
        _position = newPosition;
      });
    } catch (error) {
      return;
    }
  }

  void _enableScreenShare() async {
    if (lkPlatformIsDesktop()) {
      try {
        final source = await showDialog<DesktopCapturerSource>(
          context: context,
          builder: (context) => ScreenSelectDialog(),
        );
        if (source == null) {
          return;
        }
        var track = await LocalVideoTrack.createScreenShareTrack(
          ScreenShareCaptureOptions(
            captureScreenAudio: true,
            sourceId: source.id,
            maxFrameRate: 30.0,
          ),
        );
        await _participant.publishVideoTrack(track);
      } catch (err) {
        if (!mounted) return;
        context.showErrorDialog(err);
      }
      return;
    }
    if (lkPlatformIs(PlatformType.iOS)) {
      var track = await LocalVideoTrack.createScreenShareTrack(
        const ScreenShareCaptureOptions(
          useiOSBroadcastExtension: true,
          captureScreenAudio: true,
          maxFrameRate: 30.0,
        ),
      );
      await _participant.publishVideoTrack(track);
      return;
    }

    if (lkPlatformIsWebMobile()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Screen share is not supported mobile platform.'),
      ));
      return;
    }

    await _participant.setScreenShareEnabled(true, captureScreenAudio: true);
  }

  void _disableScreenShare() async {
    await _participant.setScreenShareEnabled(false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 5,
        runSpacing: 5,
        children: [
          IconButton(
            icon: const Icon(Symbols.exit_to_app),
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: _disconnect,
          ),
          if (_participant.isMicrophoneEnabled())
            if (lkPlatformIs(PlatformType.android))
              IconButton(
                onPressed: _disableAudio,
                icon: const Icon(Symbols.mic),
                color: Theme.of(context).colorScheme.onSurface,
                tooltip: 'callMicrophoneOff'.tr(),
              )
            else
              PopupMenuButton<MediaDevice>(
                icon: const Icon(Symbols.settings_voice),
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem<MediaDevice>(
                      value: null,
                      onTap: isMuted ? _enableAudio : _disableAudio,
                      child: ListTile(
                        leading: const Icon(Symbols.mic_off),
                        title: Text(isMuted
                            ? 'callMicrophoneOn'.tr()
                            : 'callMicrophoneOff'.tr()),
                      ),
                    ),
                    if (_audioInputs != null)
                      ..._audioInputs!.map((device) {
                        return PopupMenuItem<MediaDevice>(
                          value: device,
                          child: ListTile(
                            leading: (device.deviceId ==
                                    widget.room.selectedAudioInputDeviceId)
                                ? const Icon(Symbols.check_box)
                                : const Icon(Symbols.check_box_outline_blank),
                            title: Text(device.label),
                          ),
                          onTap: () => _selectAudioInput(device),
                        );
                      })
                  ];
                },
              )
          else
            IconButton(
              onPressed: _enableAudio,
              icon: const Icon(Symbols.mic_off),
              color: Theme.of(context).colorScheme.onSurface,
              tooltip: 'callMicrophoneOn'.tr(),
            ),
          if (_participant.isCameraEnabled())
            PopupMenuButton<MediaDevice>(
              icon: const Icon(Symbols.videocam_sharp),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<MediaDevice>(
                    value: null,
                    onTap: _disableVideo,
                    child: ListTile(
                      leading: const Icon(Symbols.videocam_off),
                      title: Text('callCameraOff'.tr()),
                    ),
                  ),
                  if (_videoInputs != null)
                    ..._videoInputs!.map((device) {
                      return PopupMenuItem<MediaDevice>(
                        value: device,
                        child: ListTile(
                          leading: (device.deviceId ==
                                  widget.room.selectedVideoInputDeviceId)
                              ? const Icon(Symbols.check_box)
                              : const Icon(Symbols.check_box_outline_blank),
                          title: Text(device.label),
                        ),
                        onTap: () => _selectVideoInput(device),
                      );
                    })
                ];
              },
            )
          else
            IconButton(
              onPressed: _enableVideo,
              icon: const Icon(Symbols.videocam_off),
              color: Theme.of(context).colorScheme.onSurface,
              tooltip: 'callCameraOn'.tr(),
            ),
          IconButton(
            icon: Icon(_position == CameraPosition.back
                ? Symbols.video_camera_back
                : Symbols.video_camera_front),
            color: Theme.of(context).colorScheme.onSurface,
            onPressed: () => _toggleCamera(),
            tooltip: 'callVideoFlip'.tr(),
          ),
          if (!lkPlatformIs(PlatformType.iOS))
            PopupMenuButton<MediaDevice>(
              icon: const Icon(Symbols.volume_up),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<MediaDevice>(
                    value: null,
                    child: ListTile(
                      leading: const Icon(Symbols.speaker),
                      title: Text('callSpeakerSelect').tr(),
                    ),
                  ),
                  if (_audioOutputs != null)
                    ..._audioOutputs!.map((device) {
                      return PopupMenuItem<MediaDevice>(
                        value: device,
                        child: ListTile(
                          leading: (device.deviceId ==
                                  widget.room.selectedAudioOutputDeviceId)
                              ? const Icon(Symbols.check_box)
                              : const Icon(Symbols.check_box_outline_blank),
                          title: Text(device.label),
                        ),
                        onTap: () => _selectAudioOutput(device),
                      );
                    })
                ];
              },
            ),
          if (!kIsWeb && Hardware.instance.canSwitchSpeakerphone)
            IconButton(
              onPressed: _toggleSpeakerphoneOn,
              color: Theme.of(context).colorScheme.onSurface,
              icon: _speakerphoneOn
                  ? Icon(Symbols.volume_up)
                  : Icon(Symbols.volume_down),
              tooltip: 'callSpeakerphoneToggle'.tr(),
            ),
          if (_participant.isScreenShareEnabled())
            IconButton(
              icon: const Icon(Symbols.stop_screen_share),
              color: Theme.of(context).colorScheme.onSurface,
              onPressed: () => _disableScreenShare(),
              tooltip: 'callScreenOff'.tr(),
            )
          else
            IconButton(
              icon: const Icon(Symbols.screen_share),
              color: Theme.of(context).colorScheme.onSurface,
              onPressed: () => _enableScreenShare(),
              tooltip: 'callScreenOn'.tr(),
            ),
        ],
      ),
    );
  }
}
