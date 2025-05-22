// import 'package:adradio/backend/utils/custom_loading_api.dart';
//
// import '../../../../utils/basic_screen_imports.dart';
// import '../../../../utils/responsive_layout.dart';
// import '../../controller/settings/basic_settings_controller.dart';
//
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<BasicSettingsController>();
//     return ResponsiveLayout(
//       mobileScaffold: Scaffold(
//         body: Obx(() => controller.isLoading
//             ? const CustomLoadingAPI()
//             : Image.network(
//                 controller.splash.value,
//                 fit: BoxFit.cover,
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//               )),
//       ),
//     );
//   }
// }

// import 'package:adradio/backend/local_storage/local_storage.dart';
// import 'package:adradio/backend/utils/custom_loading_api.dart';
// import '../../../../utils/basic_screen_imports.dart';
// import '../../../../utils/responsive_layout.dart';
// import '../../controller/auth/registration/registration_controller/registration_controller.dart';
// import '../../controller/banner_ad_controller.dart';
// import '../../controller/global_state_controller.dart';
// import '../../controller/settings/basic_settings_controller.dart';
// import 'package:get/get.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   final bannerAdController = Get.put(BannerAdController());
//   final controller = Get.find<BasicSettingsController>();
//   final reGicontroller = Get.put(RegistrationController());
//   final globalStateController = Get.put(GlobalStateController());
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     // reGicontroller.onRegistration;
//     bannerAdController.loadBannerAd();
//     bannerAdController.loadInterstitialAd();
//
//     LocalStorage.saveToken(
//         token:
//             "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzM5MDM5Y2EzMjNjZDJlYzNkZTc2NmFkNjdiNDkzZjc1NTlhNjg2OWNlZjIyMjFiNjU5NDU3MzFkZDc5YmRlYzk1ZGNiNDUyOTVmOTg2NzUiLCJpYXQiOjE3NDQ5MTExNTQuNzA0NDU4LCJuYmYiOjE3NDQ5MTExNTQuNzA0NDU5LCJleHAiOjE3NzY0NDcxNTQuNzAxODA5LCJzdWIiOiI4Iiwic2NvcGVzIjpbXX0.H198Sep94rzAgDooNuPIw2xJQ1F-aNi_GiZdwNlRWtTQBXIA9yeLAC6oo3rBPdtoXl9YDa5gl_cBtxlm-Vd5Ka5lZEYl8Vtn6HyaJ2tuXtNZXPpzB3g1qSPIIlJ39WqvYcYOrRenk0LfDhNyiq9GK-5lULlTXJL94EV2OToOIikB1i1KVc9ZHSNxmOrx_NKcLvxf5cusG1kYPY5yM0HbrbDDtBNoW1fIDdp8XUlr76yDiSmP2BfAK1fUEGhFWumE303_VUaqpxAuvPDtMa4S9TcP_PnIGEGVx_al-b8TEmtGLdcLFXprC0kgUHr43X7DxwQb8OkZ35rqI6K3xPOfrI_KDELx383-E_Jxgay3ZlVf6NqVFb42osRNC5JteLkrOAd95oLtuXiL-GqfmuzVoN2uzu5s8_ijWpxvtLZWNH1_6hjjlP_x7ApEdFZdEBNCL24eNcqDbyhjoAIHKi8vvJ3qFqXOe6uM5J1crW_RdkRCVEQ_FzYNUgVBxPWAtlk-hlKjzQeqSXLiS0tiR5x0_x3ZUFxYGidp9r1ycgOUNunnEJA4AgQ_SFumN7i9gz4mDr3wlCglktH-Z44vtN3_8BRPcbkcs4Z1yhLR_m6NaZ1YN902GpKHBvTPP-u9V3X2M955d-ib6gX_zuTVYgwYta-HuR9gptkcGscsxMGXo4U");
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//       mobileScaffold: Scaffold(
//         backgroundColor: Colors.black,
//         body: Obx(() => controller.isLoading
//             ? const CustomLoadingAPI()
//             : Image.network(
//           controller.splash.value,
//           fit: BoxFit.cover,
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) {
//               // Image fully loaded
//               globalStateController.isSplashImageLoaded.value = true;
//               return child;
//             } else {
//               return const CustomLoadingAPI();
//             }
//           },
//           errorBuilder: (context, error, stackTrace) => const Center(
//             child: Text(
//               "Splash image failed to load",
//               style: TextStyle(color: Colors.orangeAccent),
//             ),
//           ),
//         )),
//       ),
//     );
//   }

// @override
// Widget build(BuildContext context) {
//   return ResponsiveLayout(
//     mobileScaffold: Scaffold(
//       backgroundColor: Colors.black, // Color coding
//       body: Obx(() => controller.isLoading
//           ? const CustomLoadingAPI()
//           : Image.network(
//               controller.splash.value,
//               fit: BoxFit.cover,
//               height: MediaQuery.of(context).size.height,
//               width: MediaQuery.of(context).size.width,
//               errorBuilder: (context, error, stackTrace) => const Center(
//                 child: Text(
//                   "Splash image failed to load",
//                   style: TextStyle(color: Colors.orangeAccent),
//                 ),
//               ),
//             )),
//     ),
//   );
// }

import 'package:adradio/backend/local_storage/local_storage.dart';
import 'package:adradio/backend/utils/custom_loading_api.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../controller/auth/registration/registration_controller/registration_controller.dart';
import '../../controller/banner_ad_controller.dart';
import '../../controller/global_state_controller.dart';
import '../../controller/live_streaming_controller/live_streaming_controller.dart';
import '../../controller/settings/basic_settings_controller.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final bannerAdController = Get.put(BannerAdController());
  final controller = Get.find<BasicSettingsController>();
  final reGicontroller = Get.put(RegistrationController());
  final globalStateController = Get.put(GlobalStateController());
  // final liveStreamingController = Get.put(LiveStreamingController());

  @override
  void initState() {
    super.initState();
    bannerAdController.loadBannerAd();
    bannerAdController.loadInterstitialAd();

    LocalStorage.saveToken(
        token:
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiYzM5MDM5Y2EzMjNjZDJlYzNkZTc2NmFkNjdiNDkzZjc1NTlhNjg2OWNlZjIyMjFiNjU5NDU3MzFkZDc5YmRlYzk1ZGNiNDUyOTVmOTg2NzUiLCJpYXQiOjE3NDQ5MTExNTQuNzA0NDU4LCJuYmYiOjE3NDQ5MTExNTQuNzA0NDU5LCJleHAiOjE3NzY0NDcxNTQuNzAxODA5LCJzdWIiOiI4Iiwic2NvcGVzIjpbXX0.H198Sep94rzAgDooNuPIw2xJQ1F-aNi_GiZdwNlRWtTQBXIA9yeLAC6oo3rBPdtoXl9YDa5gl_cBtxlm-Vd5Ka5lZEYl8Vtn6HyaJ2tuXtNZXPpzB3g1qSPIIlJ39WqvYcYOrRenk0LfDhNyiq9GK-5lULlTXJL94EV2OToOIikB1i1KVc9ZHSNxmOrx_NKcLvxf5cusG1kYPY5yM0HbrbDDtBNoW1fIDdp8XUlr76yDiSmP2BfAK1fUEGhFWumE303_VUaqpxAuvPDtMa4S9TcP_PnIGEGVx_al-b8TEmtGLdcLFXprC0kgUHr43X7DxwQb8OkZ35rqI6K3xPOfrI_KDELx383-E_Jxgay3ZlVf6NqVFb42osRNC5JteLkrOAd95oLtuXiL-GqfmuzVoN2uzu5s8_ijWpxvtLZWNH1_6hjjlP_x7ApEdFZdEBNCL24eNcqDbyhjoAIHKi8vvJ3qFqXOe6uM5J1crW_RdkRCVEQ_FzYNUgVBxPWAtlk-hlKjzQeqSXLiS0tiR5x0_x3ZUFxYGidp9r1ycgOUNunnEJA4AgQ_SFumN7i9gz4mDr3wlCglktH-Z44vtN3_8BRPcbkcs4Z1yhLR_m6NaZ1YN902GpKHBvTPP-u9V3X2M955d-ib6gX_zuTVYgwYta-HuR9gptkcGscsxMGXo4U");
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Colors.black,
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : Image.network(
                controller.splash.value,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                loadingBuilder: (context, child, loadingProgress) {
                  // Mark as loaded once splash image starts rendering
                  // if (!globalStateController.isSplashImageLoaded.value) {
                  //   globalStateController.isSplashImageLoaded.value = true;
                  // }
                  globalStateController.isSplashImageLoaded.value = true;
                  print('Mimicked: ✅ TestBefore-${globalStateController.isSplashImageLoaded.value}');
                  return child;
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    "Splash image failed to load",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                ),
              )),
      ),
    );
  }
}
