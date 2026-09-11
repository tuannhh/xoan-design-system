<script setup>
import { computed } from 'vue'
import XSpinner from './XSpinner.vue'

// XButton — nút chuẩn XDS.
// 'secondary' giữ nguyên để tương thích ngược với code cũ; 'outline'/'neutral'/'ghost'
// /'success'/'warning'/'ai' là biến thể bổ sung theo bộ demo chuẩn của giám đốc thiết kế.
const props = defineProps({
  variant: {
    type: String,
    default: 'secondary',
    validator: (v) => [
      'primary', 'secondary', 'outline', 'neutral', 'ghost',
      'success', 'warning', 'danger', 'ai', 'link', 'icon',
    ].includes(v),
  },
  size: {
    type: String,
    default: 'md', // 'md' theo --xds-btn-height (density) | 'lg' +8px
    validator: (v) => ['md', 'lg'].includes(v),
  },
  loading: { type: Boolean, default: false },
  disabled: { type: Boolean, default: false },
})

// Loading tự disable nút — chặn double-submit theo XDS
const isDisabled = computed(() => props.disabled || props.loading)

// Kích thước: cao theo token --xds-btn-height (đổi theo mật độ hiển thị); min-width 80px
// (trừ icon button: hình vuông). 'lg' cộng thêm 8px so với mật độ hiện tại.
const sizeClasses = computed(() => {
  if (props.variant === 'icon') {
    return props.size === 'lg'
      ? 'h-[calc(var(--xds-btn-height)+8px)] w-[calc(var(--xds-btn-height)+8px)]'
      : 'h-[var(--xds-btn-height)] w-[var(--xds-btn-height)]'
  }
  return props.size === 'lg'
    ? 'h-[calc(var(--xds-btn-height)+8px)] min-w-[88px] px-4'
    : 'h-[var(--xds-btn-height)] min-w-[80px] px-[14px]'
})

// Màu theo variant; disabled dùng màu thật (không dùng opacity) theo quy ước XDS
const variantClasses = computed(() => {
  if (isDisabled.value) {
    // Link/icon/ghost disabled: chỉ đổi màu chữ, không đổ nền
    if (['link', 'icon', 'ghost'].includes(props.variant)) {
      return 'text-[var(--xds-text-placeholder)] cursor-not-allowed'
    }
    return 'bg-[var(--xds-bg-disabled)] text-[var(--xds-text-placeholder)] cursor-not-allowed'
  }
  switch (props.variant) {
    case 'primary':
      // Nền brand-600, hover 700, pressed 800, chữ trắng
      return 'bg-[var(--xds-brand-600)] text-white hover:bg-[var(--xds-brand-700)] active:bg-[var(--xds-brand-800)]'
    case 'outline':
      // Viền brand, nền trắng — dùng khi nút phụ cần nổi bật hơn neutral
      return 'bg-[var(--xds-bg)] text-[var(--xds-brand-600)] border border-[var(--xds-brand-600)] hover:bg-[var(--xds-bg-brand-brand-light)] active:bg-[var(--xds-brand-100)]'
    case 'neutral':
      // Viền xám trung tính — nút phụ mặc định (thay 'secondary' trong bộ demo mới)
      return 'bg-[var(--xds-bg)] text-[var(--xds-text)] border border-[var(--xds-border)] hover:bg-[var(--xds-bg-hover-soft)] active:bg-[var(--xds-brand-100)]'
    case 'ghost':
      // Không nền không viền — icon/hành động phụ rất nhẹ
      return 'bg-transparent text-[var(--xds-text-secondary)] hover:bg-[var(--xds-bg-hover-soft)] active:bg-[var(--xds-brand-100)]'
    case 'success':
      return 'bg-[var(--xds-success)] text-white hover:brightness-95 active:brightness-90'
    case 'warning':
      return 'bg-[var(--xds-warning)] text-white hover:brightness-95 active:brightness-90'
    case 'danger':
      // Không có thang shade cho danger — hover/pressed làm tối bằng brightness
      return 'bg-[var(--xds-danger)] text-white hover:brightness-95 active:brightness-90'
    case 'ai':
      // Gradient riêng cho hành động gọi AI — không dùng cho nút Primary thường
      return 'text-white bg-[linear-gradient(110deg,#1482FF_0%,#CF11FF_100%)] hover:brightness-90 active:brightness-80'
    case 'link':
      return 'text-[var(--xds-brand-600)] hover:underline active:text-[var(--xds-brand-800)]'
    case 'icon':
      return 'text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)] active:bg-[var(--xds-brand-100)]'
    default: // secondary — alias tương thích ngược, hành vi giống 'neutral'
      return 'bg-[var(--xds-bg)] text-[var(--xds-text)] border border-[var(--xds-border)] hover:bg-[var(--xds-bg-hover-soft)] active:bg-[var(--xds-brand-100)]'
  }
})
</script>

<template>
  <button
    type="button"
    :disabled="isDisabled"
    :aria-busy="loading || undefined"
    class="xds-button inline-flex max-w-full shrink-0 select-none items-center justify-center gap-1.5 whitespace-nowrap rounded-lg text-[13px] font-medium leading-[18px] transition-colors focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--xds-brand-600)]"
    :class="[sizeClasses, variantClasses]"
  >
    <!-- Loading: spinner 16px thay chỗ icon, chữ giữ nguyên -->
    <XSpinner v-if="loading" :size="16" />
    <!-- Slot icon 16px trước chữ -->
    <span
      v-else-if="$slots.icon"
      class="inline-flex shrink-0 [&>svg]:h-4 [&>svg]:w-4"
      aria-hidden="true"
    >
      <slot name="icon" />
    </span>
    <span class="min-w-0 truncate"><slot /></span>
  </button>
</template>
