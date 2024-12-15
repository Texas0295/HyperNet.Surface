import android.content.Context
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.Row
import androidx.glance.layout.Spacer
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
import coil3.ImageLoader
import coil3.compose.AsyncImage
import coil3.compose.setSingletonImageLoaderFactory
import coil3.request.crossfade
import com.google.gson.FieldNamingPolicy
import com.google.gson.GsonBuilder
import dev.solsynth.solian.data.InstantAdapter
import dev.solsynth.solian.data.SolarPost
import java.time.Instant
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter


class FeaturedPostWidget : GlanceAppWidget() {
    override val stateDefinition: GlanceStateDefinition<*>?
        get() = HomeWidgetGlanceStateDefinition()

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceContent(context, currentState())
        }
    }

    private val serverUrl = "https://api.sn.solsynth.dev"

    private fun getAttachmentUrl(identifier: String): String {
        return if (identifier.startsWith("http")) {
            identifier
        } else {
            "$serverUrl/cgi/uc/attachments/$identifier"
        }
    }

    @Composable
    private fun GlanceContent(context: Context, currentState: HomeWidgetGlanceState) {
        setSingletonImageLoaderFactory { context ->
            ImageLoader.Builder(context)
                .crossfade(true)
                .build()
        }

        val gson =
            GsonBuilder()
                .setFieldNamingPolicy(FieldNamingPolicy.LOWER_CASE_WITH_UNDERSCORES)
                .registerTypeAdapter(Instant::class.java, InstantAdapter())
                .create()

        val prefs = currentState.preferences
        val postFeaturedRaw = prefs.getString("post_featured", null)

        Column(
            modifier = GlanceModifier
                .fillMaxWidth()
                .background(Color.White)
                .padding(16.dp)
        ) {
            if (postFeaturedRaw != null) {
                val postFeaturedList: Array<SolarPost> =
                    gson.fromJson(postFeaturedRaw, Array<SolarPost>::class.java)
                val postFeatured = postFeaturedList.firstOrNull();

                Row {
                    Text(
                        text = postFeatured?.publisher?.nick ?: "Unknown",
                        style = TextStyle(fontSize = 15.sp)
                    )
                    Spacer(modifier = GlanceModifier.width(8.dp))
                    Text(
                        text = "@${postFeatured?.publisher?.name}",
                        style = TextStyle(fontSize = 13.sp, fontFamily = FontFamily.Monospace)
                    )
                }

                Spacer(modifier = GlanceModifier.height(8.dp))

                if (postFeatured?.body?.title != null) {
                    Text(
                        text = postFeatured.body.title,
                        style = TextStyle(fontSize = 25.sp, fontFamily = FontFamily.Serif)
                    )
                }
                if (postFeatured?.body?.description != null) {
                    Text(
                        text = postFeatured.body.description,
                        style = TextStyle(fontSize = 19.sp, fontFamily = FontFamily.Serif)
                    )
                }

                if (postFeatured?.body?.title != null || postFeatured?.body?.description != null) {
                    Spacer(modifier = GlanceModifier.height(8.dp))
                }

                Text(
                    text = postFeatured?.body?.content ?: "No content",
                    style = TextStyle(fontSize = 15.sp),
                )

                Spacer(modifier = GlanceModifier.height(8.dp))


                if (postFeatured?.createdAt != null) {
                    Text(
                        LocalDateTime.ofInstant(postFeatured.createdAt, ZoneId.systemDefault())
                            .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")),
                        style = TextStyle(fontSize = 13.sp),
                    )
                }

                Text(
                    "Solar Network Featured Post",
                    style = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Bold),
                )

                return@Column;
            }

            Column(
                modifier = GlanceModifier.fillMaxSize(),
                verticalAlignment = Alignment.Vertical.CenterVertically,
                horizontalAlignment = Alignment.Horizontal.CenterHorizontally
            ) {
                Text(
                    text = "No featured posts",
                    style = TextStyle(fontSize = 17.sp, fontWeight = FontWeight.Bold)
                )
                Text(
                    text = "Open the app to load recommendations",
                    style = TextStyle(fontSize = 15.sp)
                )
            }
        }
    }
}
