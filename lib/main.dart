import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_timer/screens/book_list_page.dart';
import 'package:focus_timer/screens/home_page.dart';
import 'package:provider/provider.dart';

import 'models/data_model.dart';
import 'screens/setting_page.dart';

void main() {
  AssetsAudioPlayer.setupNotificationsOpenAction((notification) {
    return true;
  });
  runApp(
      ChangeNotifierProvider(
        create:(_) => DataModel(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    _portraitModeOnly();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Provider.of<DataModel>(context,listen: true).currentColor,
        appBarTheme: AppBarTheme(
            backgroundColor: Provider.of<DataModel>(context,listen: true).currentColor
        ),
      ),
      initialRoute: "/",
      routes: {
        '/': (context) => HomePage(),
        '/setting': (context) => SettingPage(),
        '/bookListPage': (context) => bookListPage(),
      },
    );
  }

  /// blocks rotation; sets orientation to: portrait
  void _portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}