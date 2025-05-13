// import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart'; // General WebView import
//
// class LivetvController extends GetxController {
//   var isLoading = false.obs;
//   WebViewController? webViewController;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // Initialize WebViewController
//     webViewController = WebViewController();
//
//     // Set platform-specific parameters if needed
//     if (GetPlatform.isAndroid) {
//       webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
//       webViewController?.setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Handle loading progress
//           },
//           onPageStarted: onPageStarted,
//           onPageFinished: onPageFinished,
//           onHttpError: (HttpResponseError error) {},
//           onWebResourceError: (WebResourceError error) {},
//         ),
//       );
//     } else if (GetPlatform.isIOS ) {
//       webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
//       webViewController?.setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Handle loading progress
//           },
//           onPageStarted: onPageStarted,
//           onPageFinished: onPageFinished,
//           onHttpError: (HttpResponseError error) {},
//           onWebResourceError: (WebResourceError error) {},
//         ),
//       );
//     }
//     // Optionally, load a URL initially
//     webViewController?.loadRequest(Uri.parse('https://www.apintie.sr/tv'));
//   }
//
//   void onPageStarted(String url) {
//     isLoading.value = true;
//   }
//
//   void onPageFinished(String url) {
//     isLoading.value = false;
//
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LivetvController extends GetxController {
  var isLoading = false.obs;
  WebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController();

    // Common JavaScript mode and navigation delegate
    webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController?.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: onPageStarted,
        onPageFinished: onPageFinished,
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );

    // Load the appropriate URL
    loadAppropriateUrl();
  }

  void loadAppropriateUrl() {
    String url = getDeviceSpecificUrl();
    webViewController?.loadRequest(Uri.parse(url));
  }

  String getDeviceSpecificUrl() {
    // Default URL
    String url = 'https://www.apintie.sr/app/live.php';

    // Check if context is available
    if (Get.context != null) {
      // Get screen width
      final screenWidth = MediaQuery.of(Get.context!).size.width;

      // Use 600 as an approximate threshold for tablets (can be adjusted)
      if (screenWidth >= 600) {
        url = 'https://www.apintie.sr/app/live2.php';
      } else {
        url = 'https://www.apintie.sr/app/live.php';
      }
    }

    return url;
  }

  void onPageStarted(String url) {
    isLoading.value = true;
  }

  void onPageFinished(String url) {
    isLoading.value = false;
  }
}

