//
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// import '../../backend/model/dashboard/dashboard_model.dart';
// import '../../utils/basic_screen_imports.dart';
//
// class VideoScreenMobile extends StatefulWidget {
//   const VideoScreenMobile({super.key, required this.video});
//
//   final Video video;
//
//   @override
//   State<VideoScreenMobile> createState() => _VideoScreenMobileState();
// }
//
// class _VideoScreenMobileState extends State<VideoScreenMobile> {
//
//   late YoutubePlayerController _controller;
//   bool isFullScreen = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: widget.video.itemLink.split("/embed/").last,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false,
//       ),
//     );
//     _controller.addListener(() {
//       if (_controller.value.isFullScreen != isFullScreen) {
//         setState(() {
//           isFullScreen = _controller.value.isFullScreen;
//         });
//       }
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // ignore: deprecated_member_use
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context);
//         return false;
//       },
//       child: Scaffold(
//           appBar: PrimaryAppBar(
//             widget.video.itemTitle,
//             centerTitle: false,
//             appbarSize: Dimensions.heightSize * 4,
//           ),
//           body: _bodyWidget(context)),
//     );
//   }
//
//   _bodyWidget(BuildContext context) {
//     return YoutubePlayerBuilder(
//         onExitFullScreen: () {
//           SystemChrome.setPreferredOrientations(DeviceOrientation.values);
//           setState(() {
//             isFullScreen = true;
//           });
//         },
//         player: YoutubePlayer(
//           controller: _controller,
//           liveUIColor: Colors.amber,
//           showVideoProgressIndicator: true,
//
//         ),
//         builder: (context, player) => Scaffold(
//           body: ListView(
//             children: [
//               player,
//             ],
//           ),
//         )
//     );
//   }
// }


//
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:video_player/video_player.dart';
//
// import '../../backend/model/dashboard/dashboard_model.dart';
// import '../../utils/basic_screen_imports.dart';
//
// class VideoScreenMobile extends StatefulWidget {
//   const VideoScreenMobile({super.key, required this.video});
//
//   final Video video;
//
//   @override
//   State<VideoScreenMobile> createState() => _VideoScreenMobileState();
// }
//
// class _VideoScreenMobileState extends State<VideoScreenMobile> {
//   YoutubePlayerController? _youtubeController;
//   VideoPlayerController? _mp4Controller;
//   bool isYouTube = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     if (widget.video.itemLink.contains("youtube.com") ||
//         widget.video.itemLink.contains("youtu.be") ||
//         widget.video.itemLink.contains("/embed/")) {
//       isYouTube = true;
//       String videoId = YoutubePlayer.convertUrlToId(widget.video.itemLink) ??
//           widget.video.itemLink.split("/embed/").last;
//       _youtubeController = YoutubePlayerController(
//         initialVideoId: videoId,
//         flags: const YoutubePlayerFlags(
//           autoPlay: true,
//           mute: false,
//         ),
//       );
//     } else {
//       _mp4Controller = VideoPlayerController.network(widget.video.itemLink)
//         ..initialize().then((_) {
//           setState(() {});
//           _mp4Controller!.play();
//         });
//     }
//   }
//
//   @override
//   void dispose() {
//     _youtubeController?.dispose();
//     _mp4Controller?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.pop(context);
//         return false;
//       },
//       child: Scaffold(
//           appBar: PrimaryAppBar(
//             widget.video.itemTitle,
//             centerTitle: false,
//             appbarSize: Dimensions.heightSize * 4,
//           ),
//           body: _bodyWidget(context)),
//     );
//   }
//
//   Widget _bodyWidget(BuildContext context) {
//     if (isYouTube) {
//       return YoutubePlayerBuilder(
//         player: YoutubePlayer(
//           controller: _youtubeController!,
//           liveUIColor: Colors.amber,
//           showVideoProgressIndicator: true,
//         ),
//         builder: (context, player) => ListView(
//           children: [player],
//         ),
//       );
//     } else {
//       return _mp4Controller != null && _mp4Controller!.value.isInitialized
//           ? AspectRatio(
//         aspectRatio: _mp4Controller!.value.aspectRatio,
//         child: VideoPlayer(_mp4Controller!),
//       )
//           : const Center(child: CircularProgressIndicator());
//     }
//   }
// }


import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

import '../../backend/model/dashboard/dashboard_model.dart';
import '../../utils/basic_screen_imports.dart';

class VideoScreenMobile extends StatefulWidget {
  const VideoScreenMobile({super.key, required this.video});

  final Video video;

  @override
  State<VideoScreenMobile> createState() => _VideoScreenMobileState();
}

class _VideoScreenMobileState extends State<VideoScreenMobile> {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _mp4Controller;
  ChewieController? _chewieController;
  bool isYouTube = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    final link = widget.video.itemLink;
    if (link.contains("youtube.com") ||
        link.contains("youtu.be") ||
        link.contains("/embed/")) {
      isYouTube = true;
      String videoId = YoutubePlayer.convertUrlToId(link) ?? link.split("/embed/").last;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      _mp4Controller = VideoPlayerController.network(link)
        ..initialize().then((_) {
          _chewieController = ChewieController(
            videoPlayerController: _mp4Controller!,
            autoPlay: true,
            looping: false,
            aspectRatio: _mp4Controller!.value.aspectRatio,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  'Error loading video',
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          );
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    _chewieController?.dispose();
    _mp4Controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          widget.video.itemTitle,
          centerTitle: false,
          appbarSize: Dimensions.heightSize * 4,
        ),
        body: _buildVideoPlayer(),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (isYouTube) {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController!,
          liveUIColor: Colors.amber,
          showVideoProgressIndicator: true,
        ),
        builder: (context, player) => ListView(
          padding: EdgeInsets.zero,
          children: [player],
        ),
      );
    } else {
      if (_chewieController != null &&
          _chewieController!.videoPlayerController.value.isInitialized) {
        return Chewie(controller: _chewieController!);
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    }
  }
}


