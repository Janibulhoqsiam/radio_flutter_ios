// import 'package:audio_service/audio_service.dart';
// import 'package:rxdart/rxdart.dart'; // <- Add this package
//
// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:rxdart/rxdart.dart'; // For BehaviorSubject
//
// class MyAudioHandler extends BaseAudioHandler {
//   final AudioPlayer player;
//   final BehaviorSubject<MediaItem> _mediaItemSubject = BehaviorSubject<MediaItem>();
//
//   MyAudioHandler(this.player) {
//     // Send initial empty media item
//     mediaItem.add(
//       MediaItem(
//         id: "1",
//         title: "Loading...",
//         artist: "Loading...",
//         artUri: Uri.parse("https://i.ibb.co.com/JWRXwxnf/7ecde97f-6287-4eef-976f-bd7ad97ebef3.png"),
//       ),
//     );
//
//     // Listen to player events to sync state
//     player.playerStateStream.listen((state) {
//       final playing = state.playing;
//       final processingState = _mapProcessingState(state.processingState);
//
//       playbackState.add(
//         PlaybackState(
//           controls: [
//             MediaControl.rewind,
//             if (playing) MediaControl.pause else MediaControl.play,
//             MediaControl.stop,
//           ],
//           androidCompactActionIndices: const [0, 1, 2],
//           processingState: processingState,
//           playing: playing,
//           updatePosition: player.position,
//           bufferedPosition: player.bufferedPosition,
//           speed: player.speed,
//           queueIndex: 0,
//         ),
//       );
//     });
//   }
//
//   // Function to manually update media item (title, artist, etc.)
//   Future<void> updateMediaInfo({
//     required String title,
//     required String artist,
//     required String artUri,
//   }) async {
//     final newMediaItem = MediaItem(
//       id: "1",
//       title: title,
//       artist: artist,
//       artUri: Uri.parse(artUri),
//     );
//
//     mediaItem.add(newMediaItem);
//   }
//
//   AudioProcessingState _mapProcessingState(ProcessingState processingState) {
//     switch (processingState) {
//       case ProcessingState.idle:
//         return AudioProcessingState.idle;
//       case ProcessingState.loading:
//         return AudioProcessingState.loading;
//       case ProcessingState.buffering:
//         return AudioProcessingState.buffering;
//       case ProcessingState.ready:
//         return AudioProcessingState.ready;
//       case ProcessingState.completed:
//         return AudioProcessingState.completed;
//     }
//   }
// }
//

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player;

  MyAudioHandler(this._player) {
    // Listen to playback state
    _player.playbackEventStream.listen(_broadcastState);

    // Set initial media item (optional)
    mediaItem.add(
      MediaItem(
        id: "1",
        title: "Starting...",
        artist: "Connecting...",
        artUri: Uri.parse("https://i.ibb.co.com/JWRXwxnf/7ecde97f-6287-4eef-976f-bd7ad97ebef3.png"),
      ),
    );
  }

  Future<void> updateMediaInfo({
    required String title,
    required String artist,
    required String artUri,
  }) async {
    final item = MediaItem(
      id: "1",
      title: title,
      artist: artist,
      artUri: Uri.parse(artUri),
    );
    mediaItem.add(item);
  }

  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.rewind,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
        ],
        androidCompactActionIndices: const [0, 1, 2],
        playing: playing,
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: _player.currentIndex,
      ),
    );
  }
}

