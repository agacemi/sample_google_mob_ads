import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as google_mob_ads;

class NativeAd extends StatefulWidget {
  final String adUnitId;
  final String adFactoryId;
  final double height;
  final double? width;
  final Map<String, String> targeting;
  final Widget emptyState;
  final VoidCallback onAdLoaded;

  const NativeAd({
    required this.adUnitId,
    required this.adFactoryId,
    required this.height,
    required this.onAdLoaded,
    this.width,
    this.targeting = const {},
    this.emptyState = const SizedBox.shrink(),
    Key? key,
  }) : super(key: key);

  @override
  NativeAdState createState() => NativeAdState();
}

class NativeAdState extends State<NativeAd> {
  late google_mob_ads.NativeAd _ad;
  bool _isAdLoaded = false;

  @override
  Widget build(BuildContext context) => _isAdLoaded
      ? Container(
          child: google_mob_ads.AdWidget(ad: _ad),
          width: widget.width,
          height: widget.height,
          alignment: Alignment.center,
        )
      : widget.emptyState;

  @override
  void initState() {
    super.initState();
    _initAds();
  }

  @override
  void dispose() {
    if (_isAdLoaded) {
      _ad.dispose();
    }
    super.dispose();
  }

  void _initAds() {
    _ad = google_mob_ads.NativeAd.fromAdManagerRequest(
      adUnitId: widget.adUnitId,
      factoryId: widget.adFactoryId,
      adManagerRequest: google_mob_ads.AdManagerAdRequest(customTargeting: widget.targeting),
      listener: google_mob_ads.NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
            widget.onAdLoaded();
          });
        },
        onAdFailedToLoad: (ad, error) async {
          await ad.dispose();
          debugPrint('${widget.adUnitId}: $error');
        },
      ),
    );

    _ad.load();
  }
}
