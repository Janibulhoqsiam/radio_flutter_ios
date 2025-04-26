import Foundation
import MediaPlayer
import Flutter

class AirplayRoutePickerViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return AirplayRoutePickerView(frame: frame)
    }
}

class AirplayRoutePickerView: NSObject, FlutterPlatformView {
    private var _view: UIView

    init(frame: CGRect) {
        let routePickerView = AVRoutePickerView(frame: frame)
        routePickerView.activeTintColor = UIColor.systemBlue
        routePickerView.tintColor = UIColor.gray
        _view = routePickerView
        super.init()
    }

    func view() -> UIView {
        return _view
    }
}
