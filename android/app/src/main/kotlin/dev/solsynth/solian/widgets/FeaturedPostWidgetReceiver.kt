package dev.solsynth.solian.widgets

import FeaturedPostWidget
import HomeWidgetGlanceWidgetReceiver

class FeaturedPostWidgetReceiver : HomeWidgetGlanceWidgetReceiver<FeaturedPostWidget>() {
    override val glanceAppWidget = FeaturedPostWidget()
}