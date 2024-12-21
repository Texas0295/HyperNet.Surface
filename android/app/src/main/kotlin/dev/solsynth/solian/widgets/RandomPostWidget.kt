import android.content.Context
import android.graphics.Bitmap
import android.graphics.BitmapFactory
import android.net.Uri
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.glance.GlanceId
import androidx.glance.GlanceModifier
import androidx.glance.GlanceTheme
import androidx.glance.Image
import androidx.glance.ImageProvider
import androidx.glance.action.clickable
import androidx.glance.appwidget.GlanceAppWidget
import androidx.glance.appwidget.cornerRadius
import androidx.glance.appwidget.provideContent
import androidx.glance.background
import androidx.glance.currentState
import androidx.glance.layout.Alignment
import androidx.glance.layout.Column
import androidx.glance.layout.ContentScale
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
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.Response
import okio.IOException
import java.time.Instant
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.format.DateTimeFormatter

class RandomPostWidget : GlanceAppWidget() {
    override val stateDefinition: GlanceStateDefinition<*>?
        get() = HomeWidgetGlanceStateDefinition()

    private val defaultUrl = "https://api.sn.solsynth.dev"

    override suspend fun provideGlance(context: Context, id: GlanceId) {
        provideContent {
            GlanceTheme {
                GlanceContent(context, currentState(), null)
            }
        }
    }

    private val client = OkHttpClient()

    private fun resizeBitmap(bitmap: Bitmap, maxWidth: Int, maxHeight: Int): Bitmap {
        val aspectRatio = bitmap.width.toFloat() / bitmap.height.toFloat()
        val newWidth = if (bitmap.width > maxWidth) maxWidth else bitmap.width
        val newHeight = (newWidth / aspectRatio).toInt()
        val resizedBitmap = Bitmap.createScaledBitmap(bitmap, newWidth, newHeight, true)
        return resizedBitmap
    }

    private fun loadImageFromUrl(url: String): Bitmap? {
        val request = Request.Builder().url(url).build()

        return try {
            val response: Response = client.newCall(request).execute()
            val inputStream = response.body?.byteStream()
            val bitmap = BitmapFactory.decodeStream(inputStream)
            resizeBitmap(bitmap, 120, 120)
        } catch (e: IOException) {
            e.printStackTrace()
            null
        }
    }

    @Composable
    private fun GlanceContent(
        context: Context,
        currentState: HomeWidgetGlanceState,
        avatar: Bitmap?
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
                .background(Color.White)
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
                    if (avatar != null) {
                        Image(
                            provider = ImageProvider(bitmap = avatar),
                            contentDescription = null,
                            modifier = GlanceModifier.width(36.dp).height(36.dp)
                                .cornerRadius(18.dp),
                            contentScale = ContentScale.Crop
                        )
                        Spacer(modifier = GlanceModifier.width(8.dp))
                    }

                    Text(
                        text = data.publisher.nick,
                        style = TextStyle(fontSize = 15.sp)
                    )
                    Spacer(modifier = GlanceModifier.width(8.dp))
                    Text(
                        text = "@${data.publisher.name}",
                        style = TextStyle(fontSize = 13.sp, fontFamily = FontFamily.Monospace)
                    )
                }

                Spacer(modifier = GlanceModifier.height(8.dp))

                if (data.body.title != null) {
                    Text(
                        text = data.body.title,
                        style = TextStyle(fontSize = 25.sp)
                    )
                }
                if (data.body.description != null) {
                    Text(
                        text = data.body.description,
                        style = TextStyle(fontSize = 19.sp)
                    )
                }

                if (data.body.title != null || data.body.description != null) {
                    Spacer(modifier = GlanceModifier.height(8.dp))
                }

                Text(
                    text = data.body.content ?: "No content",
                    style = TextStyle(fontSize = 15.sp),
                )

                Spacer(modifier = GlanceModifier.height(8.dp))


                Text(
                    LocalDateTime.ofInstant(data.createdAt, ZoneId.systemDefault())
                        .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")),
                    style = TextStyle(fontSize = 13.sp),
                )

                Text(
                    "#${data.id}",
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
                    text = "Unable to fetch post",
                    style = TextStyle(fontSize = 17.sp, fontWeight = FontWeight.Bold)
                )
                Text(
                    text = "Check your internet connection",
                    style = TextStyle(fontSize = 15.sp)
                )
            }
        }
    }
}
