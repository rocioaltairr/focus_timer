import 'package:flutter/material.dart';

int _oneMinSeconds = 10;
int _oneSessionMin = 1;

class DataModel extends ChangeNotifier {

  // Time
  bool _isRunning = false;
  int _time = _oneSessionMin * _oneMinSeconds;
  int _selectTimeIndex = 0; // (4+1)*5 = 25 min
  int _breakTime = _oneSessionMin * _oneMinSeconds;
  int _selectBreakTimeIndex = 0; // (0+1)*5 = 5 min

  Color _currentColor = Colors.amber;
  List<Color> _currentColors = [Colors.yellow, Colors.green];
  bool _reset = false;
  bool _isFocusTime = true;

  // Music, Bell
  bool _isChangeMusic = false;
  bool _isPlayingMusic = true;
  bool _isPlayingBell = true;
  String _currentMusic = "assets/sounds/rain_thunder_storm.mp3";
  String _currentBell = "cockerel.mp3";

  // Time
  get isRunning => _isRunning;
  get time => _time;
  get selectTimeIndex => _selectTimeIndex;
  get breakTime => _breakTime;
  get selectBreakTimeIndex => _selectBreakTimeIndex;

  get currentColor => _currentColor;
  get currentColors => _currentColors;
  get reset => _reset;
  get isFocusTime => _isFocusTime;

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

  void setBreakTime(int setBreakTime) {
    _breakTime = setBreakTime;
    notifyListeners();
  }

  void setBreakTimeIndex(int setBreakTimeIndex) {
    _selectBreakTimeIndex = setBreakTimeIndex;
    notifyListeners();
  }

  void setIsRunning(bool setIsRunning) {
    _isRunning = setIsRunning;
    notifyListeners();
  }

  void setIsFocusTime(bool setIsFocusTime) {
    _isFocusTime = setIsFocusTime;
    notifyListeners();
  }

  void resetTimer() {
    _reset = true;
    _isRunning = false;
    // _time = 25*60;
    if (isFocusTime) {
      _time = (_selectTimeIndex+1) * _oneMinSeconds;
     // print("reset isFocusTime $_time");
    } else {
      _time = (_selectBreakTimeIndex+1) * _oneMinSeconds;
     // print("reset not isFocusTime $_time");
    }
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
    //_isRunning = false;
    if (isFocusTime) {
      _time = (_selectTimeIndex+1) * _oneMinSeconds;
      //print("reset isFocusTime $_time");
    } else {
      _time = (_selectBreakTimeIndex+1) * _oneMinSeconds;
      //print("reset not isFocusTime $_time");
    }
    notifyListeners();
  }
}