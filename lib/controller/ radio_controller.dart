import 'package:flutter/material.dart';

class RadioController extends ChangeNotifier {
  String _title = "Loading...";
  String _artist = "Please wait...";

  String get title => _title;
  String get artist => _artist;

  void updateSong(String newTitle, String newArtist) {
    _title = newTitle;
    _artist = newArtist;
    notifyListeners(); // This triggers rebuilds
  }
}

// Global instance
final radioController = RadioController();
