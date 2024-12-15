package dev.solsynth.solian.data

import java.time.Instant

data class SolarUser(
    val id: Int,
    val name: String,
    val nick: String
)

data class SolarCheckInRecord(
    val id: Int,
    val resultTier: Int,
    val resultExperience: Int,
    val createdAt: Instant
)