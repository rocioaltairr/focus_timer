import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/data_model.dart';

class ClockWidget extends StatefulWidget {
  final screenHeight;
  final screenWidth;

  const ClockWidget({super.key, required this.screenHeight, required this.screenWidth});
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  Timer? _timer;
  int appBarHeight = 100;

  @override
  void initState() {
    super.initState();
    _startCountdown();

    Provider.of<DataModel>(context,listen: false).addListener(_resetTimer);
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (Provider.of<DataModel>(context, listen: false).isRunning) {
        int seconds = Provider.of<DataModel>(context, listen: false).time;
        if (seconds > 0) {
          Provider.of<DataModel>(context, listen: false).setTime(seconds - 1);
        } else {
          _timer?.cancel(); // Stop the countdown when it reaches zero
        }
      } else {
       // _timer?.cancel(); // Stop the timer if isRunning is false
      }
    });
  }

  void _resetTimer() {
    if (Provider.of<DataModel>(context, listen: false).reset) {
      Provider.of<DataModel>(context, listen: false).setTime(25 * 60); // Reset time to 25 minutes in seconds
      Provider.of<DataModel>(context, listen: false).setIsRunning(false); // Stop the timer
      Provider.of<DataModel>(context, listen: false).setReset(false);
    }
  }

  @override
  Widget build(BuildContext context) {

    double textSize = 80;
    return SizedBox(
      width: 160,
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                width: textSize,
                height: 110,
                child:
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    '${(Provider.of<DataModel>(context).time/60/10).toInt()}',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ),
              SizedBox(
                width: textSize,
                height: 110,
                child:
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    '${(Provider.of<DataModel>(context).time%60/10).toInt()}',
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
              SizedBox(
                width: textSize,
                height: 110,
                child:
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    '${(Provider.of<DataModel>(context).time/60%10).toInt()}',
                    style: const TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ),
              SizedBox(
                width: textSize,
                height: 110,
                child:
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    '${(Provider.of<DataModel>(context).time%60%10).toInt()}',
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




