package net.appdevs.adradio


import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity: FlutterActivity() {
    private val CHANNEL = "audio_cast_picker"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "showCastPicker") {
                openCastPicker()
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun openCastPicker() {
        try {
//            val intent = Intent("android.settings.MEDIA_OUTPUT")
            val intent = Intent("com.android.settings.panel.action.MEDIA_OUTPUT")
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

}
