import 'package:adradio/views/newsfeed_screen/sub_screen_widget/newsfweed_carousal_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../../utils/custom_color.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/size.dart';

class MyCarouselSlider extends StatelessWidget {
  MyCarouselSlider({super.key});
  final controller = Get.find<NewsfeedController>();

  @override
  Widget build(BuildContext context) {
    final RxInt current = 0.obs;
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
               controller.dashboardModel.data.banners.banners.length,
              (index) => Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(),
                    child: NewsfeedCarousalWidget(
                      data:
                          controller.dashboardModel.data.banners.banners[index],
                    ),
                  )),
          options: CarouselOptions(
            height: MediaQuery.sizeOf(context).height * 0.23,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            viewportFraction: 0.80,
            onPageChanged: (index, reason) {
              current.value = index;
            },
          ),
        ),
        verticalSpace(Dimensions.heightSize * .5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              controller.dashboardModel.data.banners.banners.length,
                  (index) {
                return Obx(
                        () => Container(
                          width: current.value == index
                              ? MediaQuery.of(context).size.width * 0.04
                              : MediaQuery.of(context).size.width * 0.02,
                          height: MediaQuery.of(context).size.height * 0.01,
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius),
                            color: current.value == index
                                ? CustomColor.primaryLightColor
                                : CustomColor.primaryLightColor.withOpacity(0.2),
                          ),
                        ),
                      );
              }),
        ),
      ],
    );
  }
}
