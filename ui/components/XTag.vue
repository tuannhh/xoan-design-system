<script setup>
import { computed } from 'vue'
import XIcon from './XIcon.vue'

// XTag — nhãn (tag) kiểu soft chuẩn XDS: nền nhạt + chữ đậm cùng tông
const props = defineProps({
  color: {
    type: String,
    default: 'neutral',
    validator: (v) => ['brand', 'success', 'warning', 'danger', 'neutral', 'info'].includes(v),
  },
  size: {
    type: String,
    default: 'md', // 'sm' 20px | 'md' 24px
    validator: (v) => ['sm', 'md'].includes(v),
  },
  closable: { type: Boolean, default: false },
})

const emit = defineEmits(['close'])

// Nền nhạt tạo từ chính token màu (color-mix 12% trên nền trong suốt) — không hard-code hex
const colorClasses = computed(() => {
  switch (props.color) {
    case 'brand':
      return 'bg-[var(--xds-brand-100)] text-[var(--xds-brand-700)]'
    case 'success':
      return 'bg-[var(--xds-success-soft)] text-[var(--xds-success)]'
    case 'warning':
      return 'bg-[var(--xds-warning-soft)] text-[var(--xds-warning)]'
    case 'danger':
      return 'bg-[var(--xds-danger-soft)] text-[var(--xds-danger)]'
    case 'info':
      return 'bg-[var(--xds-info-soft)] text-[var(--xds-info)]'
    default: // neutral
      return 'bg-[var(--xds-bg-disabled)] text-[var(--xds-text)]'
  }
})

const sizeClasses = computed(() => (props.size === 'sm' ? 'h-5' : 'h-6'))
</script>

<template>
  <span
    class="xds-tag inline-flex max-w-full min-w-0 select-none items-center gap-1 whitespace-nowrap rounded px-2 text-[12px] font-medium leading-none"
    :class="[colorClasses, sizeClasses]"
  >
    <span class="min-w-0 truncate"><slot /></span>
    <!-- Nút đóng: icon x.svg 12px, emit 'close' để cha tự xóa tag -->
    <button
      v-if="closable"
      type="button"
      class="-mr-1 inline-flex shrink-0 items-center justify-center rounded hover:bg-[color-mix(in_srgb,currentColor_15%,transparent)] focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--xds-brand-600)]"
      aria-label="Đóng"
      @click="emit('close')"
    >
      <XIcon name="x" :size="12" />
    </button>
  </span>
</template>
