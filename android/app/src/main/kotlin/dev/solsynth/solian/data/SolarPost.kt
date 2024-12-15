package dev.solsynth.solian.data

import androidx.annotation.Keep
import java.time.Instant

@Keep
data class SolarPost(
    val id: Int,
    val body: SolarPostBody,
    val publisher: SolarPublisher,
    val publisherId: Int,
    val createdAt: Instant,
    val updatedAt: Instant,
    val editedAt: Instant?,
    val publishedAt: Instant?
)

@Keep
data class SolarPostBody(
    val content: String?,
    val title: String?,
    val description: String?,
)

@Keep
data class SolarPublisher(
    val id: Int,
    val name: String,
    val nick: String,
    val description: String?,
    val avatar: String?,
    val banner: String?,
    val createdAt: Instant,
    val updatedAt: Instant
)