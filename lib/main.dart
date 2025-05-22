import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'backend/services/api_endpoint.dart';
import 'backend/utils/network_check/dependency_injection.dart';
import 'controller/audio_handler.dart';
import 'controller/global_state_controller.dart';
import 'controller/settings/basic_settings_controller.dart';
import 'backend/language/english.dart';

import 'package:audio_service/audio_service.dart';
import 'package:rxdart/rxdart.dart'; // <- Add this package
//
// late MyAudioHandler audioHandler;
// late final AudioPlayer audioPlayer;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();


  // audioPlayer = AudioPlayer();
  // audioHandler = MyAudioHandler(audioPlayer);
  //
  // await AudioService.init(
  //   builder: () => audioHandler,
  //   config: AudioServiceConfig(
  //     androidNotificationChannelId: 'com.ryanheise.audioservice.AudioService',
  //     androidNotificationChannelName: 'Audio Playback',
  //     androidNotificationOngoing: true,
  //   ),
  // );


  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.audioservice.AudioService',
    androidNotificationChannelName: 'Audio Playback',
    androidNotificationOngoing: true
  );






  InternetCheckDependencyInjection.init();

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.lazyPut(() => GlobalStateController());
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: Themes().theme,
        navigatorKey: Get.key,
        initialRoute: Routes.splashScreen,
        getPages: Routes.list,
        initialBinding: BindingsBuilder(() async {
          Get.put(BasicSettingsController(), permanent: true);
          await DynamicLanguage.init(url: ApiEndpoint.languageURL);
        }),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(0.87)),
              child: Directionality(
                  textDirection: DynamicLanguage.isLoading
                      ? TextDirection.ltr
                      : DynamicLanguage.languageDirection,
                  child: widget!));
        },
      ),
    );
  }
}