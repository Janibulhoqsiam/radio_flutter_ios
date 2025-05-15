import '../../backend/model/dashboard/dashboard_model.dart';
import '../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../newsfeed_screen/sub_screen_widget/video_widget.dart';

class VideosScreenMobile extends StatelessWidget {
  const VideosScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
          appBar: PrimaryAppBar(
            Strings.videoPlaylist,
            centerTitle: false,
            appbarSize: Dimensions.heightSize * 4,
          ),
          body: _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    List<Video>? videos =
        Get.find<NewsfeedController>().dashboardModel?.data.videos.videos;
    return ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.marginSizeHorizontal * .5,
        ),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return VideoWidget(
            isFullScreen: true,
            video: videos[index],
          );
        },
        separatorBuilder: (_, i) => verticalSpace(10),
        itemCount: videos!.length);
  }
}
