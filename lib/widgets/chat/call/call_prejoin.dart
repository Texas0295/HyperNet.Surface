    import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/chat_call.dart';
import 'package:surface/types/chat.dart';
import 'package:surface/widgets/dialog.dart';

class ChatCallPrejoinPopup extends StatefulWidget {
  final SnChatCall ongoingCall;
  final SnChannel channel;
  final void Function() onJoin;

  const ChatCallPrejoinPopup({
    super.key,
    required this.ongoingCall,
    required this.channel,
    required this.onJoin,
  });

  @override
  State<ChatCallPrejoinPopup> createState() => _ChatCallPrejoinPopupState();
}

class _ChatCallPrejoinPopupState extends State<ChatCallPrejoinPopup> {
  bool _isBusy = false;

  late final ChatCallProvider _call = context.read<ChatCallProvider>();

  void _performJoin() async {
    setState(() => _isBusy = true);

    _call.setCall(widget.ongoingCall, widget.channel);
    _call.setIsBusy(true);

    try {
      final resp = await _call.getRoomToken();
      final token = resp.$1;
      final endpoint = resp.$2;

      _call.initRoom();
      _call.setupRoomListeners(
        onDisconnected: (reason) {
          context.showSnackbar(
            'callDisconnected'.tr(args: [reason.toString()]),
          );
        },
      );

      await _call.joinRoom(endpoint, token);
      widget.onJoin();

      if (!mounted) return;
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      context.showErrorDialog(e);
    } finally {
      setState(() => _isBusy = false);
    }
  }

  @override
  void initState() {
    final call = context.read<ChatCallProvider>();
    call.checkPermissions().then((_) {
      call.initHardware();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final call = context.read<ChatCallProvider>();
    return ListenableBuilder(
      listenable: call,
      builder: (context, _) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('callMicrophone').tr(),
                    Switch(
                      value: call.enableAudio,
                      onChanged: null,
                    ),
                  ],
                ).padding(bottom: 5),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<MediaDevice>(
                    isExpanded: true,
                    disabledHint: Text('callMicrophoneDisabled').tr(),
                    hint: Text('callMicrophoneSelect').tr(),
                    items: call.enableAudio
                        ? call.audioInputs
                            .map(
                              (item) => DropdownMenuItem<MediaDevice>(
                                value: item,
                                child: Text(item.label),
                              ),
                            )
                            .toList()
                            .cast<DropdownMenuItem<MediaDevice>>()
                        : [],
                    value: call.audioDevice,
                    onChanged: (MediaDevice? value) async {
                      if (value != null) {
                        call.setAudioDevice(value);
                        await call.changeLocalAudioTrack();
                      }
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      width: 320,
                    ),
                  ),
                ).padding(bottom: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('callCamera').tr(),
                    Switch(
                      value: call.enableVideo,
                      onChanged: call.setEnableVideo,
                    ),
                  ],
                ).padding(bottom: 5),
                DropdownButtonHideUnderline(
                  child: DropdownButton2<MediaDevice>(
                    isExpanded: true,
                    disabledHint: Text('callCameraDisabled').tr(),
                    hint: Text('callCameraSelect').tr(),
                    items: call.enableVideo
                        ? call.videoInputs
                            .map(
                              (item) => DropdownMenuItem<MediaDevice>(
                                value: item,
                                child: Text(item.label),
                              ),
                            )
                            .toList()
                            .cast<DropdownMenuItem<MediaDevice>>()
                        : [],
                    value: call.videoDevice,
                    onChanged: (MediaDevice? value) async {
                      if (value != null) {
                        call.setVideoDevice(value);
                        await call.changeLocalVideoTrack();
                      }
                    },
                    buttonStyleData: const ButtonStyleData(
                      height: 40,
                      width: 320,
                    ),
                  ),
                ).padding(bottom: 25),
                if (_isBusy)
                  const Center(child: CircularProgressIndicator())
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(320, 56),
                    ),
                    onPressed: _isBusy ? null : _performJoin,
                    child: Text('callJoin').tr(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _call
      ..deactivateHardware()
      ..disposeHardware();
    super.dispose();
  }
}
