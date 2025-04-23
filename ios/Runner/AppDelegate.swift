import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

  GeneratedPluginRegistrant.register(with:self)

    // Ensure the plugin registrar is found
//    if let registrar = self.registrar(forPlugin: "airplay_view") {
//        let factory = AirPlayViewFactory(messenger: registrar.messenger())
//        registrar.register(factory, withId: "airplay_view")
//    } else {
//        print("⚠️ Could not find plugin registrar for 'airplay_view'")
//    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}