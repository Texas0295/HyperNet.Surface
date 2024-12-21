import android.content.Context
import android.net.Uri
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
import androidx.glance.layout.fillMaxHeight
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.state.GlanceStateDefinition
import androidx.glance.text.FontFamily
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import com.google.gson.FieldNamingPolicy
import com.google.gson.GsonBuilder
import dev.solsynth.solian.data.InstantAdapter
import dev.solsynth.solian.data.SolarCheckInRecord
import java.time.Instant
import java.time.LocalDate
import java.time.OffsetDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter

class CheckInWidget : GlanceAppWidget() {
    override val stateDefinition: GlanceStateDefinition<*>?
        get() = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceContent(context, currentState())
        }
    }

    @Composable
    private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState) {
        val gson =
            GsonBuilder()
                .setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
                .registerTypeAdapter(Instant::class.java, InstantAdapter())
                .create()
        val resultTierSymbols = listOf("大凶", "凶", "中平", "吉", "大吉")

        val prefs = currentState.preferences
        val checkInRaw = prefs.getString("pas_check_in_record", null)

        Column(
            modifier = GlanceModifier
                .fillMaxWidth()
                .fillMaxHeight()
                .background(Color.White)
                .padding(16.dp)
        ) {
            if (checkInRaw != null) {
                val checkIn: SolarCheckInRecord =
                    gson.fromJson(checkInRaw, SolarCheckInRecord::class.java)
                val dateFormatter = DateTimeFormatter.ofPattern("EEE, MM/dd")

                val checkDate = checkIn.createdAt.atZone(ZoneId.of("UTC")).toLocalDate()
                val currentDate = LocalDate.now()
                if (checkDate.isEqual(currentDate)) {
                    Column {
                        Text(
                            text = resultTierSymbols[checkIn.resultTier],
                            style = TextStyle(fontSize = 25.sp, fontFamily = FontFamily.Serif)
                        )
                        Text(
                            text = "+${checkIn.resultExperience} EXP",
                            style = TextStyle(fontSize = 15.sp, fontFamily = FontFamily.Monospace)
                        )
                    }
                    Spacer(modifier = GlanceModifier.height(8.dp))
                    Row(horizontalAlignment = Alignment.CenterHorizontally) {
                        Text(
                            text = OffsetDateTime.ofInstant(
                                checkIn.createdAt,
                                ZoneId.systemDefault()
                            )
                                .format(dateFormatter),
                            style = TextStyle(fontSize = 13.sp)
                        )
                    }

                    return@Column;
                }
            }
        }

        Text(
            text = "You haven't checked in today",
            style = TextStyle(fontSize = 15.sp)
        )
    }
}
