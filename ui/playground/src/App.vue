<script setup>
import { ref, computed, onMounted } from 'vue'
import ControlsPage from './ControlsPage.vue'
import ListPage from '@tpl/ListPage.vue'
import FormPage from '@tpl/FormPage.vue'
import DetailPage from '@tpl/DetailPage.vue'
import DashboardPage from '@tpl/DashboardPage.vue'
import DocumentFormPage from '@tpl/DocumentFormPage.vue'
import ListPageMobile from '@tpl/mobile/ListPageMobile.vue'
import FormPageMobile from '@tpl/mobile/FormPageMobile.vue'
import DetailPageMobile from '@tpl/mobile/DetailPageMobile.vue'
import DashboardPageMobile from '@tpl/mobile/DashboardPageMobile.vue'
import PhoneFrame from './PhoneFrame.vue'

// Điều hướng bằng hash để share link trực tiếp từng trang mẫu
// Mobile hiển thị trong viewport native host; app con không render system bar/launcher của native host.
const views = [
  { key: 'controls', label: 'Bộ control', component: ControlsPage },
  { key: 'list', label: 'Mẫu: Danh sách', component: ListPage },
  { key: 'form', label: 'Mẫu: Thêm/Sửa', component: FormPage },
  { key: 'detail', label: 'Mẫu: Chi tiết', component: DetailPage },
  { key: 'dashboard', label: 'Mẫu: Tổng quan', component: DashboardPage },
  { key: 'doc-form', label: 'Mẫu: Chứng từ', component: DocumentFormPage },
  { key: 'm-dashboard', label: 'App: Tổng quan', component: DashboardPageMobile, frame: true, defaultDevice: 'phone' },
  { key: 'm-list', label: 'App: Kho phim', component: ListPageMobile, frame: true, defaultDevice: 'phone' },
  { key: 'm-form', label: 'App: Thêm phim', component: FormPageMobile, frame: true, defaultDevice: 'phone' },
  { key: 'm-detail', label: 'App: Chi tiết', component: DetailPageMobile, frame: true, defaultDevice: 'phone' },
  { key: 'm-tablet', label: 'Tablet: Tổng quan', component: DashboardPageMobile, frame: true, defaultDevice: 'tablet' },
]
const deviceOptions = [
  { key: 'compact', label: '320 · SE' },
  { key: 'legacy', label: '360 · Android cũ' },
  { key: 'phone', label: '390 · iPhone' },
  { key: 'modern', label: '430 · Máy lớn' },
  { key: 'tablet', label: '768 · Tablet' },
]
const active = ref('controls')
const previewDevice = ref('phone')
const activeView = computed(() => views.find(v => v.key === active.value) ?? views[0])

function activate(key, syncHash = true) {
  const view = views.find(v => v.key === key)
  if (!view) return
  active.value = key
  if (view.defaultDevice) previewDevice.value = view.defaultDevice
  if (syncHash) location.hash = key
}

function go(key) {
  activate(key)
}
onMounted(() => {
  const h = location.hash.replace('#', '')
  if (views.some(v => v.key === h)) activate(h, false)
  window.addEventListener('hashchange', () => {
    const k = location.hash.replace('#', '')
    if (views.some(v => v.key === k)) activate(k, false)
  })
})
</script>

<template>
  <div class="flex h-screen flex-col">
    <!-- Thanh chọn trang của playground (không thuộc XDS — chỉ để duyệt) -->
    <nav class="sticky top-0 z-50 flex items-center gap-1 overflow-x-auto whitespace-nowrap border-b border-[var(--xds-border)] bg-white px-4 py-2 shadow-sm">
      <span class="mr-3 shrink-0 text-[13px] font-semibold">XDS UI</span>
      <button v-for="v in views" :key="v.key" @click="go(v.key)"
        class="shrink-0 cursor-pointer rounded-lg px-3 py-1.5 text-[13px] leading-[18px] transition-colors"
        :class="active === v.key
          ? 'bg-[var(--xds-brand-600)] font-medium text-white'
          : 'text-[var(--xds-text)] hover:bg-[var(--xds-bg-disabled)]'">
        {{ v.label }}
      </button>
      <span class="ml-auto shrink-0 text-[12px] text-[var(--xds-text-placeholder)]">31 control + 5 desktop + 4 native mobile · XDS</span>
    </nav>
    <div class="min-h-0 flex-1" :class="active === 'controls' ? 'overflow-auto' : 'overflow-hidden'">
      <div v-if="activeView.frame" class="flex h-full flex-col items-center overflow-auto bg-[var(--xds-bg-disabled)] px-2 py-4">
        <div class="sticky top-0 z-40 mb-4 flex max-w-full shrink-0 items-center gap-1 overflow-x-auto whitespace-nowrap rounded-lg border border-[var(--xds-border)] bg-white p-1 shadow-sm" aria-label="Kích thước thiết bị preview">
          <button
            v-for="device in deviceOptions"
            :key="device.key"
            type="button"
            class="shrink-0 rounded-md px-2.5 py-1.5 text-[12px] font-medium"
            :class="previewDevice === device.key
              ? 'bg-[var(--xds-brand-600)] text-white'
              : 'text-[var(--xds-text-secondary)] hover:bg-[var(--xds-bg-disabled)]'"
            @click="previewDevice = device.key"
          >
            {{ device.label }}
          </button>
        </div>
        <PhoneFrame :device="previewDevice">
          <component :is="activeView.component" :key="`${activeView.key}-${previewDevice}`" />
        </PhoneFrame>
      </div>
      <component :is="activeView.component" v-else />
    </div>
  </div>
</template>
