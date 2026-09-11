<script setup>
/**
 * XMobileTopBar — top bar của mini-app chạy trong một native host/super-app.
 * Host/OS sở hữu status bar, launcher và tiện ích hệ sinh thái; app con chỉ giữ
 * Back, tiêu đề màn hình và tối đa 2 action nghiệp vụ qua slot `actions`/More.
 */
import XButton from '../../components/XButton.vue'
import XIcon from '../../components/XIcon.vue'

defineProps({
  title: { type: String, required: true },
  showBack: { type: Boolean, default: true },
  showMore: { type: Boolean, default: false },
  backLabel: { type: String, default: 'Quay lại' },
})

const emit = defineEmits(['back', 'more'])
</script>

<template>
  <header
    class="shrink-0 border-b border-[var(--xds-border-light)] bg-[var(--xds-bg)]"
    :style="{ paddingTop: 'var(--xds-mobile-safe-top)' }"
  >
    <div class="xds-mobile-row-gap-1 flex h-[var(--xds-mobile-topbar-height)] min-w-0 items-center gap-1 px-2">
      <XButton
        v-if="showBack"
        variant="icon"
        class="[&]:rounded-full"
        :aria-label="backLabel"
        @click="emit('back')"
      >
        <template #icon><XIcon name="arrow-left" :size="24" /></template>
      </XButton>

      <slot name="leading" />

      <h1 class="min-w-0 flex-1 truncate px-1 text-[20px] font-semibold leading-7 text-[var(--xds-text)]">
        {{ title }}
      </h1>

      <div v-if="$slots.actions" class="xds-mobile-row-gap-1 flex min-w-0 shrink-0 items-center gap-1">
        <slot name="actions" />
      </div>

      <XButton
        v-if="showMore"
        variant="icon"
        class="[&]:rounded-full"
        aria-label="Thêm thao tác"
        @click="emit('more')"
      >
        <template #icon><XIcon name="dots" :size="24" /></template>
      </XButton>
    </div>
  </header>
</template>
