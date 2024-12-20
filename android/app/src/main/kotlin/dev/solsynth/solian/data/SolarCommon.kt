package dev.solsynth.solian.data

import androidx.annotation.Keep

@Keep
data class SolarPagination<T>(val count: Int, val data: List<T>)