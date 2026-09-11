<script setup>
/**
 * XMobileBottomNav — điều hướng cấp một của APP CON, không phải bottom nav của
 * native host/super-app. Chỉ dùng 3–5 mục; `kind: 'fab'` dành cho đúng một thao
 * tác tạo/tải lên thường xuyên ở giữa thanh.
 */
import XIcon from '../../components/XIcon.vue'

defineProps({
  items: {
    type: Array,
    required: true,
    validator: (items) => items.length >= 3 && items.length <= 5,
  }, // [{ key, label, icon, kind?: 'fab', ariaLabel? }]
  active: { type: String, required: true },
})

const emit = defineEmits(['select'])
</script>

<template>
  <nav
    aria-label="Điều hướng ứng dụng"
    class="grid shrink-0 border-t border-[var(--xds-border-light)] bg-[var(--xds-bg)]"
    :style="{
      gridTemplateColumns: `repeat(${items.length}, minmax(0, 1fr))`,
      minHeight: 'calc(var(--xds-mobile-bottom-nav-height) + var(--xds-mobile-safe-bottom))',
      paddingBottom: 'var(--xds-mobile-safe-bottom)',
    }"
  >
    <button
      v-for="item in items"
      :key="item.key"
      type="button"
      class="xds-mobile-nav-item xds-mobile-column-gap-1 flex min-w-0 flex-col items-center justify-center gap-1 overflow-visible px-1 py-1 text-center active:bg-[var(--xds-bg-hover-soft)]"
      :class="active === item.key ? 'font-medium text-[var(--xds-brand-600)]' : 'text-[var(--xds-text-secondary)]'"
      :aria-label="item.ariaLabel || item.label"
      :aria-current="active === item.key ? 'page' : undefined"
      :title="item.label"
      @click="emit('select', item.key)"
    >
      <span
        v-if="item.kind === 'fab'"
        class="-mt-5 grid h-12 w-12 shrink-0 place-items-center rounded-full bg-[var(--xds-brand-600)] text-white shadow-[var(--xds-shadow-md)]"
      >
        <XIcon :name="item.icon" :size="24" />
      </span>
      <XIcon v-else :name="item.icon" :size="24" />
      <span class="block w-full truncate whitespace-nowrap text-[11px] leading-[14px]">
        {{ item.label }}
      </span>
    </button>
  </nav>
</template>
