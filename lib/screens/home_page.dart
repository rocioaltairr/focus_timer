import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:focus_timer/screens/setting_page.dart';
import 'package:provider/provider.dart';
import 'package:route_panel/route_panel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/circular_animation.dart';
import '../components/clock.dart';
import '../components/clock_painter.dart';
import '../models/data_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

int _oneMinSeconds = 10;
int _oneSessionMin = 1;

class _HomePageState extends State<HomePage> {
  int appBarHeight = 100;
  double circleBorder = 30;
  double buttonSize = 64;
  final assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  final sharePreference = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    print("initState == 1");
    assetsAudioPlayer.open(
      Audio(Provider.of<DataModel>(context, listen: false).currentMusic),
      autoStart: false,
      showNotification: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color currentColor = Provider.of<DataModel>(context, listen: false).currentColor;
    double circleWidth = screenWidth * 2 / 5;
    double innerCircleTop = (screenHeight)/2 - circleWidth - 100 + circleBorder/2;
    double innerCircleLeft = (screenWidth)/2 - circleWidth + circleBorder/2;
    double innerCircleWidth = screenWidth * 4 / 5 - circleBorder;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(context, BottomToTopPageRoute(page: SettingPage()));
            },
          ),
        ),
        body: Consumer<DataModel>(
          builder: (context, model, child) {
            if (model.isPlayingMusic && model.isRunning) {
              try {
                //assetsAudioPlayer.setLoopMode(LoopMode.single);
                assetsAudioPlayer.play();
              } catch (t) {
                print('Error play audio player: $t');
              }
            } else {
              try {
                assetsAudioPlayer.pause();
              } catch (error) {
                print('Error stopping audio player: $error');
              }
            }

            /// Change music
            if (model.isChangeMusic && model.isRunning && model.isPlayingMusic) {
              print("initState == play 1");
              assetsAudioPlayer.open(
                Audio(Provider.of<DataModel>(context, listen: false).currentMusic),
                autoStart: false,
                showNotification: false,
              );
              assetsAudioPlayer.play();
              Provider.of<DataModel>(context).setChangeMusic(false);
            }
            return Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      child: CustomPaint(
                        painter: ClockPainter(screenHeight, screenWidth, currentColor),
                      ),
                    ),
                    Positioned(
                      top: innerCircleTop,
                      left: innerCircleLeft,
                      child: CircularRevealAnimation(
                        isRunning: Provider.of<DataModel>(context, listen: false).isRunning,
                        duration: Duration(seconds: Provider.of<DataModel>(context, listen: true).time), // Duration of the animation
                        size: Size(innerCircleWidth, innerCircleWidth),
                        color: Colors.grey.withOpacity(0.3), // Color of the animated container
                      ),
                    ),
                    Positioned(
                      top: screenHeight / 2 - appBarHeight - 110,
                      left: screenWidth / 2  - 80,
                      child:
                      ClockWidget(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth
                      ),
                    ),
                    (Provider.of<DataModel>(context, listen: false).isFocusTime) ?
                    Positioned(
                      top: screenHeight - 200,
                      left: 40,
                      child: SizedBox(
                        width: screenWidth - 80,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.resolveWith<BorderSide>(
                                        (Set<MaterialState> states) {
                                      return const BorderSide(color: Colors.white);
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  bool running = Provider.of<DataModel>(context, listen: false).isRunning;
                                  Provider.of<DataModel>(context, listen: false).setIsRunning(true);
                                },
                                child: const Text('Play',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.resolveWith<BorderSide>(
                                        (Set<MaterialState> states) {
                                      return const BorderSide(color: Colors.white);
                                    },
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<DataModel>(context, listen: false).setIsRunning(false);
                                },
                                child: const Text('Pause',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                                child: OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.resolveWith<BorderSide>(
                                          (Set<MaterialState> states) {
                                        return const BorderSide(color: Colors.white);
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    int timeIndex = (Provider.of<DataModel>(context, listen: false).selectTimeIndex);
                                    int time = (timeIndex+1) * _oneSessionMin * _oneMinSeconds;
                                    print("setTime3");
                                    Provider.of<DataModel>(context, listen: false).setReset(true);
                                    Provider.of<DataModel>(context, listen: false).setIsRunning(false);
                                    Provider.of<DataModel>(context, listen: false).resetTimer();
                                    Provider.of<DataModel>(context, listen: false).setPlayingMusic(false);
                                  },
                                  child: const Text('Quit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                            )
                          ],
                        ),
                      )
                    ) : Positioned(
                        top: screenHeight - 200,
                        left: 40,
                        child: SizedBox(
                          width: screenWidth - 80,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.resolveWith<BorderSide>(
                                            (Set<MaterialState> states) {
                                          return const BorderSide(color: Colors.white);
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      print("Start Break");
                                      //Provider.of<DataModel>(context, listen: false).setReset(true);
                                      Provider.of<DataModel>(context, listen: false).setIsRunning(true);
                                    },
                                    child: const Text('Start Break',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Expanded(
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.resolveWith<BorderSide>(
                                            (Set<MaterialState> states) {
                                          return const BorderSide(color: Colors.white);
                                        },
                                      ),
                                    ),
                                    onPressed: () {
                                      Provider.of<DataModel>(context, listen: false).setIsFocusTime(true);
                                      Provider.of<DataModel>(context, listen: false).resetTimer();
                                    },
                                    child: const Text('Skip',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                              )
                            ],
                          ),
                        )
                    ),
                  ],
                )
            );
          }
        )

    );
  }
}
