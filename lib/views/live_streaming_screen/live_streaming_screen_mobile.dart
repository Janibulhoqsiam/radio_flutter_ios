import 'dart:async';
import 'dart:io';

import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../controller/banner_ad_controller.dart';
import '../../controller/live_streaming_controller/live_streaming_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LiveStreamingScreenMobile extends StatelessWidget {
  LiveStreamingScreenMobile({super.key, required this.controller});

  final LiveStreamingController controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // final bannerAdController = Get.find<BannerAdController>();
  final BannerAdController bannerAdController = Get.put(BannerAdController());
  final bannerAdControllerF = Get.find<BannerAdController>();

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    bannerAdController.loadInterstitialAd();
    bannerAdController.loadBannerAd();
    return Obx(() => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: CustomColor.mainlcolor,
            child: Stack(
              children: [
                // Top background design
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1557AC),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: _TopWaveClipper(),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withOpacity(0.05),
                                Colors.white.withOpacity(0.02),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Main content
                controller.isLoading
                    ? const CustomLoadingAPI()
                    : _playerWidget(context),
              ],
            ),
          ),
        ));
  }

  Widget _carouselSliderWidget(BuildContext context) {
    String image = Assets.clipart.streaminglogo.path;

    double size =
        MediaQuery.of(context).size.width * 0.65; // 50% of screen width

    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          children: [
            // Background gradient
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: CustomColor.primaryLightTextColor.withOpacity(0.20),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    CustomColor.mainlcolor.withOpacity(.70),
                    CustomColor.mainlcolor,
                  ],
                ),
              ),
            ),
            // Image on top of the gradient background
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _playerWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.99,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: crossCenter,
          mainAxisAlignment: mainStart,
          children: [
            verticalSpace(MediaQuery.sizeOf(context).height * .15),
            _carouselSliderWidget(context),
            // verticalSpace(Dimensions.paddingVerticalSize * .5),
            controller.liveShowModel.data.schedule.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      verticalSpace(MediaQuery.sizeOf(context).height * .02),
                      TitleHeading1Widget(
                        text: controller.liveShowModel.data.schedule.first.name,
                        color: CustomColor.whiteColor,
                        fontWeight: FontWeight.w700,
                      ).paddingOnly(
                          bottom: Dimensions.paddingVerticalSize * 0.1),
                      TitleHeading5Widget(
                        text: controller.liveShowModel.data.schedule.first.host,
                        color: CustomColor.whiteColor.withOpacity(.40),
                        fontWeight: FontWeight.w500,
                      ).paddingOnly(bottom: Dimensions.marginSizeVertical * .1),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left: Current position / Total duration
                          Padding(
                            padding: EdgeInsets.only(right: 0.0),
                            child: StreamBuilder<Duration>(
                              stream: controller.audioPlayer.positionStream,
                              builder: (context, positionSnapshot) {
                                return StreamBuilder<Duration?>(
                                  stream: controller.audioPlayer.durationStream,
                                  builder: (context, durationSnapshot) {
                                    final position =
                                        positionSnapshot.data ?? Duration.zero;
                                    final duration =
                                        durationSnapshot.data ?? Duration.zero;

                                    String twoDigits(int n) =>
                                        n.toString().padLeft(2, '0');
                                    String format(Duration d) =>
                                        "${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}";

                                    final posText = format(position);
                                    // final durText = format(duration);

                                    final durText = (duration == null ||
                                            duration == Duration.zero)
                                        ? "LIVE"
                                        : format(duration);

                                    return Text(
                                      "$posText / $durText",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: CustomColor.whiteColor,
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),

                          // Center: Play/Pause Button with Circular Indicator
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: Dimensions.paddingVerticalSize * .0,
                            ),
                            child: CircleAvatar(
                              radius: Dimensions.radius * 5.8,
                              backgroundColor: CustomColor.primaryLightColor
                                  .withOpacity(.04),
                              child: CircleAvatar(
                                radius: Dimensions.radius * 4.5,
                                backgroundColor: CustomColor.whiteColor
                                    .withOpacity(.06),
                                child: Obx(() => CircularPercentIndicator(
                                      radius: Dimensions.radius * 3.8,
                                      arcType: ArcType.FULL,
                                      backgroundColor: CustomColor.mainlcolor,
                                      progressColor:
                                          // CustomColor.progresstrokeColor,
                                          CustomColor.whiteColor.withOpacity(.40),
                                      animation: true,
                                      percent: controller.isPlayLoading.value
                                          ? 1
                                          : controller.isPlaying.value
                                              ? 1
                                              : 0.2,
                                      animationDuration: 2000,
                                      center: CircleAvatar(
                                        radius: Dimensions.radius * 3.5,
                                        backgroundColor: CustomColor.whiteColor,
                                        child: Center(
                                          child: IconButton(
                                            onPressed: () {
                                              controller.playRadio();
                                              if(bannerAdController.interstitialAd == null ){
                                                if(controller.isPlaying.value==true){
                                                  bannerAdController.loadInterstitialAd();
                                                  bannerAdController.showInterstitialAd();
                                                }

                                              }else{
                                                if(controller.isPlaying.value==true){
                                                  bannerAdController.showInterstitialAd();
                                                }
                                              }

                                            },
                                            icon: Icon(
                                              controller.isPlaying.value == true
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color:
                                                  CustomColor.mainlcolor,
                                              size: MediaQuery.sizeOf(context)
                                                      .width * .08,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ),



                          // Right: Bitrate (64kbps)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 0),
                            child: Text(
                              controller.dataUsage.value, // e.g., "64kbps"
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: CustomColor.whiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // TitleHeading5Widget(
                      //   text: controller.liveShowModel.data.schedule.first.description,
                      //   color:
                      //   CustomColor.whiteColor.withOpacity(.70),
                      //   fontWeight: FontWeight.w700,
                      // ),

                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Title
                            TitleHeading5Widget(
                              text: controller.liveShowModel.data.schedule.first
                                  .description,
                              color: CustomColor.whiteColor.withOpacity(.70),
                              fontWeight: FontWeight.w700,
                            ),

                            // Banner Ad (No Gaps)
                            if (bannerAdControllerF.bannerAd != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                // adjust/remove padding if needed
                                child: Center(
                                  child: SizedBox(
                                    width: bannerAdControllerF
                                        .bannerAd!.size.width
                                        .toDouble(),
                                    height: bannerAdControllerF
                                        .bannerAd!.size.height
                                        .toDouble(),
                                    child: AdWidget(
                                        ad: bannerAdControllerF.bannerAd!),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      // Obx(
                      //   () => Container(
                      //     margin: EdgeInsets.only(
                      //       left: Dimensions.marginSizeHorizontal,
                      //       right: Dimensions.marginSizeHorizontal,
                      //       // bottom: Dimensions.heightSize * 10
                      //     ),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Icon(
                      //           Icons.volume_off,
                      //           color: CustomColor.primaryLightColor
                      //               .withOpacity(.4),
                      //         ),
                      //         Expanded(
                      //           child: Slider(
                      //             value: controller.setVolumeValue.value,
                      //             min: 0.0,
                      //             max: 1.0,
                      //             activeColor: CustomColor.primaryLightColor,
                      //             inactiveColor: CustomColor.primaryLightColor
                      //                 .withOpacity(.2),
                      //             onChanged: (double value) {
                      //               debugPrint(value.toString());
                      //               controller.setVolume(value);
                      //             },
                      //           ),
                      //         ),
                      //         Icon(
                      //           Icons.volume_up,
                      //           color: CustomColor.primaryLightColor,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // verticalSpace(10),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

// 👇 Put this small clipper **inside the same file**, below your widget
class _TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.75);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height * 0.8,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.6,
      size.width,
      size.height * 0.8,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
