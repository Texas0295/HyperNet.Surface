package dev.solsynth.solian.data

import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.google.gson.JsonParseException
import com.google.gson.JsonPrimitive
import com.google.gson.JsonSerializationContext
import com.google.gson.JsonSerializer
import java.lang.reflect.Type
import java.time.Instant
import java.time.format.DateTimeFormatter


class InstantAdapter : JsonSerializer<Instant?>,
    JsonDeserializer<Instant?> {
    override fun serialize(
        src: Instant?,
        typeOfSrc: Type?,
        context: JsonSerializationContext?
    ): JsonElement {
        return JsonPrimitive(formatter.format(src))
    }

    @Throws(JsonParseException::class)
    override fun deserialize(
        json: JsonElement,
        typeOfT: Type?,
        context: JsonDeserializationContext?
    ): Instant {
        return Instant.parse(json.asString)
    }

    companion object {
        private val formatter: DateTimeFormatter = DateTimeFormatter.ISO_INSTANT
    }
}