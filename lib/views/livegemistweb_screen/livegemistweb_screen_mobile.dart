import 'package:adradio/controller/livegemist_controller/livegemist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../backend/utils/custom_loading_api.dart';

class livegemistweb_screen extends StatelessWidget {
  livegemistweb_screen({Key? key}) : super(key: key);

  // Get the instance of the controller
  final LivegemistController controller = Get.put(LivegemistController());

  // Define the URL in the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.isLoading.value
          ? const CustomLoadingAPI()
          : WebViewWidget(
          controller: controller.webViewController!)), // Use the controller's WebViewController
    );
  }
}




