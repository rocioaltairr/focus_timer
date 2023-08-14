import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  // Time
  int _time = 25 * 60;
  bool _isRunning = false;
  int _selectTimeIndex = 4; // (4+1)*5 = 25 min

  Color _currentColor = Colors.amber;
  List<Color> _currentColors = [Colors.yellow, Colors.green];
  bool _reset = false;

  // Music, Bell
  bool _isChangeMusic = false;
  bool _isPlayingMusic = false;
  bool _isPlayingBell = false;
  String _currentMusic = "assets/sounds/rain_thunder_storm.mp3";
  String _currentBell = "assets/sounds/rain_thunder_storm.mp3";

  // Time
  get time => _time;
  get isRunning => _isRunning;
  get selectTimeIndex => _selectTimeIndex;

  get currentColor => _currentColor;
  get currentColors => _currentColors;
  get reset => _reset;

  // Music, Bell
  get isChangeMusic => _isChangeMusic;
  get isPlayingMusic => _isPlayingMusic;
  get isPlayingBell => _isPlayingBell;
  get currentMusic => _currentMusic;
  get currentBell => _currentBell;

  // Time
  void setTime(int setTime) {
    _time = setTime;
    notifyListeners();
  }

  void setTimeIndex(int setTimeIndex) {
    _selectTimeIndex = setTimeIndex;
    notifyListeners();
  }

  void setIsRunning(bool setIsRunning) {
    _isRunning = setIsRunning;
    notifyListeners();
  }

  void resetTimer() {
    _reset = true;
    _isRunning = false;
    _time = 25*60;
  }

  // Color
  void setColor(Color setColor) {
    _currentColor = setColor;
    notifyListeners();
  }

  void setColors(List<Color> setColors) {
    _currentColors = setColors;
    notifyListeners();
  }

  // Music, Bell
  void setChangeMusic(bool isChangeMusic) {
    _isChangeMusic = isChangeMusic;
    notifyListeners();
  }

  void setPlayingMusic(bool isPlaying) {
    _isPlayingMusic = isPlaying;
    notifyListeners();
  }

  void setPlayingBell(bool isPlaying) {
    _isPlayingBell = isPlaying;
    notifyListeners();
  }

  void setMusic(String setMusic) {
    _currentMusic = setMusic;
    notifyListeners();
  }

  void setBell(String setBell) {
    _currentBell = setBell;
    notifyListeners();
  }


  void setReset(bool setReset) {
    _reset = setReset;
    _isRunning = false;
    _time = 25 * 60;
    notifyListeners();
  }
}