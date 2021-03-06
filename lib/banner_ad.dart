import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart' as google_mob_ads;

class BannerAd extends StatefulWidget {
  final String adUnitId;
  final google_mob_ads.AdSize? adSize;
  final Map<String, String> targeting;
  final Widget emptyState;
  final VoidCallback? onAdLoaded;

  const BannerAd(
    this.adUnitId, {
    this.adSize,
    this.targeting = const {},
    this.emptyState = const SizedBox.shrink(),
    this.onAdLoaded,
    Key? key,
  }) : super(key: key);

  @override
  _BannerAdState createState() => _BannerAdState();
}

class _BannerAdState extends State<BannerAd> {
  late google_mob_ads.AdManagerBannerAd _ad;
  bool _isAdLoaded = false;

  @override
  Widget build(BuildContext context) {
    if (_isAdLoaded) {
      final size = _ad.sizes.first;
      debugPrint('${widget.adUnitId}: Loading Ad: width: ${size.width}, height: ${size.height},');
      return Container(
        child: google_mob_ads.AdWidget(ad: _ad),
        width: size.width.toDouble(),
        height: size.height.toDouble(),
        alignment: Alignment.center,
      );
    } else {
      return widget.emptyState;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initAds();
  }

  @override
  void dispose() {
    if (_isAdLoaded) {
      _ad.dispose();
    }
    super.dispose();
  }

  Future<void> _initAds() async {
    final size = widget.adSize ?? await _adaptiveSize();
    if (size == null) {
      debugPrint('${widget.adUnitId} Illegal Ad size argument - It must not be null');
      return;
    }
    debugPrint('${widget.adUnitId} Ads: width: ${size.width}, height: ${size.height},');

    google_mob_ads.AdManagerBannerAd ad = google_mob_ads.AdManagerBannerAd(
      adUnitId: widget.adUnitId,
      sizes: [size],
      request: google_mob_ads.AdManagerAdRequest(customTargeting: widget.targeting),
      listener: google_mob_ads.AdManagerBannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as google_mob_ads.AdManagerBannerAd;
            _isAdLoaded = true;
            widget.onAdLoaded?.call();
          });
        },
        onAdFailedToLoad: (ad, error) async {
          await ad.dispose();
          debugPrint('${widget.adUnitId} $error');
        },
      ),
    );

    await ad.load();
  }

  Future<google_mob_ads.AdSize?> _adaptiveSize() async {
    final size = await google_mob_ads.AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      debugPrint('${widget.adUnitId} Adaptive Ads: to get height of anchored banner.');
    }

    return size;
  }
}
