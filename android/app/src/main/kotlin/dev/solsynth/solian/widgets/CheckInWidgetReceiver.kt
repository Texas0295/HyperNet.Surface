package dev.solsynth.solian.widgets

import CheckInWidget
import HomeWidgetGlanceWidgetReceiver

class CheckInWidgetReceiver : HomeWidgetGlanceWidgetReceiver<CheckInWidget>() {
    override val glanceAppWidget = CheckInWidget()
}