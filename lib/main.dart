import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as google_mobile_ads;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

import 'banner_ad.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  google_mobile_ads.MobileAds.instance.initialize();
  runApp(MyApp());
}

const simpleTaskKey = "simpleTask";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTaskKey:
        print("$simpleTaskKey was executed. inputData = $inputData");
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("test", true);
        print("Bool from prefs: ${prefs.getBool("test")}");
        break;
    }

    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum _Platform { android, ios }

class PlatformEnabledButton extends ElevatedButton {
  final _Platform platform;

  PlatformEnabledButton({
    required this.platform,
    required Widget child,
    required VoidCallback onPressed,
  }) : super(
            child: child,
            onPressed:
                (Platform.isAndroid && platform == _Platform.android || Platform.isIOS && platform == _Platform.ios)
                    ? onPressed
                    : null);
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter WorkManager Example"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                BannerAd(
                  google_mobile_ads.BannerAd.testAdUnitId,
                  adSize: google_mobile_ads.AdSize.largeBanner,
                ),
                Text(
                  "Plugin initialization",
                  style: Theme.of(context).textTheme.headline5,
                ),
                ElevatedButton(
                  child: Text("Start the Flutter background service"),
                  onPressed: () {
                    Workmanager().initialize(
                      callbackDispatcher,
                      isInDebugMode: true,
                    );
                  },
                ),
                SizedBox(height: 16),
                //This task runs once.
                //Most likely this will trigger immediately

                Text(
                  "One Off Tasks (Android only)",
                  style: Theme.of(context).textTheme.headline5,
                ),
                //This task runs once.
                //Most likely this will trigger immediately
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Register OneOff Task"),
                  onPressed: () {
                    Workmanager().registerOneOffTask(
                      "1",
                      simpleTaskKey,
                      inputData: <String, dynamic>{
                        'int': 1,
                        'bool': true,
                        'double': 1.0,
                        'string': 'string',
                        'array': [1, 2, 3],
                      },
                    );
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
                PlatformEnabledButton(
                  platform: _Platform.android,
                  child: Text("Fake button"),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
