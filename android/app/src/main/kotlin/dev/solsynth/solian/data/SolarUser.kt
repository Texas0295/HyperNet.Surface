package dev.solsynth.solian.data

import androidx.annotation.Keep
import java.time.Instant

@Keep
data class SolarUser(
    val id: Int,
    val name: String,
    val nick: String
)

@Keep
data class SolarCheckInRecord(
    val id: Int,
    val resultTier: Int,
    val resultExperience: Int,
    val createdAt: Instant
)