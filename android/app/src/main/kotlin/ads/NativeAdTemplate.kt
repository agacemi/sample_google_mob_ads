package ads

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class NativeAdTemplate(private val context: Context, private val factoryId: String) : GoogleMobileAdsPlugin.NativeAdFactory {

    override fun createNativeAd(nativeAd: NativeAd, customOptions: MutableMap<String, Any>?): NativeAdView {

        val nativeAdView = when (factoryId) {
            FactoryIds.HORIZONTAL_TEMPLATE -> LayoutInflater.from(context).inflate(R.layout.horizontal_native_ad, null, false) as NativeAdView
            else -> LayoutInflater.from(context).inflate(R.layout.vertical_native_ad, null, false) as NativeAdView
        }

        with(nativeAdView) {
            this.iconView = buildIconAndAttributions(nativeAd)
            this.headlineView = buildHeadline(nativeAd)
            this.bodyView = buildBody(nativeAd)
            setNativeAd(nativeAd)
        }

        return nativeAdView
    }

    private fun NativeAdView.buildIconAndAttributions(nativeAd: NativeAd): ImageView? {

        val iconView = findViewById<ImageView>(R.id.iv_native_ad_icon)
        val icons = nativeAd.images
        if (icons.isNotEmpty()) {
            iconView.setImageDrawable(icons[0].drawable)
        }
        return iconView
    }

    private fun NativeAdView.buildBody(nativeAd: NativeAd): TextView? =
        findViewById<TextView>(R.id.tv_native_ad_body)?.also {
            it.text = nativeAd.body
            it.visibility = if (nativeAd.body.isNullOrEmpty()) View.INVISIBLE else View.VISIBLE
        }

    private fun NativeAdView.buildHeadline(nativeAd: NativeAd): TextView? {
        val headlineView = findViewById<TextView>(R.id.tv_native_ad_headline)
        headlineView.text = nativeAd.headline
        return headlineView
    }
}
