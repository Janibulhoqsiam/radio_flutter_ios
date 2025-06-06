import 'package:flutter_svg/svg.dart';

import '../../custom_assets/assets.gen.dart';
import '../../utils/basic_screen_imports.dart';
import '../../widgets/others/title_subtitle_widget.dart';

class CongratulationScreenMobile extends StatelessWidget {
  const CongratulationScreenMobile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.route,
  });
  final String title, subTitle, route;

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Get.offAllNamed(route);
        return true;
      },
      child: Scaffold(
        body: _bodyWidget(
          context,
        ),
      ),
    );
  }

  // body widget containing all widget elements
  _bodyWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _congratulationImageWidget(
            context,
          ),
          verticalSpace(Dimensions.heightSize * 2),
          _congratulationInfoWidget(
            context,
          ),
          verticalSpace(Dimensions.heightSize * 1.33),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal),
      child: PrimaryButton(
        title: Strings.okay,
        onPressed: () {
          Get.offAllNamed(route);
        },
      ),
    );
  }

  _congratulationImageWidget(
      BuildContext context,
      ) {
    return SvgPicture.asset(
      Assets.clipart.congratulationLogo,
    );
  }

  _congratulationInfoWidget(
      BuildContext context,
      ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.marginSizeHorizontal*2),
      child: Column(
        children: [
          TitleSubTitleWidget(
            title: title,
            titleFontSize: Dimensions.headingTextSize1,
            subTitle: subTitle,
            isCenterText: true,
          ),
        ],
      ),
    );
  }
}