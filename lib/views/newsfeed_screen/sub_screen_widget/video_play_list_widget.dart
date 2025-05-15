import 'package:adradio/extensions/custom_extensions.dart';

import '../../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import 'video_widget.dart';

class VideoPlayListWidget extends StatelessWidget {
  VideoPlayListWidget({super.key});
  final controller = Get.find<NewsfeedController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _videoPlaylistTitleWidget(context),
        _videoPlaylistWidget(context),
      ],
    );
  }

  _videoPlaylistTitleWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * .5,
          vertical: Dimensions.marginSizeVertical * .4),
      height: MediaQuery.sizeOf(context).height * .03,
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          TitleHeading2Widget(
            text: Strings.videoPlaylist,
            color: CustomColor.primaryLightTextColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.headingTextSize2,
          ),
          InkWell(
            onTap: () {
              Routes.videosScreen.toNamed;
            },
            child: TitleHeading5Widget(
              text: Strings.viewAll,
              color: CustomColor.primaryLightColor,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.headingTextSize7 * 1.2,
            ),
          ),
        ],
      ),
    );
  }

  _videoPlaylistWidget(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * .5,
        ),
        height: MediaQuery.sizeOf(context).height * .24,
        child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return VideoWidget(
                video: controller.dashboardModel!.data.videos.videos[index],
              );
            },
            separatorBuilder: (_, i) => horizontalSpace(5),
            itemCount: controller.dashboardModel!.data.videos.videos.length));
  }
}
