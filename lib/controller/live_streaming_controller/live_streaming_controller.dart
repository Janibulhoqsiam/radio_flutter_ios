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
        await audioPlayer.play();
        startUsageTimer();
        print('✅ Audio started playing');
      } catch (e) {
        print('❌ Error playing audio: $e');
      }
    } else {
      print('⏹ Attempting to stop audio...');
      isPlaying.value = false;
      await audioPlayer.stop();
      stopUsageTimer();
      print('🛑 Audio stopped');
    }

    isPlayLoading.value = false;
    print('🔁 Final isPlaying value: ${isPlaying.value}');
  }

  void startUsageTimer() {
    _usageTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final seconds = audioPlayer.position.inSeconds;
      final mb = (assumedBitrateKbps * seconds) / 8 / 1024;
      dataUsage.value = "${mb.toStringAsFixed(2)} MB";
    });
  }

  void stopUsageTimer() {
    if (_usageTimer.isActive) {
      _usageTimer.cancel();
    }
  }

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
    audioPlayer.dispose();
    if (_usageTimer.isActive) {
      _usageTimer.cancel();
    }
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

      // songInfoStream(withDelay: false).listen((text) {
      //   if (text.contains(" - ")) {
      //     final parts = text.split(" - ");
      //     artist = parts[0];
      //     title = parts[1];
      //   }
      //   radioController.updateSong(title, artist);
      //   audioPlayer.setAudioSource(
      //     AudioSource.uri(
      //       Uri.parse("https://surilive.com:8000/stream"),
      //       tag: MediaItem(
      //           id: "1",
      //           title: title,
      //           artist: artist,
      //           artUri: Uri.parse(
      //               "https://i.ibb.co.com/JWRXwxnf/7ecde97f-6287-4eef-976f-bd7ad97ebef3.png")),
      //     ),
      //     preload: false,
      //   );
      //   update();
      //   print("Received data without delay: $text");
      // });

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
