import UIKit
import Flutter
import AVKit
import MediaPlayer


@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

  GeneratedPluginRegistrant.register(with:self)

  let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
  let factory = AirplayRoutePickerViewFactory(messenger: controller.binaryMessenger)
  registrar(forPlugin: "airplay_view")?.register(factory, withId: "AirplayRoutePicker")



    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
