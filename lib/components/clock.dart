import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/data_model.dart';

int _oneMinSeconds = 10;
int _oneSessionMin = 1;

class ClockWidget extends StatefulWidget {
  final screenHeight;
  final screenWidth;

  const ClockWidget({super.key, required this.screenHeight, required this.screenWidth});
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  Timer? _timer;
  int appBarHeight = 100;
  double textSize = 80;

  @override
  void initState() {
    super.initState();
    print("initState jaja ${Provider.of<DataModel>(context,listen: false).time}");
    _startCountdown();
    Provider.of<DataModel>(context,listen: false).addListener(_resetTimer);
  }

  Future<void> _startCountdown() async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async{
      if (Provider.of<DataModel>(context, listen: false).isRunning) {
        int seconds = Provider.of<DataModel>(context, listen: false).time;
       // print("isRunning seconds $seconds");
        if (seconds > 0) {
          Provider.of<DataModel>(context, listen: false).setTime(seconds - 1);
        } else {
          await _showNotificationCustomSound();
          bool isFocusTime = Provider.of<DataModel>(context, listen: false).isFocusTime;
          Provider.of<DataModel>(context, listen: false).setIsFocusTime(!isFocusTime);
          Provider.of<DataModel>(context, listen: false).resetTimer();
          Provider.of<DataModel>(context, listen: false).setReset(true);
          _timer?.cancel(); // Stop the countdown when it reaches zero
        }
      } else {
       // _timer?.cancel(); // Stop the timer if isRunning is false
      }
    });
  }

  void _resetTimer() {
    if (Provider.of<DataModel>(context, listen: false).reset) {
      _startCountdown();
      Provider.of<DataModel>(context, listen: false).setReset(false);
      Provider.of<DataModel>(context, listen: false).setPlayingMusic(false);
    }
  }

  Future<void> _showNotificationCustomSound() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'your other channel id',
      'your other channel name',
      channelDescription: 'your other channel description',
      sound: RawResourceAndroidNotificationSound('cockerel'),
    );
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      sound: Provider.of<DataModel>(context, listen: false).currentBell,
      presentSound: Provider.of<DataModel>(context, listen: false).isPlayingBell
    );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    if (Provider.of<DataModel>(context, listen: false).isFocusTime) {
      await flutterLocalNotificationsPlugin.show(
        id++,
        'The session is finished',
        'Congratulations!!!',
        notificationDetails,
      );
    } else {
      await flutterLocalNotificationsPlugin.show(
        id++,
        'The break is finished',
        'Lets Start!!!',
        notificationDetails,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                color: Colors.red,
                  width: textSize,
                  height: 110,
                  child:
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      '${(Provider.of<DataModel>(context).time/_oneMinSeconds/10).toInt()}',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
              Container(
                  color: Colors.blue,
                  width: textSize,
                  height: 110,
                  child:
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      '${(Provider.of<DataModel>(context).time%_oneMinSeconds/10).toInt()}',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
            ],
          ),
          Column(
            children: [
              Container(
                  color: Colors.black,
                  width: textSize,
                  height: 110,
                  child:
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      '${(Provider.of<DataModel>(context).time/_oneMinSeconds%10).toInt()}',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
              Container(
                  color: Colors.yellow,
                  height: 110,
                  child:
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      '${(Provider.of<DataModel>(context).time%_oneMinSeconds%10).toInt()}',
                      style: const TextStyle(
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}




