<script setup>
// XHeaderBar — Header Platform Xoăn: light hoặc brand theo reference sản phẩm.
// Cụm phải rút gọn theo quy chuẩn Xoăn: chỉ còn Thiết lập + Avatar người dùng
// (không app switcher 9 chấm, không trợ lý AI, không tin nhắn/thông báo/trợ giúp/khác).
import { computed, onBeforeUnmount, onMounted, ref } from 'vue'
import XIcon from './XIcon.vue'

const props = defineProps({
  variant: { type: String, default: 'brand', validator: (v) => ['light', 'brand'].includes(v) },
  appName: { type: String, default: '' },
  searchPlaceholder: { type: String, default: 'Tìm kiếm' },
  user: { type: Object, default: null },
  showSearch: { type: Boolean, default: true },
  showSettings: { type: Boolean, default: true },
})

const emit = defineEmits(['search', 'settings', 'user-click', 'logo-click'])
const searchInput = ref(null)
const searchText = ref('')

const isBrand = computed(() => props.variant === 'brand')
// 'xds-header--brand' là class hook để theme Gradient tô gradient lên header
// (xem assets/tokens/themes/gradient.css) — không xóa dù trông "thừa" so với Tailwind.
const headerClass = computed(() => isBrand.value
  ? 'xds-header--brand bg-[var(--xds-brand-600)] text-white'
  : 'border-b border-[var(--xds-border)] bg-[var(--xds-bg)] text-[var(--xds-text)]')
const buttonClass = computed(() => isBrand.value
  ? 'text-white hover:bg-white/15 focus-visible:outline-white'
  : 'text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)] focus-visible:outline-[var(--xds-brand-600)]')
const searchClass = computed(() => isBrand.value
  ? 'bg-white/20 text-white placeholder:text-white/70 focus:bg-white/[.28] focus:placeholder:text-white/80'
  : 'bg-[var(--xds-bg-disabled)] text-[var(--xds-text)] placeholder:text-[var(--xds-text-muted)] focus:bg-white focus:ring-1 focus:ring-[var(--xds-brand-600)]')
const searchIconClass = computed(() => isBrand.value
  ? 'text-white/70 peer-focus:text-white/90'
  : 'text-[var(--xds-icon-neutral)]')
const appInitial = computed(() => (props.appName || '').trim().charAt(0).toUpperCase())
const userInitials = computed(() => initials(props.user?.name))

function initials(name) {
  const words = (name || '').trim().split(/\s+/).filter(Boolean)
  if (!words.length) return ''
  return (words.length >= 2 ? words[0][0] + words[1][0] : words[0].slice(0, 2)).toUpperCase()
}
function onGlobalKeydown(event) {
  if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'k') {
    event.preventDefault()
    searchInput.value?.focus()
  }
}
function onSearchFocus(event) { event.target.select() }
function onSearchEnter() { emit('search', searchText.value) }

onMounted(() => window.addEventListener('keydown', onGlobalKeydown))
onBeforeUnmount(() => window.removeEventListener('keydown', onGlobalKeydown))
</script>

<template>
  <!-- h-12 = 48px, px-4 = padding ngang 16px — đúng redline quy chuẩn header-bar -->
  <header class="flex h-12 w-full items-center gap-2 px-4 text-[13px] leading-[18px]" :class="headerClass">
    <!-- Bên trái: Logo + tên app (KHÔNG có nút app switcher 9 chấm) -->
    <div class="flex shrink-0 items-center gap-3">
      <!-- Logo–tên app cách nhau 12px (gap-3); tên app 20px semibold theo redline header-bar -->
      <button type="button" :class="buttonClass" class="flex shrink-0 items-center gap-3 rounded-lg px-1 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2" :title="appName" @click="emit('logo-click')">
        <slot name="logo">
          <span class="flex h-8 w-8 items-center justify-center rounded-lg bg-[var(--xds-brand-600)] text-[16px] font-semibold text-white">{{ appInitial }}</span>
        </slot>
        <span class="hidden text-[20px] font-semibold leading-7 sm:block">{{ appName }}</span>
      </button>
    </div>

    <!-- Giữa: ô tìm kiếm (co giãn theo không gian còn lại) -->
    <div v-if="showSearch" class="flex min-w-0 flex-1 justify-center px-2">
      <div class="relative w-full max-w-[500px]">
        <input ref="searchInput" v-model="searchText" type="search" :placeholder="searchPlaceholder" class="peer h-8 w-full rounded-lg pl-9 pr-3 outline-none transition-colors" :class="searchClass" @focus="onSearchFocus" @keydown.enter="onSearchEnter" />
        <XIcon name="search" :size="16" class="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2" :class="searchIconClass" />
      </div>
    </div>
    <div v-else class="min-w-0 flex-1"></div>

    <!-- Phải: cụm tiện ích rút gọn — chỉ Thiết lập + Avatar người dùng.
         gap-2 = 8px (khoảng cách giữa các icon button), avatar cách mép phải 16px (px-4 của header).
         Slot "actions" dành cho nút riêng của app, đặt TRƯỚC cụm chuẩn. -->
    <div class="flex shrink-0 items-center gap-2">
      <slot name="actions" />
      <!-- Thiết lập: mở dialog cá nhân hóa (theme màu / mật độ hiển thị / hình nền) — XSettingsDialog -->
      <button v-if="showSettings" type="button" :class="buttonClass" class="grid h-8 w-8 place-items-center rounded-lg focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2" title="Thiết lập" aria-label="Thiết lập" @click="emit('settings')"><XIcon name="settings" :size="20" /></button>
      <!-- Slot "user" cho phép app thay hẳn nút avatar mặc định bằng identity phức tạp hơn
           (vd dropdown menu kèm tên/vai trò) mà vẫn giữ đúng vị trí NGOÀI CÙNG BÊN PHẢI. -->
      <slot name="user">
        <button v-if="user" type="button" class="h-8 w-8 shrink-0 overflow-hidden rounded-full bg-[var(--xds-brand-100)] text-[12px] font-semibold text-[var(--xds-brand-700)] focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--xds-brand-600)]" :title="user.name" :aria-label="user.name" @click="emit('user-click')"><img v-if="user.avatarUrl" :src="user.avatarUrl" :alt="user.name" class="h-full w-full object-cover" /><span v-else aria-hidden="true" class="flex h-full w-full items-center justify-center">{{ userInitials }}</span></button>
      </slot>
    </div>
  </header>
</template>
