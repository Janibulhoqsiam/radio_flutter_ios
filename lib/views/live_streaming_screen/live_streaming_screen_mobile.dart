import 'dart:async';
import 'dart:io';

import 'package:adradio/backend/utils/custom_loading_api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../controller/live_streaming_controller/live_streaming_controller.dart';
import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';

class LiveStreamingScreenMobile extends StatelessWidget {
  LiveStreamingScreenMobile({super.key, required this.controller});

  final LiveStreamingController controller;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Obx(() => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.clipart.liveStreamingAppbarBg.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            controller.isLoading
                ? const CustomLoadingAPI()
                : _playerWidget(context),
          ]),
        ));
  }

  _carouselSliderWidget(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          String image = "";
          switch (index) {
            case 0:
              image = Assets.clipart.streaminglogo.path;
              break;
            case 1:
              image = Assets.clipart.lightEffectTwo.path;
              break;
            case 2:
              image = Assets.clipart.lightEffectThree.path;
              break;
          }
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: ShapeDecoration(
              shadows: [
                BoxShadow(
                  color: CustomColor.primaryLightTextColor.withOpacity(0.20),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: Dimensions.widthSize * 1.2,
                    color: CustomColor.whiteColor),
                borderRadius: BorderRadius.circular(24),
              ),
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.30,
          enlargeCenterPage: true,
          autoPlay: false,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: false,
          viewportFraction: 0.60,
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
            verticalSpace(MediaQuery.sizeOf(context).height * .16),
            _carouselSliderWidget(context),
            verticalSpace(Dimensions.paddingVerticalSize * .5),
            controller.liveShowModel.data.schedule.isEmpty
                ? const SizedBox.shrink()
                : Column(
                    children: [
                      TitleHeading1Widget(
                        text: controller.liveShowModel.data.schedule.first.name,
                        color: CustomColor.primaryLightTextColor,
                        fontWeight: FontWeight.w700,
                      ).paddingOnly(
                          bottom: Dimensions.paddingVerticalSize * 0.2),
                      TitleHeading5Widget(
                        text: controller.liveShowModel.data.schedule.first.host,
                        color:
                            CustomColor.primaryLightTextColor.withOpacity(.40),
                        fontWeight: FontWeight.w500,
                      ).paddingOnly(
                          bottom: Dimensions.paddingVerticalSize * 0.0),
                      IconButton(
                        icon: Platform.isIOS ? Icon(Icons.airplay) : Icon(Icons.cast),
                        onPressed: () {

                        },
                      ).paddingOnly(
                        bottom: Dimensions.paddingVerticalSize * 0.0,
                      ),
                      FittedBox(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingHorizontalSize * .4,
                            vertical: Dimensions.paddingVerticalSize * .25,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  CustomColor.primaryLightColor.withOpacity(.3),
                              width: 1,
                            ),
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius * 1.75),
                            color:
                                CustomColor.primaryLightColor.withOpacity(.1),
                          ),
                          child: Row(
                            mainAxisAlignment: mainCenter,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  right: Dimensions.paddingHorizontalSize * .25,
                                ),
                                child: CircleAvatar(
                                  radius: Dimensions.radius * .25,
                                  backgroundColor:
                                      CustomColor.primaryLightColor,
                                ),
                              ),
                              TitleHeading5Widget(
                                text: controller.liveShowModel.data.schedule
                                            .first.isLive ==
                                        1
                                    ? Strings.liveText
                                    : Strings.offlineText,
                                fontSize: Dimensions.headingTextSize7,
                                fontWeight: FontWeight.w800,
                                color: CustomColor.primaryLightColor,
                              ),
                            ],
                          ),
                        ),
                      ).paddingOnly(
                        bottom: Dimensions.paddingVerticalSize * 0,
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     // Left side: Stream Time (e.g., 00:38)
                      //     Padding(
                      //       padding: EdgeInsets.only(right: 12.0),
                      //       child: Text(
                      //         controller.audioPlayer.durationStream as String,
                      //         style: TextStyle(
                      //           fontSize: 16.0, // Set a fixed font size here
                      //           color: CustomColor.primaryLightTextColor,
                      //         ),
                      //       ),
                      //     ),
                      //
                      //     // Center: Play/Pause Circle
                      //     Padding(
                      //       padding: EdgeInsets.only(
                      //         bottom: Dimensions.paddingVerticalSize * .3,
                      //       ),
                      //       child: CircleAvatar(
                      //         radius: Dimensions.radius * 5.8,
                      //         backgroundColor: CustomColor.primaryLightColor
                      //             .withOpacity(.04),
                      //         child: CircleAvatar(
                      //           radius: Dimensions.radius * 4.5,
                      //           backgroundColor: CustomColor.primaryLightColor
                      //               .withOpacity(.06),
                      //           child: Obx(() => CircularPercentIndicator(
                      //                 radius: Dimensions.radius * 3.8,
                      //                 arcType: ArcType.FULL,
                      //                 backgroundColor: CustomColor.whiteColor,
                      //                 progressColor:
                      //                     CustomColor.primaryLightColor,
                      //                 animation: true,
                      //                 percent: controller.isPlayLoading.value
                      //                     ? 1
                      //                     : controller.isPlaying.value
                      //                         ? 1
                      //                         : 0.2,
                      //                 animationDuration: 2000,
                      //                 center: CircleAvatar(
                      //                   radius: Dimensions.radius * 3.5,
                      //                   backgroundColor: CustomColor.whiteColor,
                      //                   child: Center(
                      //                     child: IconButton(
                      //                       onPressed: () {
                      //                         controller.playRadio();
                      //                       },
                      //                       icon: Icon(
                      //                         controller.isPlaying.value
                      //                             ? Icons.pause
                      //                             : Icons.play_arrow,
                      //                         color:
                      //                             CustomColor.primaryLightColor,
                      //                         size: MediaQuery.sizeOf(context)
                      //                                 .width *
                      //                             .08,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               )),
                      //         ),
                      //       ),
                      //     ),
                      //
                      //     // Right side: Bitrate (e.g., 64kbps)
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 12.0),
                      //       child: Text(
                      //         "64kbps",
                      //         style: TextStyle(
                      //           fontSize: 16.0, // Set a fixed font size here
                      //           color: CustomColor.primaryLightTextColor,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Left: Current position / Total duration
                          Padding(
                            padding: EdgeInsets.only(right: 12.0),
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
                                        color:
                                            CustomColor.primaryLightTextColor,
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
                              bottom: Dimensions.paddingVerticalSize * .3,
                            ),
                            child: CircleAvatar(
                              radius: Dimensions.radius * 5.8,
                              backgroundColor: CustomColor.primaryLightColor
                                  .withOpacity(.04),
                              child: CircleAvatar(
                                radius: Dimensions.radius * 4.5,
                                backgroundColor: CustomColor.primaryLightColor
                                    .withOpacity(.06),
                                child: Obx(() => CircularPercentIndicator(
                                      radius: Dimensions.radius * 3.8,
                                      arcType: ArcType.FULL,
                                      backgroundColor: CustomColor.whiteColor,
                                      progressColor:
                                          CustomColor.primaryLightColor,
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
                                            },
                                            icon: Icon(
                                              controller.isPlaying.value
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color:
                                                  CustomColor.primaryLightColor,
                                              size: MediaQuery.sizeOf(context)
                                                      .width *
                                                  .08,
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
                            padding: EdgeInsets.only(left: 12.0),
                            child: Text(
                              controller.dataUsage.value, // e.g., "64kbps"
                              style: TextStyle(
                                fontSize: 16.0,
                                color: CustomColor.primaryLightTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Obx(
                        () => Container(
                          margin: EdgeInsets.only(
                            left: Dimensions.marginSizeHorizontal,
                            right: Dimensions.marginSizeHorizontal,
                            // bottom: Dimensions.heightSize * 10
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.volume_off,
                                color: CustomColor.primaryLightColor
                                    .withOpacity(.4),
                              ),
                              Expanded(
                                child: Slider(
                                  value: controller.setVolumeValue.value,
                                  min: 0.0,
                                  max: 1.0,
                                  activeColor: CustomColor.primaryLightColor,
                                  inactiveColor: CustomColor.primaryLightColor
                                      .withOpacity(.2),
                                  onChanged: (double value) {
                                    debugPrint(value.toString());
                                    controller.setVolume(value);
                                  },
                                ),
                              ),
                              Icon(
                                Icons.volume_up,
                                color: CustomColor.primaryLightColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // verticalSpace(10),
                    ],
                  )
          ],
        ),
      ),
    );
  }

}
