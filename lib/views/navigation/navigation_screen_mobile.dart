import 'package:adradio/controller/%20radio_controller.dart';
import 'package:adradio/utils/basic_screen_imports.dart';
import 'package:adradio/widgets/others/custom_image_widget.dart';
import 'package:dynamic_languages/dynamic_languages.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../controller/banner_ad_controller.dart';
import '/custom_assets/assets.gen.dart';
import '../../controller/live_streaming_controller/live_streaming_controller.dart';
import '../../controller/navigation_controller/navigation_controller.dart';
import '../../widgets/drawer/drawer_widget.dart';


class NavigationScreenMobile extends StatelessWidget {
  NavigationScreenMobile({super.key});

  final controller = Get.put(NavigationController());
  final liveStreamingController = Get.put(LiveStreamingController());
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final bannerAdController = Get.find<BannerAdController>();


  // @override
  // Widget build(BuildContext context) {
  //   return Obx(() {
  //     return Scaffold(
  //       extendBody: true,
  //       extendBodyBehindAppBar:
  //           controller.selectedIndex.value == 2 ? true : false,
  //       key: scaffoldKey,
  //       backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
  //       drawer: const DrawerWidget(),
  //       appBar: _appBarWidget(context),
  //       // body: controller.body[controller.selectedIndex.value],
  //       body: Stack(children: [
  //         Column(
  //           children: [
  //             Expanded(
  //               child: controller.body[controller.selectedIndex.value],
  //             ),
  //           ],
  //         )
  //       ]),
  //
  //       bottomNavigationBar: Obx(() => liveStreamingController.isLoading
  //           ? const SizedBox.shrink()
  //           : (controller.selectedIndex.value == 0 &&
  //                   liveStreamingController
  //                       .liveShowModel.data.schedule.isNotEmpty)
  //               ? _payerBottomNavBarWidget(context)
  //               : _bottomNavBarWidget(context)),
  //       floatingActionButton: Obx(() => liveStreamingController.isLoading
  //           ? const SizedBox.shrink()
  //           : ((liveStreamingController.liveShowModel.data.schedule.isEmpty ||
  //                   controller.selectedIndex.value != 0)
  //               ? _middleButton(context)
  //               : const SizedBox.shrink())),
  //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //     );
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: controller.selectedIndex.value == 2,
        key: scaffoldKey,
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        drawer: const DrawerWidget(),
        appBar: _appBarWidget(context),

        // 🔧 Body with Banner Ad above FAB and BottomNav
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: controller.body[controller.selectedIndex.value],
                ),
              ],
            ),


          ],
        ),

        // 🔽 Bottom Navigation Bar Logic
        bottomNavigationBar: Obx(() =>
        liveStreamingController.isLoading
            ? const SizedBox.shrink()
            : (controller.selectedIndex.value == 0 &&
            liveStreamingController
                .liveShowModel.data.schedule.isNotEmpty)
            ? _payerBottomNavBarWidget(context)
            : _bottomNavBarWidget(context)),

        // 🎯 Floating Action Button Logic
        floatingActionButton: Obx(() =>
        liveStreamingController.isLoading
            ? const SizedBox.shrink()
            : ((liveStreamingController
            .liveShowModel.data.schedule.isEmpty ||
            controller.selectedIndex.value != 0)
            ? _middleButton(context)
            : const SizedBox.shrink())),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }




  _payerBottomNavBarWidget(BuildContext context) {
    String imagePath =
        "${liveStreamingController.liveShowModel.data.baseUrl}/${liveStreamingController.liveShowModel.data.imagePath}";
    return SwipeDetector(
      onSwipeUp: (offset) {
        controller.selectedIndex.value = 2;
      },
      onSwipe: (direction, offset) {
        controller.selectedIndex.value = 2;
      },
      onSwipeDown: (offset) {
        controller.selectedIndex.value = 2;
      },
      onSwipeLeft: (offset) {
        controller.selectedIndex.value = 2;
      },
      onSwipeRight: (offset) {
        controller.selectedIndex.value = 2;
      },
      child: Material(
        elevation: 15,
        color: Colors.transparent,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(Dimensions.radius * 1.5)),
        child: GestureDetector(
          onTap: () {
            controller.selectedIndex.value = 2;
          },
          child: BottomAppBar(
            clipBehavior: Clip.antiAlias,
            surfaceTintColor: CustomColor.whiteColor,
            shadowColor: CustomColor.blackColor,
            elevation: 15,
            notchMargin: 5,
            color: CustomColor.whiteColor,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize,
              ),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColor.whiteColor,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                          Dimensions.radius * 2,
                        ),
                        topLeft: Radius.circular(
                          Dimensions.radius * 2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            "https://radioapintie.xyz/public/backend/files/schedule/05e64b73-14be-46c2-b2a0-257c058a0403.webp",
                          ),
                        ).paddingOnly(right: Dimensions.widthSize * .5),
                        Expanded(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: mainCenter,
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                        child: TitleHeading5Widget(
                                          text: radioController.title,
                                          color: CustomColor.primaryLightTextColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),

                                      horizontalSpace(
                                          Dimensions.widthSize * .25),
                                      CircleAvatar(
                                        radius: Dimensions.radius * .60,
                                        backgroundColor: CustomColor
                                            .primaryLightColor
                                            .withOpacity(.1),
                                        child: CircleAvatar(
                                          radius: Dimensions.radius * .40,
                                          backgroundColor: CustomColor
                                              .primaryLightColor
                                              .withOpacity(.2),
                                          child: CircleAvatar(
                                            radius: Dimensions.radius * .2,
                                            backgroundColor:
                                                CustomColor.primaryLightColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  TitleHeading5Widget(
                                    text: radioController.artist,
                                    fontSize: Dimensions.headingTextSize7,
                                    color: CustomColor.primaryLightColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            liveStreamingController.playRadio();
                          },
                          child: CircleAvatar(
                            radius: Dimensions.radius * 4,
                            backgroundColor:
                                CustomColor.primaryLightColor.withOpacity(.1),
                            child: CircleAvatar(
                              radius: Dimensions.radius * 2,
                              backgroundColor: CustomColor.primaryLightColor
                                  .withOpacity(.15),
                              child: Obx(() => CircularPercentIndicator(
                                    radius: Dimensions.radius * 1.6,
                                    arcType: ArcType.FULL,
                                    backgroundColor: CustomColor.whiteColor,
                                    progressColor:
                                        CustomColor.primaryLightColor,
                                    animation: true,
                                    percent: liveStreamingController
                                            .isPlayLoading.value
                                        ? 1
                                        : liveStreamingController
                                                .isPlaying.value
                                            ? 1
                                            : 0.2,
                                    animationDuration: 2000,
                                    center: CircleAvatar(
                                      radius: Dimensions.radius * 1.5,
                                      backgroundColor: CustomColor.whiteColor,
                                      child: Center(
                                        child: Icon(
                                          liveStreamingController
                                                  .isPlaying.value
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: CustomColor.primaryLightColor,
                                          size:
                                              MediaQuery.sizeOf(context).width *
                                                  .04,
                                        ),
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 1,
                    right: 1,
                    child: Center(
                      child: Container(
                        height: Dimensions.heightSize * .2,
                        width: Dimensions.widthSize * 2,
                        decoration: BoxDecoration(
                          color: CustomColor.blackColor.withOpacity(.25),
                          borderRadius: BorderRadius.circular(
                            Dimensions.radius,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _bottomNavBarWidget(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(Dimensions.radius * 2.1),
      ),
      child: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        surfaceTintColor: CustomColor.whiteColor,
        shadowColor: CustomColor.blackColor,
        height: Dimensions.heightSize * 5,
        elevation: 15,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        color: CustomColor.whiteColor,
        child: Stack(
          children: [
            // Left items
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomItemWidget(
                    icon: Icons.dashboard_outlined,
                    label: Strings.newsfeed,
                    index: 0,
                  ),
                  horizontalSpace(Dimensions.widthSize * 1.8),
                  BottomItemWidget(
                    icon: Icons.live_tv,
                    label: "Live Tv",
                    index: 1,
                  ),
                ],
              ),
            ),

            // Right items
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomItemWidget(
                    icon: Icons.radio,
                    label: Strings.showSchedule,
                    index: 3,
                  ),
                  horizontalSpace(Dimensions.widthSize * 1.8),
                  BottomItemWidget(
                    icon: Icons.import_contacts_outlined,
                    label: "Contacts",
                    index: 4,
                  ),
                ],
              ),
            ),

            // Center notch text or button
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top +
                        Dimensions.heightSize * 0.2,
                  ),
                  child: TitleHeading5Widget(
                    padding: EdgeInsets.zero,
                    text: Strings.liveStreaming,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.headingTextSize7,
                    color: _getColorForIndex(controller.selectedIndex.value),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to get color for each index
  Color _getColorForIndex(int index) {
    switch (index) {
      case 0:
        return CustomColor.mainlcolor; // Color for index 0
      case 1:
        return CustomColor.mainlcolor;
      case 2:
        return CustomColor.mainlcolor; // Color for index 2 (as before)
      case 3:
        return CustomColor.mainlcolor; // Slightly different color for index 3
      case 4:
        return CustomColor.mainlcolor;
      default:
        return CustomColor.mainlcolor;
    }
  }

  _middleButton(BuildContext context) {
    return CircleAvatar(
      backgroundColor: CustomColor.primaryLightColor.withOpacity(.10),
      radius: 40,
      child: CircleAvatar(
        backgroundColor: CustomColor.whiteColor,
        radius: 34,
        child: InkWell(
          child: Align(
              alignment: Alignment.center,
              child: CustomImageWidget(
                path: Assets.icon.liveStreamingIcon,
                height: 40,
                width: 40,
                color: CustomColor.primaryLightColor,
              )),
          onTap: () {
            controller.selectedIndex.value = 2;
            liveStreamingController.playRadio();
            debugPrint(
                ">> Selected Index >> ${controller.selectedIndex.value}");
          },
        ),
      ),
    );
  }

  _appBarWidget(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(
        55,
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        leading: InkWell(
          onTap: () {
            // scaffoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.paddingHorizontalSize),
            child: Icon(
              Iconsax.element_4,
              size: Dimensions.heightSize * 2,
              color: controller.selectedIndex.value == 2
                  ? CustomColor.whiteColor
                  : CustomColor.blackColor,
              weight: Dimensions.headingTextSize1,
            ),
          ),
        ),
        backgroundColor: controller.selectedIndex.value == 2
            ? Colors.transparent
            : CustomColor.primaryLightScaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: TitleHeading1Widget(
          text: controller.selectedIndex.value == 2
              ? DynamicLanguage.isLoading
                  ? ""
                  : "Live Radio"
              : DynamicLanguage.isLoading
                  ? ""
                  : DynamicLanguage.key(controller.appTitle.value),
          fontSize: controller.selectedIndex.value == 2
              ? Dimensions.headingTextSize1 * 1.15
              : Dimensions.headingTextSize2,
          color: controller.selectedIndex.value == 2
              ? CustomColor.whiteColor
              : CustomColor.blackColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              controller.onTapNotification;
            },
            icon: Padding(
              padding: EdgeInsets.only(
                  right: Dimensions.paddingHorizontalSize * 0.75),
              child: Icon(
                Icons.notifications_none_outlined,
                size: Dimensions.heightSize * 2,
                color: controller.selectedIndex.value == 2
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
                weight: Dimensions.headingTextSize1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomItemWidget extends StatelessWidget {
  BottomItemWidget(
      {super.key, required this.icon, required this.label, this.index});

  final IconData icon;
  final String label;
  final int? index;
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.selectedIndex.value = index!;
        controller.appTitle.value = controller.appTitleList[index!];
        debugPrint(">> Selected Index >> ${controller.selectedIndex.value}");
      },
      child: Obx(
        () => SizedBox(
          child: Column(
            children: [
              Icon(
                icon,
                size: 20,
                color: controller.selectedIndex.value == index
                    ? CustomColor.primaryLightTextColor
                    : CustomColor.primaryLightTextColor.withOpacity(0.5),
              ),
              verticalSpace(Dimensions.heightSize * 0.25),
              TitleHeading5Widget(
                text: label,
                fontSize: Dimensions.headingTextSize7,
                fontWeight: FontWeight.w600,
                color: controller.selectedIndex.value == index
                    ? CustomColor.primaryLightTextColor
                    : CustomColor.primaryLightTextColor.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
