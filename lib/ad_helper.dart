import 'dart:io';
class AdHelper {
  static String get bannerAdUnitId{

    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/9214589741';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/9214589741';
    }else{
      throw UnsupportedError("UnSuppoerted platform");
    }

  }

  static String get interstitialAd{

    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/1033173712';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/1033173712';
    }else{
      throw UnsupportedError("UnSuppoerted platform");
    }

  }

}