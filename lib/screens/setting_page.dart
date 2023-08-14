import 'package:flutter/material.dart';
import 'package:focus_timer/models/data_model.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../components/color_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  List<String> musicList = [
    'Calm mind',
    'Rain thunder storm',
    'Relaxing'
  ];

  List<String> bellList = [
    'Cow',
    'Chicken',
  ];

  List<String> timeList = [
    '5 min',
    '10 min',
    '15 min',
    '20 min',
    '25 min',
    '30 min',
  ];

  bool _showPanelTime = false;
  bool _showPanelMusic = false;
  bool _showPanelBell = false;

  int selectedIdxMusic = 0;
  int selectedIdxBell = 4;

  @override
  Widget build(BuildContext context) {
    int selectedIdxTime = Provider.of<DataModel>(context).selectTimeIndex.toInt();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Setting'),
          leading: IconButton(
            icon: const Icon(Icons.close), // Change the icon to your desired icon
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: GestureDetector(
          onTap: () {
            setState(() {
              _showPanelTime = false;
              _showPanelMusic = false;
              _showPanelBell = false;
            });
          },
          child: Stack(
            children: [
              ListView(
                children: <Widget>[
                  ListTile(
                    title: const Text("Time"),
                    onTap: () {
                      setState(() {
                        if (_showPanelMusic) _showPanelMusic= false;
                        if (_showPanelBell) _showPanelBell= false;
                        _showPanelTime = !_showPanelTime;
                      });
                    },
                    trailing: Text('${((Provider.of<DataModel>(context).selectTimeIndex+1)*5).toInt()} min',
                      style: const TextStyle(
                        fontSize: 16
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text("Color"),
                    trailing: ColorPicker(),
                  ),
                  ListTile(
                    title: const Text("Music"),
                    trailing: Switch(
                      value: Provider.of<DataModel>(context, listen: false).isPlayingMusic,
                      onChanged: (value) {
                        setState(() {
                          bool _isPlayingMusic = Provider.of<DataModel>(context, listen: false).isPlayingMusic;
                          Provider.of<DataModel>(context, listen: false).setPlayingMusic(!_isPlayingMusic);
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        if (_showPanelTime) _showPanelTime = false;
                        if (_showPanelBell) _showPanelBell = false;
                        _showPanelMusic = !_showPanelMusic;
                      });
                    },
                  ),
                  ListTile(
                    title: const Text("Bell"),
                    trailing: Switch(
                      value: Provider.of<DataModel>(context, listen: false).isPlayingBell,
                      onChanged: (value) {
                        setState(() {
                          bool isPlayingBell = Provider.of<DataModel>(context, listen: false).isPlayingBell;
                          Provider.of<DataModel>(context, listen: false).setPlayingBell(!isPlayingBell);
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        if (_showPanelTime) _showPanelTime = false;
                        if (_showPanelMusic) _showPanelMusic = false;
                        _showPanelBell = !_showPanelBell;
                      });
                    },
                  ),
                ],
              ),
              (_showPanelMusic) ?
              SlidingUpPanel(
                panel: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: musicList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        //TODO detect change music
                        selectedIdxMusic = index;
                        if (index==0) {
                          Provider.of<DataModel>(context, listen: false).setMusic("assets/sounds/please-calm-mind.mp3");
                        } else if (index==1) {
                          Provider.of<DataModel>(context, listen: false).setMusic("assets/sounds/rain_thunder_storm.mp3");
                        } else if (index==2) {
                          Provider.of<DataModel>(context, listen: false).setMusic("assets/sounds/relaxing.mp3");
                        }
                        Provider.of<DataModel>(context, listen: false).setChangeMusic(true);
                      },
                      child: ListTile(
                        title: Text(musicList[index]),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20), // Adjust as needed
                        trailing: selectedIdxMusic == index
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                      ),
                    );
                  },
                ),
                maxHeight: 250,
                minHeight: 250,
              ) : const SizedBox(),

              (_showPanelBell) ?
              SlidingUpPanel(
                panel:  ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bellList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          Provider.of<DataModel>(context, listen: false).setChangeMusic(true);
                          selectedIdxBell = index;
                          if (index==0) {
                            Provider.of<DataModel>(context, listen: false).setMusic("assets/sounds/please-calm-mind.mp3");
                          } else if (index==1) {
                            Provider.of<DataModel>(context, listen: false).setMusic("assets/sounds/rain_thunder_storm.mp3");
                          } else if (index==2) {
                            Provider.of<DataModel>(context, listen: false).setMusic("assets/sounds/relaxing.mp3");
                          }
                        });
                      },
                      child: ListTile(
                        title: Text(bellList[index]),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20), // Adjust as needed
                        trailing: selectedIdxBell == index
                            ? const Icon(Icons.check, color: Colors.green)
                            : null,
                      ),
                    );
                  },
                ),
                maxHeight: 250,
                minHeight: 250,
              ) : const SizedBox(),

              (_showPanelTime) ?
              SlidingUpPanel(
                panel:  SingleChildScrollView(
                  child:  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIdxTime = index;
                            int time = (index + 1) * 5 * 60;
                            Provider.of<DataModel>(context,listen: false).setTimeIndex(index);
                            Provider.of<DataModel>(context,listen: false).setTime(time);
                          });
                        },
                        child: ListTile(
                          title: Text("${(index+1) * 5} min"), // Display the actual time value
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20), // Adjust as needed
                          trailing: selectedIdxTime == index
                              ? const Icon(Icons.check, color: Colors.green)
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                maxHeight: 250,
                minHeight: 250,
              ) : const SizedBox(),
            ],
          )
        )
    );
  }
}


