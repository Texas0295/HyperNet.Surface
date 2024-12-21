import HomeWidgetGlanceState
import HomeWidgetGlanceStateDefinition
import android.content.Context
import android.net.Uri
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
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
import androidx.glance.layout.fillMaxSize
import androidx.glance.layout.fillMaxWidth
import androidx.glance.layout.height
import androidx.glance.layout.padding
import androidx.glance.layout.width
import androidx.glance.state.GlanceStateDefinition
import androidx.glance.text.FontFamily
import androidx.glance.text.FontWeight
import androidx.glance.text.Text
import androidx.glance.text.TextStyle
import com.google.gson.FieldNamingPolicy
import com.google.gson.GsonBuilder
import dev.solsynth.solian.MainActivity
import dev.solsynth.solian.data.InstantAdapter
import dev.solsynth.solian.data.SolarPost
import es.antonborri.home_widget.actionStartActivity
import java.time.Instant
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter

class RandomPostWidget : GlanceAppWidget() {
    override val stateDefinition: GlanceStateDefinition<*>?
        get() = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceTheme {
                GlanceContent(context, currentState())
            }
        }
    }

    @Composable
    private fun GlanceContent(
        context: Context,
        currentState: HomeWidgetGlanceState,
    ) {
        val prefs = currentState.preferences
        val postRaw = prefs.getString("int_random_post", null)

        val gson =
            GsonBuilder()
                .setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
                .registerTypeAdapter(Instant::class.java, InstantAdapter())
                .create()

        val data: SolarPost? = postRaw?.let { postRaw ->
            gson.fromJson(postRaw, SolarPost::class.java)
        } ?: null;

        Column(
            modifier = GlanceModifier
                .fillMaxWidth()
                .fillMaxHeight()
                .background(GlanceTheme.colors.widgetBackground)
                .padding(16.dp)
                .clickable(
                    onClick = actionStartActivity<MainActivity>(
                        context,
                        Uri.parse("https://sn.solsynth.dev/posts/${data!!.id}")
                    )
                )
        ) {
            if (data != null) {
                Row(verticalAlignment = Alignment.CenterVertically) {
                    Text(
                        text = data.publisher.nick,
                        style = TextStyle(fontSize = 15.sp, color = GlanceTheme.colors.onSurface)
                    )
                    Spacer(modifier = GlanceModifier.width(8.dp))
                    Text(
                        text = "@${data.publisher.name}",
                        style = TextStyle(
                            fontSize = 13.sp,
                            fontFamily = FontFamily.Monospace,
                            color = GlanceTheme.colors.onSurface
                        )
                    )
                }

                Spacer(modifier = GlanceModifier.height(8.dp))

                if (data.body.title != null) {
                    Text(
                        text = data.body.title,
                        style = TextStyle(fontSize = 19.sp, color = GlanceTheme.colors.onSurface)
                    )
                }
                if (data.body.description != null) {
                    Text(
                        text = data.body.description,
                        style = TextStyle(fontSize = 17.sp, color = GlanceTheme.colors.onSurface)
                    )
                }

                if (data.body.title != null || data.body.description != null) {
                    Spacer(modifier = GlanceModifier.height(8.dp))
                }

                Text(
                    text = data.body.content ?: "No content",
                    style = TextStyle(fontSize = 15.sp, color = GlanceTheme.colors.onSurface),
                )

                Spacer(modifier = GlanceModifier.height(8.dp))


                Text(
                    LocalDateTime.ofInstant(data.createdAt, ZoneId.systemDefault())
                        .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")),
                    style = TextStyle(fontSize = 13.sp, color = GlanceTheme.colors.onSurface),
                )

                Text(
                    "#${data.id}",
                    style = TextStyle(
                        fontSize = 11.sp,
                        fontWeight = FontWeight.Bold,
                        color = GlanceTheme.colors.onSurface
                    ),
                )

                return@Column;
            }

            Column(
                modifier = GlanceModifier.fillMaxSize(),
                verticalAlignment = Alignment.Vertical.CenterVertically,
                horizontalAlignment = Alignment.Horizontal.CenterHorizontally
            ) {
                Text(
                    text = "No Recommendations",
                    style = TextStyle(
                        fontSize = 17.sp,
                        fontWeight = FontWeight.Bold,
                        color = GlanceTheme.colors.onSurface
                    )
                )
                Text(
                    text = "Open app to load some posts",
                    style = TextStyle(fontSize = 15.sp, color = GlanceTheme.colors.onSurface)
                )
            }
        }
    }
}
