import 'package:chewie/chewie.dart';
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
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  bool isPlaying = false;

  void initializeVideo() async {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.source ?? ""),
    );

    await videoPlayerController!.initialize();

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );

    setState(() {
      isPlaying = true;
    });
  }

  @override
  void dispose() {
    videoPlayerController?.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// VIDEO AREA
          AspectRatio(
            aspectRatio: 16 / 9,
            child: isPlaying
                ? Chewie(controller: chewieController!)
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      /// THUMBNAIL
                      Image.network(
                        widget.video.thumb!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Image.network(
                            "https://cdn.pixabay.com/photo/2020/06/21/09/48/hill-5324149_640.jpg",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        },
                      ),

                      /// PLAY BUTTON
                      IconButton(
                        iconSize: 70,
                        icon: const Icon(
                          Icons.play_circle_fill,
                          color: Colors.white,
                        ),
                        onPressed: initializeVideo,
                      ),
                    ],
                  ),
          ),

          /// TITLE
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.video.title ?? "",
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Text("${widget.video.likes ?? 0} Likes"),
                // Row(
                //   children: [
                //     const Icon(Icons.thumb_up, size: 18),
                //     const SizedBox(width: 4),
                //     Text(widget.video.likes?.toString() ?? "0"),
                //   ],
                // ),
              ],
            ),
          ),

          /// DESCRIPTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.video.description ?? ""),
          ),

          /// FOOTER
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.video.subtitle ?? ""),

                Text(
                  _formatDate(widget.video.createdAt),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}
 /*  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    super.initState();

    print("video source ${widget.video.source}");

    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.source ?? ""),
    );

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
      allowPlaybackSpeedChanging: true,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );

    videoPlayerController.initialize();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// VIDEO PLAYER
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Chewie(controller: chewieController!),
          ),

          /// TITLE
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.video.title ?? "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          /// DESCRIPTION
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(widget.video.description ?? ""),
          ),

          /// FOOTER
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.video.subtitle ?? ""),
                Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 18),
                    const SizedBox(width: 4),
                    Text(widget.video.likes?.toString() ?? "0"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
 */

