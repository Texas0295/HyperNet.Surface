package dev.solsynth.solian.widgets

import RandomPostWidget
import HomeWidgetGlanceWidgetReceiver

class RandomPostWidgetReceiver : HomeWidgetGlanceWidgetReceiver<RandomPostWidget>() {
    override val glanceAppWidget = RandomPostWidget()
}