import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class Noti{
//   static Future initialize(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize = new AndroidInitializationSettings('mipmap/ic_launcher');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     var initializationSettings = new InitializationSettings(android: androidInitialize,
//         iOS: DarwinInitializationSettings);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }
// }