package ads

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterFragmentActivity() {
    override fun onCreate(
        savedInstanceState: android.os.Bundle?,
        persistentState: android.os.PersistableBundle?
    ) {
        super.onCreate(savedInstanceState, persistentState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            FactoryIds.HORIZONTAL_TEMPLATE,
            NativeAdTemplate(this, FactoryIds.HORIZONTAL_TEMPLATE)
        )

        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            FactoryIds.VERTICAL_TEMPLATE,
            NativeAdTemplate(this, FactoryIds.VERTICAL_TEMPLATE)
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        super.cleanUpFlutterEngine(flutterEngine)

        GoogleMobileAdsPlugin.unregisterNativeAdFactory(
            flutterEngine,
            FactoryIds.HORIZONTAL_TEMPLATE
        )

        GoogleMobileAdsPlugin.unregisterNativeAdFactory(
            flutterEngine,
            FactoryIds.VERTICAL_TEMPLATE
        )
    }
}
