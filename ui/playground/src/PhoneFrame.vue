<script setup>
/**
 * PhoneFrame — khung duyệt mini-app trong native host (chỉ dùng ở playground).
 * Dải system bar nằm NGOÀI slot để người triển khai không sao chép vào app con.
 */
import { computed } from 'vue'

const props = defineProps({
  time: { type: String, default: '9:41' },
  device: {
    type: String,
    default: 'phone',
    validator: (value) => ['compact', 'legacy', 'phone', 'modern', 'tablet'].includes(value),
  },
})

const profiles = {
  compact: { width: 340, height: 588, radius: 30, screenRadius: 22 }, // 320x568: iPhone SE/Android compact
  legacy: { width: 380, height: 660, radius: 34, screenRadius: 26 },   // 360x640: Android đời cũ
  phone: { width: 410, height: 864, radius: 36, screenRadius: 28 },    // 390x844: iPhone phổ biến
  modern: { width: 450, height: 952, radius: 38, screenRadius: 30 },   // 430x932: máy lớn đời mới
  tablet: { width: 788, height: 1044, radius: 28, screenRadius: 20 },  // 768x1024
}

const profile = computed(() => profiles[props.device])
const frameStyle = computed(() => ({
  width: `min(${profile.value.width}px, calc(100vw - 20px))`,
  height: `${profile.value.height}px`,
  borderRadius: `${profile.value.radius}px`,
  padding: '10px',
}))

const screenRadius = computed(() => `${profile.value.screenRadius}px`)
</script>

<template>
  <div class="relative shrink-0 bg-[#10141B] shadow-[0_16px_48px_rgba(0,0,0,0.24)]" :style="frameStyle">
    <div class="relative h-full w-full overflow-hidden bg-[var(--xds-bg)]" :style="{ borderRadius: screenRadius }">
      <!-- Native host/OS owns this area. It is intentionally outside the app slot. -->
      <div class="absolute inset-x-0 top-0 z-20 flex h-7 items-center justify-between bg-[var(--xds-bg)] px-5 text-[11px] font-medium text-[var(--xds-text-secondary)]">
        <span class="tabular-nums">{{ time }}</span>
        <span>5G&nbsp;&nbsp;80%</span>
      </div>

      <div class="absolute inset-x-0 bottom-6 top-7 overflow-hidden">
        <slot />
      </div>

      <!-- Gesture area belongs to OS/host, not the mini-app. -->
      <div class="absolute inset-x-0 bottom-0 z-20 grid h-6 place-items-center bg-[var(--xds-bg)]">
        <span class="h-1 w-24 rounded-full bg-[var(--xds-text-secondary)] opacity-60" />
      </div>
    </div>
  </div>
</template>
