
import '../../../controller/newsfeed_controller/newsfeed_controller.dart';
import '../../../utils/basic_screen_imports.dart';

// class ShowTimeWidget extends StatelessWidget {
//   ShowTimeWidget({super.key});
//
//   final nextShow = Get.find<NewsfeedController>().dashboardModel.data.nextShow;
//
//   final nextShowData =
//       Get.find<NewsfeedController>().dashboardModel.data.nextShow.nextShow;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(
//           horizontal: Dimensions.marginSizeHorizontal * .5),
//       height: MediaQuery.sizeOf(context).height * .24,
//       child: Stack(
//         children: [
//           Container(
//             width: MediaQuery.sizeOf(context).width,
//             margin: EdgeInsets.only(
//               top: Dimensions.marginSizeVertical * 2,
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(Dimensions.radius),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 1,
//                   blurRadius: 10,
//                   offset: const Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Padding(
//                     padding: EdgeInsets.only(
//                         left: MediaQuery.sizeOf(context).width * .43),
//                     child: SizedBox(
//                       width: MediaQuery.sizeOf(context).width * .5,
//                       child: Column(
//                         crossAxisAlignment: crossStart,
//                         children: [
//                           FittedBox(
//                             child: Row(
//                               children: [
//                                 horizontalSpace(
//                                     Dimensions.paddingHorizontalSize * 1.4),
//                                 Container(
//                                   height: MediaQuery.sizeOf(context).height * .06,
//                                   width: MediaQuery.sizeOf(context).width * .115,
//                                   decoration: BoxDecoration(
//                                     color: CustomColor.primaryLightColor,
//                                     borderRadius: BorderRadius.only(
//                                       bottomRight:
//                                           Radius.circular(Dimensions.radius * 5),
//                                       bottomLeft:
//                                           Radius.circular(Dimensions.radius * 5),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: crossEnd,
//                                     children: [
//                                       TitleHeading5Widget(
//                                         text: Strings.next,
//                                         maxLines: 1,
//                                         textOverflow: TextOverflow.ellipsis,
//                                         color: CustomColor.whiteColor,
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: Dimensions.headingTextSize7,
//                                       ).paddingOnly(
//                                         top: Dimensions.paddingVerticalSize * .35,
//                                         right: Dimensions.paddingHorizontalSize *
//                                             .15,
//                                       ),
//                                       TitleHeading5Widget(
//                                         text: Strings.show,
//                                         color: CustomColor.whiteColor,
//                                         maxLines: 1,
//                                         textOverflow: TextOverflow.ellipsis,
//                                         fontWeight: FontWeight.w800,
//                                         fontSize: Dimensions.headingTextSize5,
//                                       ).paddingOnly(
//                                         right: Dimensions.paddingHorizontalSize *
//                                             .15,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 horizontalSpace(
//                                     Dimensions.paddingHorizontalSize * .4),
//                                 Column(
//                                   crossAxisAlignment: crossStart,
//                                   children: [
//                                     TitleHeading4Widget(
//                                       text: Strings.showTime,
//                                       color: CustomColor.primaryLightTextColor,
//                                       maxLines: 1,
//                                       textOverflow: TextOverflow.ellipsis,
//                                       fontWeight: FontWeight.w700,
//                                       fontSize: Dimensions.headingTextSize7 * 1.2,
//                                     ),
//                                     TitleHeading5Widget(
//                                       text: nextShowData.day.name,
//                                       color: CustomColor.primaryLightTextColor
//                                           .withOpacity(.60),
//                                       maxLines: 1,
//                                       textOverflow: TextOverflow.ellipsis,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: Dimensions.headingTextSize8 * 1.3,
//                                     ),
//                                     TitleHeading5Widget(
//                                       text:
//                                           "${nextShowData.startTime} - ${nextShowData.endTime}",
//                                       color: CustomColor.primaryLightColor,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: Dimensions.headingTextSize7,
//                                     ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           verticalSpace(Dimensions.paddingVerticalSize * .2),
//                           TitleHeading5Widget(
//                             text: nextShowData.name,
//                             fontSize: Dimensions.headingTextSize6 * 1,
//                             maxLines: 1,
//                             textOverflow: TextOverflow.ellipsis,
//                             fontWeight: FontWeight.w600,
//                           ).paddingOnly(
//                             bottom: Dimensions.paddingVerticalSize * .15,
//                           ),
//                           TitleHeading5Widget(
//                             text: nextShowData.description,
//                             color: CustomColor.primaryLightTextColor
//                                 .withOpacity(.6),
//                             maxLines: 3,
//                             textOverflow: TextOverflow.ellipsis,
//                             fontSize: Dimensions.headingTextSize8 * 1.15,
//                             fontWeight: FontWeight.w500,
//                           ).paddingOnly(
//                             bottom: Dimensions.paddingVerticalSize * .2,
//                           ),
//                           FittedBox(
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal:
//                                     Dimensions.paddingHorizontalSize * .4,
//                                 vertical: Dimensions.paddingVerticalSize * .1,
//                               ),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: CustomColor.primaryLightColor
//                                       .withOpacity(.2),
//                                   width: .75,
//                                 ),
//                                 borderRadius: BorderRadius.circular(
//                                     Dimensions.radius * .75),
//                                 color: CustomColor.primaryLightColor
//                                     .withOpacity(.15),
//                               ),
//                               child: TitleHeading5Widget(
//                                 maxLines: 1,
//                                 text: nextShowData.host,
//                                 fontSize: Dimensions.headingTextSize8 * .80,
//                                 fontWeight: FontWeight.w700,
//                                 color: CustomColor.primaryLightColor,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ))
//               ],
//             ),
//           ),
//           Container(
//             width: MediaQuery.sizeOf(context).width * 0.35,
//             height: MediaQuery.sizeOf(context).width * 0.1,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(
//                     "${nextShow.baseUrl}/${nextShow.imagePath}/${nextShowData.image}"),
//                 fit: BoxFit.fill,
//               ),
//               // color: Colors.blueAccent,
//             ),
//           ),
//
//
//
//
//         ],
//       ),
//     );
//   }
// }




class ShowTimeWidget extends StatelessWidget {
  ShowTimeWidget({super.key});

  final nextShow = Get.find<NewsfeedController>().dashboardModel?.data.nextShow;
  final nextShowData =
      Get.find<NewsfeedController>().dashboardModel?.data.nextShow.nextShow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * .7,
      ),
      height: MediaQuery.sizeOf(context).height * .18,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image side
          Container(
            width: MediaQuery.sizeOf(context).width * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius),
                bottomLeft: Radius.circular(Dimensions.radius),
              ),
              image: DecorationImage(
                image: NetworkImage(
                    "${nextShow?.baseUrl}/${nextShow?.imagePath}/${nextShowData?.image}"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          // Content side
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(Dimensions.paddingHorizontalSize * 0.7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * .06,
                        width: MediaQuery.sizeOf(context).width * .115,
                        decoration: BoxDecoration(
                          color: CustomColor.primaryLightColor,
                          borderRadius: BorderRadius.only(
                            bottomRight:
                            Radius.circular(Dimensions.radius * 5),
                            bottomLeft:
                            Radius.circular(Dimensions.radius * 5),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TitleHeading5Widget(
                              text: Strings.next,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              color: CustomColor.whiteColor,
                              fontWeight: FontWeight.w800,
                              fontSize: Dimensions.headingTextSize7,
                            ).paddingOnly(
                              top: Dimensions.paddingVerticalSize * .35,
                              right:
                              Dimensions.paddingHorizontalSize * .15,
                            ),
                            TitleHeading5Widget(
                              text: Strings.show,
                              color: CustomColor.whiteColor,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w800,
                              fontSize: Dimensions.headingTextSize5,
                            ).paddingOnly(
                              right:
                              Dimensions.paddingHorizontalSize * .15,
                            ),
                          ],
                        ),
                      ),
                      horizontalSpace(Dimensions.paddingHorizontalSize * .4),
                      Column(
                        crossAxisAlignment: crossCenter,
                        children: [
                          TitleHeading4Widget(
                            text: Strings.showTime,
                            color: CustomColor.primaryLightTextColor,
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w700,
                            fontSize: Dimensions.headingTextSize7 * 1.2,
                          ),
                          TitleHeading5Widget(
                            text: nextShowData!.day.name,
                            color: CustomColor.primaryLightTextColor
                                .withOpacity(.60),
                            maxLines: 1,
                            textOverflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.headingTextSize8 * 1.3,
                          ),
                          TitleHeading5Widget(
                            text:
                            "${nextShowData?.startTime} - ${nextShowData?.endTime}",
                            color: CustomColor.primaryLightColor,
                            fontWeight: FontWeight.w500,
                            fontSize: Dimensions.headingTextSize7,
                          ),
                        ],
                      )
                    ],
                  ),
                  verticalSpace(Dimensions.paddingVerticalSize * .2),
                  TitleHeading5Widget(
                    text: nextShowData!.name,
                    fontSize: Dimensions.headingTextSize6 * 1,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  ).paddingOnly(
                    bottom: Dimensions.paddingVerticalSize * .15,
                  ),
                  TitleHeading5Widget(
                    text: nextShowData!.description,
                    color:
                    CustomColor.primaryLightTextColor.withOpacity(.6),
                    maxLines: 3,
                    textOverflow: TextOverflow.ellipsis,
                    fontSize: Dimensions.headingTextSize8 * 1.15,
                    fontWeight: FontWeight.w500,
                  ).paddingOnly(
                    bottom: Dimensions.paddingVerticalSize * .2,
                  ),
                  FittedBox(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingHorizontalSize * .4,
                        vertical: Dimensions.paddingVerticalSize * .1,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: CustomColor.primaryLightColor
                              .withOpacity(.2),
                          width: .75,
                        ),
                        borderRadius: BorderRadius.circular(
                            Dimensions.radius * .75),
                        color: CustomColor.primaryLightColor
                            .withOpacity(.15),
                      ),
                      child: TitleHeading5Widget(
                        maxLines: 1,
                        text: nextShowData!.host,
                        fontSize: Dimensions.headingTextSize8 * .80,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.primaryLightColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
