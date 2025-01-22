package com.example.whisper_flutter_new

import android.content.Context
import android.content.pm.PackageManager

class VulkanHelper {
    companion object {
        fun isVulkanSupported(context: Context): Boolean {
            return context.packageManager
                .hasSystemFeature(PackageManager.FEATURE_VULKAN_HARDWARE_LEVEL)
        }

        fun getVulkanVersion(context: Context): Int {
            return if (isVulkanSupported(context)) {
                context.packageManager
                    .getSystemAvailableFeatures()
                    .find { it.name == PackageManager.FEATURE_VULKAN_HARDWARE_VERSION }
                    ?.version ?: 0
            } else 0
        }
    }
} 