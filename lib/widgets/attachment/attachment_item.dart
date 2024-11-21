import 'dart:ui';
import 'dart:math' as math;

import 'package:dismissible_page/dismissible_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:provider/provider.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:surface/providers/sn_network.dart';
import 'package:surface/types/attachment.dart';
import 'package:surface/widgets/attachment/attachment_detail.dart';
import 'package:surface/widgets/universal_image.dart';
import 'package:uuid/uuid.dart';

class AttachmentItem extends StatelessWidget {
  final SnAttachment? data;
  final bool isExpandable;
  const AttachmentItem({
    super.key,
    required this.data,
    this.isExpandable = false,
  });

  Widget _buildContent(BuildContext context, String heroTag) {
    if (data == null) {
      return const Icon(Symbols.cancel).center();
    }

    final tp = data!.mimetype.split('/').firstOrNull;
    final sn = context.read<SnNetworkProvider>();
    switch (tp) {
      case 'image':
        return Hero(
          tag: 'attachment-${data!.rid}-$heroTag',
          child: AutoResizeUniversalImage(
            sn.getAttachmentUrl(data!.rid),
            key: Key('attachment-${data!.rid}-$heroTag'),
            fit: BoxFit.cover,
          ),
        );
      case 'video':
        return _AttachmentItemContentVideo(
          data: data!,
          isAutoload: false,
        );
      case 'audio':
        return _AttachmentItemContentAudio(
          data: data!,
          isAutoload: false,
        );
      default:
        return const Placeholder();
    }
  }

  @override
  Widget build(BuildContext context) {
    final uuid = Uuid();
    final heroTag = uuid.v4();

    if (data!.isMature) {
      return _AttachmentItemSensitiveBlur(
        child: _buildContent(context, heroTag),
      );
    }

    if (isExpandable) {
      return GestureDetector(
        child: _buildContent(context, heroTag),
        onTap: () {
          context.pushTransparentRoute(
            AttachmentDetailPopup(data: data!, heroTag: heroTag),
            rootNavigator: true,
          );
        },
      );
    }

    return _buildContent(context, heroTag);
  }
}

class _AttachmentItemSensitiveBlur extends StatefulWidget {
  final Widget child;
  const _AttachmentItemSensitiveBlur({super.key, required this.child});

  @override
  State<_AttachmentItemSensitiveBlur> createState() =>
      _AttachmentItemSensitiveBlurState();
}

class _AttachmentItemSensitiveBlurState
    extends State<_AttachmentItemSensitiveBlur> {
  bool _doesShow = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
            child: Container(
              color: Colors.black.withOpacity(0.5),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Symbols.visibility_off,
                    color: Colors.white,
                    size: 32,
                  ),
                  const Gap(8),
                  Text('sensitiveContent')
                      .tr()
                      .fontSize(20)
                      .textColor(Colors.white)
                      .bold(),
                  Text('sensitiveContentDescription')
                      .tr()
                      .fontSize(14)
                      .textColor(Colors.white.withOpacity(0.8)),
                  const Gap(16),
                  InkWell(
                    child: Text('sensitiveContentReveal')
                        .tr()
                        .textColor(Colors.white),
                    onTap: () {
                      setState(() => _doesShow = !_doesShow);
                    },
                  ),
                ],
              ),
            ),
          ),
        )
            .opacity(_doesShow ? 0 : 1, animate: true)
            .animate(const Duration(milliseconds: 300), Curves.easeInOut),
        if (_doesShow)
          Positioned(
            top: 0,
            left: 0,
            child: InkWell(
              child: Icon(
                Symbols.visibility_off,
                color: Colors.white,
                shadows: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 3,
                    offset: Offset(0, 1.5),
                  ),
                ],
              ).padding(all: 12),
              onTap: () {
                setState(() => _doesShow = !_doesShow);
              },
            ),
          ),
      ],
    );
  }
}

class _AttachmentItemContentVideo extends StatefulWidget {
  final SnAttachment data;
  final bool isAutoload;
  const _AttachmentItemContentVideo({
    super.key,
    required this.data,
    this.isAutoload = false,
  });

  @override
  State<_AttachmentItemContentVideo> createState() =>
      _AttachmentItemContentVideoState();
}

class _AttachmentItemContentVideoState
    extends State<_AttachmentItemContentVideo> {
  bool _showContent = false;

  Player? _videoPlayer;
  VideoController? _videoController;

  Future<void> _startLoad() async {
    setState(() => _showContent = true);
    MediaKit.ensureInitialized();
    final sn = context.read<SnNetworkProvider>();
    final url = sn.getAttachmentUrl(widget.data.rid);
    _videoPlayer = Player();
    _videoController = VideoController(_videoPlayer!);
    _videoPlayer!.open(Media(url), play: !widget.isAutoload);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isAutoload) _startLoad();
  }

  @override
  Widget build(BuildContext context) {
    const labelShadows = <Shadow>[
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 5.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ];

    final ratio = widget.data.metadata['ratio'] ?? 16 / 9;

    final sn = context.read<SnNetworkProvider>();

    if (!_showContent) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            if (widget.data.metadata['thumbnail'] != null)
              AutoResizeUniversalImage(
                sn.getAttachmentUrl(widget.data.metadata['thumbnail']),
                fit: BoxFit.cover,
              )
            else
              const Center(
                child: Icon(Icons.movie, size: 64),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.surface.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 16,
              right: 16,
              child: SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.alt,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              shadows: labelShadows,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            Duration(
                              milliseconds:
                                  (widget.data.metadata['duration'] ?? 0)
                                          .toInt() *
                                      1000,
                            ).toString(),
                            style: GoogleFonts.robotoMono(
                              fontSize: 12,
                              shadows: labelShadows,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.play_arrow,
                      shadows: labelShadows,
                      color: Colors.white,
                    ).padding(bottom: 4, right: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          _startLoad();
        },
      );
    } else if (_videoController == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Video(
      controller: _videoController!,
      aspectRatio: ratio,
    );
  }

  @override
  void dispose() {
    _videoPlayer?.dispose();
    super.dispose();
  }
}

class _AttachmentItemContentAudio extends StatefulWidget {
  final SnAttachment data;
  final bool isAutoload;
  const _AttachmentItemContentAudio({
    super.key,
    required this.data,
    this.isAutoload = false,
  });

  @override
  State<_AttachmentItemContentAudio> createState() =>
      _AttachmentItemContentAudioState();
}

class _AttachmentItemContentAudioState
    extends State<_AttachmentItemContentAudio> {
  bool _showContent = false;

  double? _draggingValue;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  Duration _bufferedPosition = Duration.zero;

  Player? _audioPlayer;

  Future<void> _startLoad() async {
    setState(() => _showContent = true);
    MediaKit.ensureInitialized();
    final sn = context.read<SnNetworkProvider>();
    final url = sn.getAttachmentUrl(widget.data.rid);
    _audioPlayer = Player();
    await _audioPlayer!.open(Media(url), play: !widget.isAutoload);
    _audioPlayer!.stream.playing.listen((v) => setState(() => _isPlaying = v));
    _audioPlayer!.stream.position.listen((v) => setState(() => _position = v));
    _audioPlayer!.stream.duration.listen((v) => setState(() => _duration = v));
    _audioPlayer!.stream.buffer.listen(
      (v) => setState(() => _bufferedPosition = v),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.isAutoload) _startLoad();
  }

  @override
  Widget build(BuildContext context) {
    const labelShadows = <Shadow>[
      Shadow(
        offset: Offset(1, 1),
        blurRadius: 5.0,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    ];

    final sn = context.read<SnNetworkProvider>();

    if (!_showContent) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            if (widget.data.metadata['thumbnail'] != null)
              AspectRatio(
                aspectRatio: 16 / 9,
                child: AutoResizeUniversalImage(
                  sn.getAttachmentUrl(widget.data.metadata['thumbnail']),
                  fit: BoxFit.cover,
                ),
              )
            else
              const Center(
                child: Icon(Icons.radio, size: 64),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Theme.of(context).colorScheme.surface,
                        Theme.of(context).colorScheme.surface.withOpacity(0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 16,
              right: 16,
              child: SizedBox(
                height: 45,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.alt,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              shadows: labelShadows,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            widget.data.size.toString(),
                            style: GoogleFonts.robotoMono(
                              fontSize: 12,
                              shadows: labelShadows,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.play_arrow,
                      shadows: labelShadows,
                      color: Colors.white,
                    ).padding(bottom: 4, right: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
        onTap: () {
          _startLoad();
        },
      );
    } else if (_audioPlayer == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Stack(
      children: [
        if (widget.data.metadata['thumbnail'] != null)
          AspectRatio(
            aspectRatio: 16 / 9,
            child: AutoResizeUniversalImage(
              sn.getAttachmentUrl(widget.data.metadata['thumbnail']),
              fit: BoxFit.cover,
            ),
          ),
        Container(
          constraints: const BoxConstraints(maxWidth: 320),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.audio_file, size: 32),
              const Gap(8),
              Text(
                widget.data.alt,
                style: const TextStyle(fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const Gap(12),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 2,
                            trackShape: _PlayerProgressTrackShape(),
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                            overlayShape: SliderComponentShape.noOverlay,
                          ),
                          child: Slider(
                            secondaryTrackValue: _bufferedPosition
                                .inMilliseconds
                                .abs()
                                .toDouble(),
                            value: _draggingValue?.abs() ??
                                _position.inMilliseconds.toDouble().abs(),
                            min: 0,
                            max: math
                                .max(
                                  _bufferedPosition.inMilliseconds.abs(),
                                  math.max(
                                    _position.inMilliseconds.abs(),
                                    _duration.inMilliseconds.abs(),
                                  ),
                                )
                                .toDouble(),
                            onChanged: (value) {
                              setState(() => _draggingValue = value);
                            },
                            onChangeEnd: (value) {
                              _audioPlayer!.seek(
                                Duration(milliseconds: value.toInt()),
                              );
                              setState(() => _draggingValue = null);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _position.toString(),
                              style: GoogleFonts.robotoMono(fontSize: 12),
                            ),
                            Text(
                              _duration.toString(),
                              style: GoogleFonts.robotoMono(fontSize: 12),
                            ),
                          ],
                        ).padding(horizontal: 8, vertical: 4),
                      ],
                    ),
                  ),
                  const Gap(16),
                  IconButton.filled(
                    icon: _isPlaying
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                    onPressed: () {
                      _audioPlayer!.playOrPause();
                    },
                    visualDensity: const VisualDensity(
                      horizontal: -4,
                      vertical: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).center(),
      ],
    );
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    super.dispose();
  }
}

class _PlayerProgressTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
