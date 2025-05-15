import 'package:adradio/utils/basic_screen_imports.dart';

import '../../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../../backend/model/dashboard/dashboard_model.dart' as model;


class NewsfeedCarousalWidget extends StatelessWidget {
  final model.Banner data;
  NewsfeedCarousalWidget({super.key, required this.data});

  final bannerPath = Get.find<NewsfeedController>().dashboardModel?.data.banners;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: DecorationImage(
            image: NetworkImage("${bannerPath?.baseUrl}/${bannerPath?.imagePath}/${data.image}"),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          crossAxisAlignment: crossEnd,
          mainAxisAlignment: mainSpaceBet,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainEnd,
                children: [
                  TitleHeading4Widget(
                    text: data.title,
                    color: CustomColor.whiteColor,
                    maxLines: 2,
                    fontWeight: FontWeight.w800,
                  ),
                  TitleHeading5Widget(
                    text: data.description,
                    maxLines: 3,
                    color: CustomColor.whiteColor.withOpacity(.60),
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize7,
                  ),
                ],
              ),
            ), 
            Container(
              margin: EdgeInsets.only(
                left: Dimensions.paddingVerticalSize * .25,
              ),
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingVerticalSize * .15,
              ),
              decoration: BoxDecoration(
                color: CustomColor.primaryLightColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius),
                  bottomLeft: Radius.circular(Dimensions.radius),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.remove_red_eye_outlined,
                    color: CustomColor.whiteColor,
                    size: Dimensions.iconSizeSmall,
                  ).paddingOnly(
                    right: Dimensions.marginSizeHorizontal * .25,
                    left: Dimensions.marginSizeHorizontal * .25,
                  ),
                  TitleHeading5Widget(
                    padding: EdgeInsets.only(
                      right: Dimensions.marginSizeHorizontal * .25,
                    ),
                    text: Strings.liveOnYoutube,
                    color: CustomColor.whiteColor,
                    fontWeight: FontWeight.w700,
                    fontSize: Dimensions.headingTextSize7,
                  ),
                ],
              ),
            ),
          ],
        ).marginOnly(
          bottom: Dimensions.paddingVerticalSize * .5,
          left: Dimensions.marginSizeHorizontal * .75,
        ),
      ),
    );
  }
}