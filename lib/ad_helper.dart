import 'dart:io';
class AdHelper {
  static String get bannerAdUnitId{

    if(Platform.isAndroid){
      return 'ca-app-pub-4002965790017475/1028444931';
    }else if(Platform.isIOS){
      return 'ca-app-pub-4002965790017475/3234730474';
    }else{
      throw UnsupportedError("UnSuppoerted platform");
    }

  }

  static String get interstitialAd{

    if(Platform.isAndroid){
      return 'ca-app-pub-4002965790017475/7676005533';
    }else if(Platform.isIOS){
      return 'ca-app-pub-4002965790017475/1930748475';
    }else{
      throw UnsupportedError("UnSuppoerted platform");
    }

  }

}