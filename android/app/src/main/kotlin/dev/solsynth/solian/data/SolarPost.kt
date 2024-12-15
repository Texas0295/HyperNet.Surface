package dev.solsynth.solian.data

import java.time.Instant

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

data class SolarPostBody(
    val content: String?,
    val title: String?,
    val description: String?,
    val attachments: List<String>?
)

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