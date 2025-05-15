import 'package:adradio/extensions/custom_extensions.dart';

import '../../../backend/model/dashboard/dashboard_model.dart';
import '../../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../video_screen/video_screen.dart';

class VideoWidget extends StatelessWidget {
  VideoWidget({super.key,
    required this.video,
    this.isFullScreen = false
  });

  final videoPath = Get.find<NewsfeedController>().dashboardModel?.data.videos;
  final Video video;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * (isFullScreen ? .26 :.23),
      width: MediaQuery.sizeOf(context).width * (isFullScreen ? 1 :.45),
      margin: EdgeInsets.only(
        right: Dimensions.marginSizeHorizontal * .1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius),
        color: CustomColor.secondaryLightTextColor,
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * (isFullScreen ? .17 :.14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius),
                topRight: Radius.circular(Dimensions.radius),
              ),
              image: DecorationImage(
                image: NetworkImage(
                    "${videoPath?.baseUrl}/${videoPath?.imagePath}/${video.image}"),
                fit: BoxFit.fill,
              ),
              // color: Colors.blueAccent,
            ),
            child: Center(
              child: CircleAvatar(
                backgroundColor: CustomColor.primaryLightColor.withOpacity(.4),
                radius: Dimensions.radius * 2.5,
                child: CircleAvatar(
                  backgroundColor: CustomColor.primaryLightColor,
                  radius: Dimensions.radius * 2,
                  child: IconButton(
                    onPressed: () {
                      Get.to(VideoScreen(video: video));
                    },
                    icon: Icon(
                      Icons.play_arrow,
                      color: CustomColor.whiteColor,
                      size: Dimensions.iconSizeLarge,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                verticalSpace(Dimensions.heightSize * .15),
                Row(
                  mainAxisAlignment: mainSpaceBet,
                  crossAxisAlignment: crossEnd,
                  children: [
                    Expanded(
                      child: TitleHeading5Widget(
                        text: video.itemTitle,
                        maxLines: 2,
                        color: CustomColor.primaryLightTextColor,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.headingTextSize6,
                      ),
                    ),
                    TitleHeading5Widget(
                      text: video.createdAt.showFullDate,
                      color: CustomColor.primaryLightColor,
                      fontWeight: FontWeight.w500,
                      fontSize: Dimensions.headingTextSize8 * 1,
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: Dimensions.paddingHorizontalSize * .25,
                  vertical: Dimensions.paddingVerticalSize * .1,
                ),
                Expanded(
                  child: TitleHeading5Widget(
                    text: video.itemDescription,
                    fontWeight: FontWeight.w400,
                    maxLines: 3,
                    textOverflow: TextOverflow.ellipsis,
                    color: CustomColor.primaryLightTextColor.withOpacity(.6),
                    fontSize: Dimensions.headingTextSize8 * 1.15,
                  ).paddingSymmetric(
                    horizontal: Dimensions.paddingHorizontalSize * .25,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
