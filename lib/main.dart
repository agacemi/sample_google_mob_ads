import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as google_mobile_ads;
import 'package:mobile_ads_issue_sample/native_ad.dart';

import 'banner_ad.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  google_mobile_ads.MobileAds.instance.initialize();
  runApp(MyApp());
}

const simpleTaskKey = "simpleTask";

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
          title: Text("Ads Issues Sample"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text("Banner Ad - First Ad", style: Theme.of(context).textTheme.headline6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: BannerAd(
                    '/5813/FRfr-ANDROID/HP/BANNER_1',
                    adSize: google_mobile_ads.AdSize.largeBanner,
                  ),
                ),
                Divider(),
                Text("Native Ad - Vertical Template", style: Theme.of(context).textTheme.headline6),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: NativeAd(
                    adUnitId: '/5813/FRfr-ANDROID/HP/BP_1',
                    height: 300,
                    adFactoryId: 'vertical_template',
                    onAdLoaded: () {},
                  ),
                ),
                Divider(),
                Text("Native Ad - Horizontal Template", style: Theme.of(context).textTheme.headline6),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: NativeAd(
                    adUnitId: '/5813/FRfr-ANDROID/HP/BP_2',
                    height: 140,
                    adFactoryId: 'horizontal_template',
                    onAdLoaded: () {},
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: NativeAd(
                    adUnitId: '/5813/FRfr-ANDROID/HP/BP_3',
                    height: 140,
                    adFactoryId: 'horizontal_template',
                    onAdLoaded: () {},
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: NativeAd(
                    adUnitId: '/5813/FRfr-ANDROID/HP/BP_4',
                    height: 140,
                    adFactoryId: 'horizontal_template',
                    onAdLoaded: () {},
                  ),
                ),
                Divider(),
                Text("Stretch Ad not working :(", style: Theme.of(context).textTheme.headline6),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: BannerAd(
                    '/5813/FRfr-ANDROID/HP/STICKY',
                  ),
                ),
                Divider(),
                Text("However using Google banner test, works well", style: Theme.of(context).textTheme.headline6),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: BannerAd(
                    google_mobile_ads.BannerAd.testAdUnitId,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
