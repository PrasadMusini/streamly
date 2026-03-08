import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:streamly_cresolinfoserv/features/videos/data/models/video_model.dart';
import 'package:flutter/services.dart';

class VideoPlayerCard extends StatefulWidget {
  final Video video;

  const VideoPlayerCard({super.key, required this.video});

  @override
  State<VideoPlayerCard> createState() => _VideoPlayerCardState();
}

class _VideoPlayerCardState extends State<VideoPlayerCard> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isFullScreen = false;

  @override
  void initState() {
    super.initState();

    String videoUrl = widget.video.source ?? "";

    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        setState(() {});
      });

    _controller.addListener(() {
      if (_controller.value.isPlaying != _isPlaying) {
        setState(() {
          _isPlaying = _controller.value.isPlaying;
        });
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    /// Restore portrait when leaving widget
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  /// FULLSCREEN TOGGLE
  void toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  void togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  /// Forward 10 seconds
  void forward10Seconds() async {
    final position = await _controller.position;
    final duration = _controller.value.duration;

    if (position != null) {
      final newPosition = position + const Duration(seconds: 10);
      _controller.seekTo(newPosition < duration ? newPosition : duration);
    }
  }

  /// Backward 10 seconds
  void rewind10Seconds() async {
    final position = await _controller.position;

    if (position != null) {
      final newPosition = position - const Duration(seconds: 10);
      _controller.seekTo(
        newPosition > Duration.zero ? newPosition : Duration.zero,
      );
    }
  }

  /// Format time
  String format(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  /// Format Date
  String _formatDate(DateTime? date) {
    if (date == null) return '';

    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          /// VIDEO SECTION
          AspectRatio(
            aspectRatio: _isFullScreen
                ? MediaQuery.of(context).size.aspectRatio
                : (_controller.value.isInitialized
                      ? _controller.value.aspectRatio
                      : 16 / 9),
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// THUMBNAIL
                if (widget.video.thumb != null &&
                    widget.video.thumb!.isNotEmpty)
                  Image.network(
                    widget.video.thumb!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  )
                else
                  Container(color: Colors.grey[900]),

                /// VIDEO
                if (_controller.value.isInitialized)
                  VideoPlayer(_controller)
                else
                  const Center(child: CircularProgressIndicator()),

                if (_controller.value.isInitialized) ...[
                  /// DOUBLE TAP AREAS
                  Positioned.fill(
                    child: Row(
                      children: [
                        /// LEFT
                        Expanded(
                          child: GestureDetector(
                            onDoubleTap: rewind10Seconds,
                            behavior: HitTestBehavior.translucent,
                            child: Container(),
                          ),
                        ),

                        /// RIGHT
                        Expanded(
                          child: GestureDetector(
                            onDoubleTap: forward10Seconds,
                            behavior: HitTestBehavior.translucent,
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// PLAY PAUSE
                  GestureDetector(
                    onTap: togglePlayPause,
                    child: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      color: Colors.white.withOpacity(0.8),
                      size: 70,
                    ),
                  ),

                  /// PROGRESS BAR
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 10,
                    child: Column(
                      children: [
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: Colors.red,
                            bufferedColor: Colors.grey,
                            backgroundColor: Colors.white24,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              format(_controller.value.position),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              format(_controller.value.duration),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// FULLSCREEN BUTTON
                  Positioned(
                    bottom: 40,
                    right: 10,
                    child: IconButton(
                      icon: Icon(
                        _isFullScreen
                            ? Icons.fullscreen_exit
                            : Icons.fullscreen,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: toggleFullScreen,
                    ),
                  ),
                ],
              ],
            ),
          ),

          /// DETAILS (HIDE IN FULLSCREEN)
          if (!_isFullScreen)
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title ?? "No Title",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.video.likes ?? 0} Likes",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      Text(
                        _formatDate(widget.video.createdAt),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    widget.video.description ?? "No Description",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const FullScreenVideoPlayer({super.key, required this.videoUrl});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    /// Lock landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  void dispose() {
    _controller.dispose();

    /// Restore portrait
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  void togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: togglePlayPause,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),

                    Icon(
                      _controller.value.isPlaying
                          ? Icons.pause_circle
                          : Icons.play_circle,
                      color: Colors.white70,
                      size: 80,
                    ),

                    Positioned(
                      top: 20,
                      left: 20,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
