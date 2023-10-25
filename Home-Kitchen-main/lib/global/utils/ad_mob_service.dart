import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:home_kitchen/globals.dart';

class AdMobsService {
  static String? get bannerAdUnitId {
      return 'ca-app-pub-4350301616221692/4070347224';

  }
  static String? get InterstitialAdID {
      return 'ca-app-pub-4350301616221692/1966480954';

  }
  static String? get RewardedAdID {
      return 'ca-app-pub-4350301616221692/5054295832';

  }
  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded:(ad) => debugPrint('addLoaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint(error.message);
    },
    onAdOpened: (ad) => print('ad'),
    onAdClosed: (ad) => print('ad'),
  );
  static BannerAd createBannerAd() {
    BannerAd bannerAd;
    bannerAd = BannerAd(size: AdSize.fullBanner, adUnitId: AdMobsService.bannerAdUnitId!, listener: AdMobsService.bannerAdListener, request: const AdRequest())..load();
    return bannerAd;
  }
}