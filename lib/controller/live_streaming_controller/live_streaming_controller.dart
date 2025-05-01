import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../ radio_controller.dart';
import '../../backend/model/dashboard/live_show_model.dart';
import '../../backend/services/dashboard_services/dashboard_service.dart';
import '../../main.dart';
import '../../utils/basic_screen_imports.dart';
import 'package:audio_service/audio_service.dart';



import 'package:rxdart/rxdart.dart' as rxd;
import 'package:get/get.dart'; // Or wherever your Get imports are


class LiveStreamingController extends GetxController with DashboardService {
  var setVolumeValue = 1.0.obs;
  final currentBitrate = "00kbps".obs;
  RxString radioUrl = ''.obs;

  RxString radioImage = ''.obs;
  RxString radioId = ''.obs;
  RxString radioTitle = ''.obs;
  RxString radioHost = ''.obs;
  RxString radioAlbum = ''.obs;


  final songInfoUrl =
      "http://surilive.com:8000/currentsong?sid=1"; // song info url

  final defaultArtwork =
      "https://i.ibb.co.com/JWRXwxnf/7ecde97f-6287-4eef-976f-bd7ad97ebef3.png";

  late StreamSubscription<String> songSubscription;
  late Timer _usageTimer =
      Timer(Duration.zero, () {}); // prevent LateInit crash
  final RxString dataUsage = " 0.00 MB".obs;
  final int assumedBitrateKbps = 64;

  late final AudioPlayer audioPlayer; // Not nullable

  RxBool isPlaying = false.obs;
  RxBool isPlayLoading = false.obs;

  void setVolume(double value) {
    setVolumeValue.value = value;
    audioPlayer.setVolume(value);
  }

  void playRadio() async {
    print('🔄 playRadio() called');
    isPlayLoading.value = true;
    print('🟠 Initial isPlaying value: ${isPlaying.value}');

    if (!isPlaying.value) {
      print('▶️ Attempting to play audio...');
      try {
        isPlaying.value = true;
        startElapsedTimeTracking();
        startUsageTimer();
        await audioPlayer.play();
        print('✅ Audio started playing');
      } catch (e) {
        print('❌ Error playing audio: $e');
      }
    } else {
      print('⏹ Attempting to stop audio...');
      isPlaying.value = false;
      stopElapsedTimeTracking();
      stopUsageTimer();
      await audioPlayer.stop();

      print('🛑 Audio stopped');
    }

    isPlayLoading.value = false;
    print('🔁 Final isPlaying value: ${isPlaying.value}');
  }

  void startUsageTimer() {
    // _usageTimer = Timer.periodic(const Duration(seconds: 1), (_) {
    //   final seconds = audioPlayer.position.inSeconds;
    //   final mb = (assumedBitrateKbps * seconds) / 8 / 1024;
    //   dataUsage.value = "${mb.toStringAsFixed(2)} MB";
    // });

    audioPlayer.positionStream.listen((position) {
      final seconds = position.inSeconds;
      final mb = (assumedBitrateKbps * seconds) / 8 / 1024;
      dataUsage.value = "${mb.toStringAsFixed(2)} MB";
    });


  }

  void stopUsageTimer() {
    if (_usageTimer.isActive) {
      _usageTimer.cancel();
    }
  }


  // Stream<PositionData> get PositionDataStream =>
  //     rxd.Rx.combineLatest2<Duration, Duration, PositionData>(
  //       audioPlayer.positionStream,
  //       audioPlayer.bufferedPositionStream,
  //           (position, buffered) => PositionData(position, buffered, Duration.zero),
  //     );


  /// A stream that emits only the current playback position.
  // Stream<Duration> get elapsedTimeStream => audioPlayer.positionStream;


  // final currentPosition = ValueNotifier<Duration>(Duration.zero);




  // Rx<Duration> elapsedTime = Duration.zero.obs;  // Make the elapsed time reactive
  // Timer? _timer;
  //
  // /// Start emitting elapsed time manually
  // void startElapsedTimeTracking() {
  //   print("Starting elapsed time tracking..."); // DEBUG
  //   _timer?.cancel(); // Cancel previous timer if any
  //   _timer = Timer.periodic(const Duration(seconds: 1), (_) {
  //     final position = audioPlayer.position;
  //     print("Current position: $position"); // DEBUG
  //
  //     // Update the reactive variable
  //     elapsedTime.value = position;
  //   });
  // }
  //
  // /// Stop emitting elapsed time
  // void stopElapsedTimeTracking() {
  //   _timer?.cancel();
  //   _timer = null;
  // }



  final _elapsedTimeController = StreamController<Duration>.broadcast();
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  /// Start emitting incrementing durations
  void startElapsedTimeTracking() {
    print("Starting elapsed time tracking...");
    _timer?.cancel(); // Cancel previous timer if any
    _elapsed = Duration.zero; // Reset elapsed time

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed += const Duration(seconds: 1);
      print("Mimicked elapsed: $_elapsed");
      _elapsedTimeController.add(_elapsed);
    });
  }

  /// Stop emitting time
  void stopElapsedTimeTracking() {
    _timer?.cancel();
    _timer = null;
  }

  /// Custom stream for UI
  Stream<Duration> get elapsedTimeStream => _elapsedTimeController.stream;



  Stream<Duration> get safeElapsedTimeStream => Stream.periodic(
    Duration(seconds: 1),
        (_) => audioPlayer.position,
  );








  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    liveShowProcess();


    String title = 'starting';
    String artist = "Connecting";
    songSubscription = songInfoStream().listen((text) async {
      if (text.contains(" - ")) {
        final parts = text.split(" - ");
        artist = parts[0];
        title = parts[1];
      }

      radioController.updateSong(title, artist);
      update();

      // ✨ Update MediaItem dynamically
    });
  }

  @override
  void dispose() {
    stopElapsedTimeTracking();

    audioPlayer.dispose();
    super.dispose();
  }

  /// Live show state
  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  late LiveShowModel _liveShowModel;

  LiveShowModel get liveShowModel => _liveShowModel;

  Future<LiveShowModel> liveShowProcess() async {
    _isLoading.value = true;
    update();

    await liveShowProcessApi().then((value) async {
      _liveShowModel = value!;

      radioUrl.value = _liveShowModel.data.schedule.first.radioLink;
      radioImage.value = _liveShowModel.data.schedule.first.image;
      radioId.value = _liveShowModel.data.schedule.first.id.toString();
      radioTitle.value = _liveShowModel.data.schedule.first.name;
      radioHost.value = _liveShowModel.data.schedule.first.host;
      radioAlbum.value = _liveShowModel.data.schedule.first.description;

      final playlist = ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse(radioUrl.value),
            headers: {
              'User-Agent': 'Apintie App/5.0',
              // Replace 1.0 with your app's version
            },
            tag: MediaItem(
              id: radioId.value,
              title: radioTitle.value,
              artist: radioHost.value,
              album: radioAlbum.value,
              artUri: Uri.parse(
                  "https://i.ibb.co.com/JWRXwxnf/7ecde97f-6287-4eef-976f-bd7ad97ebef3.png"),
            ),
          ),
        ],
      );

      await audioPlayer.setLoopMode(LoopMode.all);
      await audioPlayer.setAudioSource(playlist);

      fetchAndSetSongInfo();

    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _liveShowModel;
  }

  Stream<String> songInfoStream() async* {
    while (true) {
      try {
        final response = await http.get(Uri.parse(songInfoUrl));
        if (response.statusCode == 200) {
          yield response.body.trim();
        }
      } catch (e) {
        print("Error fetching song info: $e");
      }
      await Future.delayed(Duration(seconds: 10)); // Delay between fetches
    }
  }

  Future<void> fetchAndSetSongInfo() async {
    try {
      final response = await http.get(Uri.parse(songInfoUrl));
      if (response.statusCode == 200) {
        final text = response.body.trim();
        if (text.contains(" - ")) {
          final parts = text.split(" - ");
          final fetchedArtist = parts[0].trim();
          final fetchedTitle = parts[1].trim();

          radioController.updateSong(fetchedTitle, fetchedArtist);
          try {
            await audioPlayer.setAudioSource(
              AudioSource.uri(
                Uri.parse("https://surilive.com:8000/stream"),
                // headers: {
                //   'User-Agent': 'Apintie App/5.0',      // your existing UA
                //   'Content-Type': 'audio/mpeg',         // hint iOS about the format
                //   'Range': 'bytes=0-',                  // force byte-range mode
                // },

                tag: MediaItem(
                    id: "1",
                    title: fetchedTitle,
                    artist: fetchedArtist,
                    artUri: Uri.parse(
                        "https://i.ibb.co.com/JWRXwxnf/7ecde97f-6287-4eef-976f-bd7ad97ebef3.png")),
              ),
              preload: false,
            );
          } catch (e) {
            print("Error setting audio source: $e");
          }
          update(); // Assuming this is a GetX method
          print("Updated song: Artist - $fetchedArtist, Title - $fetchedTitle");
        } else {
          print("Could not extract artist and title from: $text");
        }
      } else {
        print("Error fetching song info: HTTP status ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching song info: $e");
    }
  }
}

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}




class PositionTicker {
  final _controller = StreamController<Duration>.broadcast();
  Timer? _timer;
  int _seconds = 0;

  Stream<Duration> get stream => _controller.stream;

  void start() {
    _timer ??= Timer.periodic(Duration(seconds: 1), (_) {
      _seconds++;
      _controller.add(Duration(seconds: _seconds));
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void reset() {
    _seconds = 0;
    _controller.add(Duration.zero);
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}


