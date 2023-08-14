// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class SoundPlayerWidget extends StatefulWidget {
//   final String audioFilePath;
//
//   SoundPlayerWidget({required this.audioFilePath});
//
//   @override
//   _SoundPlayerWidgetState createState() => _SoundPlayerWidgetState();
// }
//
// class _SoundPlayerWidgetState extends State<SoundPlayerWidget> {
//   late AudioPlayer _audioPlayer;
//
//   @override
//   void initState() {
//     super.initState();
//     _audioPlayer = AudioPlayer();
//   }
//
//   Future<void> _playAudio() async {
//     int result = await _audioPlayer.play(widget.audioFilePath);
//     if (result == 1) {
//       print('_playAudio');
//     }
//   }
//
//   Future<void> _pauseAudio() async {
//     int result = await _audioPlayer.pause();
//     if (result == 1) {
//     }
//   }
//
//   Future<void> _stopAudio() async {
//     int result = await _audioPlayer.stop();
//     if (result == 1) {
//     }
//   }
//
//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       width: 400,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           ElevatedButton(
//             onPressed: _playAudio,
//             child: const Text('Play'),
//           ),
//           ElevatedButton(
//             onPressed: _pauseAudio,
//             child: const Text('Pause'),
//           ),
//           ElevatedButton(
//             onPressed: _stopAudio,
//             child: const Text('Stop'),
//           ),
//         ],
//       ),
//     );
//   }
// }
