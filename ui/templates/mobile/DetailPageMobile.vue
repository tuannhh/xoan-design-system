<script setup>
/**
 * DetailPageMobile — chi tiết phim trong native mini-app.
 * Top bar gọn, tab cuộn ngang và primary action ghim đáy.
 */
import { ref } from 'vue'
import XButton from '../../components/XButton.vue'
import XEmptyState from '../../components/XEmptyState.vue'
import XIcon from '../../components/XIcon.vue'
import XTag from '../../components/XTag.vue'
import XTabs from '../../components/XTabs.vue'
import XToast from '../../components/XToast.vue'
import { useToast } from '../../components/toast.js'
import XMobileTopBar from './XMobileTopBar.vue'

const toast = useToast()
const activeTab = ref('info')

const film = {
  title: 'Hướng dẫn sử dụng app Công việc',
  code: 'FILM-0248',
  status: 'Chờ duyệt',
  folder: 'Hướng dẫn',
  duration: '08:15',
  quality: 'Full HD',
  size: '428 MB',
  owner: 'Bùi Minh Tuấn',
  visibility: 'Toàn công ty',
  updated: '06/08/2026, 16:40',
  description: 'Video hướng dẫn các thao tác lập kế hoạch, giao việc và theo dõi tiến độ trên app Công việc.',
}

const fields = [
  { label: 'Mã phim', value: film.code },
  { label: 'Thư mục', value: film.folder },
  { label: 'Thời lượng', value: film.duration },
  { label: 'Chất lượng', value: film.quality },
  { label: 'Dung lượng', value: film.size },
  { label: 'Phạm vi xem', value: film.visibility },
  { label: 'Người phụ trách', value: film.owner },
  { label: 'Cập nhật', value: film.updated },
]

const tabs = [
  { key: 'info', label: 'Thông tin' },
  { key: 'versions', label: 'Phiên bản' },
  { key: 'history', label: 'Lịch sử' },
]

const versions = [
  { name: 'Bản 03', meta: 'Full HD · 428 MB', date: '06/08/2026' },
  { name: 'Bản 02', meta: 'Full HD · 416 MB', date: '05/08/2026' },
  { name: 'Bản 01', meta: 'HD · 236 MB', date: '04/08/2026' },
]
</script>

<template>
  <div class="xds-mobile-app flex h-full min-w-0 flex-col overflow-hidden bg-[var(--xds-bg)] text-[var(--xds-text)]">
    <XMobileTopBar :title="film.title" show-more @back="toast.info('Quay lại Kho phim')" @more="toast.info('Sửa · Nhân bản · Xóa')">
      <template #actions>
        <XButton variant="icon" class="[&]:rounded-full" aria-label="Chia sẻ phim" @click="toast.info('Mở chia sẻ')">
          <template #icon><XIcon name="share" :size="24" /></template>
        </XButton>
      </template>
    </XMobileTopBar>

    <div class="xds-mobile-gutter-x shrink-0 border-b border-[var(--xds-border-light)] bg-[var(--xds-bg)] py-4">
      <div class="xds-mobile-row-gap-3 flex min-w-0 gap-3">
        <div class="xds-mobile-detail-summary-media grid h-[84px] w-[120px] shrink-0 place-items-center rounded-lg bg-[var(--xds-bg-disabled)] text-[var(--xds-icon-neutral)]">
          <XIcon name="photo" :size="32" />
        </div>
        <div class="min-w-0 flex-1">
          <h2 class="line-clamp-2 text-[16px] font-semibold leading-[22px]">{{ film.title }}</h2>
          <div class="mt-1"><XTag color="warning">{{ film.status }}</XTag></div>
          <XButton variant="link" class="mt-1 [&]:h-auto [&]:min-w-0 [&]:px-0" @click="toast.info('Mở trình xem phim')">Xem trước</XButton>
        </div>
      </div>
    </div>

    <XTabs
      v-model="activeTab"
      :tabs="tabs"
      class="flex min-h-0 flex-1 flex-col [&>[role=tablist]]:shrink-0 [&>[role=tablist]]:overflow-x-auto [&>[role=tablist]]:whitespace-nowrap [&>[role=tablist]]:px-4 [&>[role=tabpanel]]:min-h-0 [&>[role=tabpanel]]:flex-1 [&>[role=tabpanel]]:overflow-y-auto"
    >
      <div v-if="activeTab === 'info'" class="pb-4">
        <section class="xds-mobile-gutter-x border-b border-[var(--xds-border-light)] py-4">
          <h3 class="text-[14px] font-semibold leading-5">Mô tả</h3>
          <p class="mt-2 text-[14px] leading-5 text-[var(--xds-text-secondary)]">{{ film.description }}</p>
        </section>
        <dl class="xds-mobile-gutter-x">
          <div v-for="field in fields" :key="field.label" class="xds-mobile-metadata-row xds-mobile-row-gap-4 flex min-h-12 items-center gap-4 border-b border-[var(--xds-border-light)] py-2">
            <dt class="w-[112px] shrink-0 text-[13px] leading-[18px] text-[var(--xds-text-secondary)]">{{ field.label }}</dt>
            <dd class="xds-mobile-readable min-w-0 flex-1 text-right text-[13px] font-medium leading-[18px]">{{ field.value }}</dd>
          </div>
        </dl>
      </div>

      <div v-else-if="activeTab === 'versions'" class="xds-mobile-gutter-x pb-4">
        <button
          v-for="version in versions"
          :key="version.name"
          type="button"
          class="xds-mobile-row-gap-3 flex min-h-16 w-full min-w-0 items-center gap-3 border-b border-[var(--xds-border-light)] text-left"
          @click="toast.info(`Mở ${version.name}`)"
        >
          <span class="grid h-10 w-10 shrink-0 place-items-center rounded-lg bg-[var(--xds-brand-50)] text-[var(--xds-brand-600)]">
            <XIcon name="file" :size="20" />
          </span>
          <span class="min-w-0 flex-1">
            <span class="block truncate text-[14px] font-medium leading-5">{{ version.name }}</span>
            <span class="block truncate text-[12px] leading-4 text-[var(--xds-text-secondary)]">{{ version.meta }}</span>
          </span>
          <span class="shrink-0 text-[12px] text-[var(--xds-text-muted)]">{{ version.date }}</span>
        </button>
      </div>

      <XEmptyState v-else type="initial" title="Chưa có lịch sử" description="Các thay đổi của phim sẽ hiển thị tại đây" />
    </XTabs>

    <footer
      class="xds-mobile-gutter-x shrink-0 border-t border-[var(--xds-border-light)] bg-[var(--xds-bg)] pt-2"
      :style="{ paddingBottom: 'max(8px, var(--xds-mobile-safe-bottom))' }"
    >
      <XButton variant="primary" class="w-full" @click="toast.success('Đã gửi phim để duyệt')">Gửi duyệt</XButton>
    </footer>
    <XToast />
  </div>
</template>

<style scoped>
:deep([role='tablist']) {
  scrollbar-width: none;
}

:deep([role='tablist']::-webkit-scrollbar) {
  display: none;
}
</style>
