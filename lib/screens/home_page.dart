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
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   Provider.of<DataModel>(context, listen: false).addListener(() {
    //     if (Provider.of<DataModel>(context, listen: false).isChangeMusic &&
    //         Provider.of<DataModel>(context, listen: false).isRunning &&
    //         Provider.of<DataModel>(context, listen: false).isPlayingMusic) {
    //       print("initState == play 1");
    //       assetsAudioPlayer.open(
    //         Audio(Provider.of<DataModel>(context, listen: false).currentMusic),
    //         autoStart: false,
    //         showNotification: false,
    //       );
    //       assetsAudioPlayer.play();
    //       Provider.of<DataModel>(context).setChangeMusic(false);
    //     }
    //   });
    // });
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
          //title: Text(Provider.of<DataModel>(context, listen: true).time.toString()),
          leading: IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.push(context, BottomToTopPageRoute(page: SettingPage()));
            },
          ),
          // actions: <Widget> [
          //   IconButton(
          //     icon: const Icon(Icons.book),
          //     tooltip: 'Show Snackbar',
          //     onPressed: () {
          //       Navigator.pushNamed(context, "/bookListPage");
          //     },
          //   ),
          // ]
        ),
        body: Consumer<DataModel>(
          builder: (context, model, child) {
            if (model.isPlayingMusic && model.isRunning) {
              print("open");
              try {
                //assetsAudioPlayer.setLoopMode(LoopMode.single);
                assetsAudioPlayer.play();
              } catch (t) {
                //stream unreachable
              }
            } else {
              try {
                assetsAudioPlayer.pause();
                print("close");
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
                        color: Colors.black, // Color of the animated container
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
                    Positioned(
                      top: screenHeight - 200,
                      left: screenWidth/2 - 40,
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
                          int time = (timeIndex+1) * 5 * 60;

                          Provider.of<DataModel>(context, listen: false).setReset(true);
                          Provider.of<DataModel>(context, listen: false).setIsRunning(false);
                          Provider.of<DataModel>(context, listen: false).setTimeIndex(timeIndex);
                          Provider.of<DataModel>(context, listen: false).setTime(time);
                          Provider.of<DataModel>(context, listen: false).setPlayingMusic(false);
                        },
                        child: const Text('Quit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      top: (screenHeight)/2 - appBarHeight - buttonSize/2,
                      left: (screenWidth)/2 - buttonSize/2,
                      child: IconButton(
                        icon: (Provider.of<DataModel>(context, listen: false).isRunning) ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
                        iconSize: 48,// Icon to display
                        onPressed: () {
                          // TODO: why set true have problem?
                          bool running = Provider.of<DataModel>(context, listen: false).isRunning;
                          Provider.of<DataModel>(context, listen: false).setIsRunning(!running);
                          // Stop and Start
                        },
                      ),
                    ),
                  ],
                )
            );
          }
        )

    );
  }
}
