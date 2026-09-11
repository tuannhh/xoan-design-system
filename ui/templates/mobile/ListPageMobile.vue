<script setup>
/**
 * ListPageMobile — mẫu danh sách native mini-app, minh họa bằng Kho phim.
 * Danh sách dùng row phẳng, search/filter 48px và bottom nav của app con.
 */
import { computed, ref } from 'vue'
import XButton from '../../components/XButton.vue'
import XCheckbox from '../../components/XCheckbox.vue'
import XIcon from '../../components/XIcon.vue'
import XInput from '../../components/XInput.vue'
import XTag from '../../components/XTag.vue'
import XToast from '../../components/XToast.vue'
import { useToast } from '../../components/toast.js'
import XMobileBottomNav from './XMobileBottomNav.vue'
import XMobileTopBar from './XMobileTopBar.vue'

const toast = useToast()
const activeNav = ref('library')
const search = ref('')
const selected = ref([])

const navItems = [
  { key: 'overview', label: 'Tổng quan', icon: 'home' },
  { key: 'library', label: 'Kho phim', icon: 'photo' },
  { key: 'upload', label: 'Tải lên', icon: 'upload', kind: 'fab' },
  { key: 'approval', label: 'Duyệt', icon: 'circle-check' },
  { key: 'more', label: 'Thêm', icon: 'menu-2' },
]

const films = ref([
  { id: 1, title: 'Khai mạc Xoăn Innovation 2026', folder: 'Sự kiện', duration: '04:32', quality: '4K', status: 'Đã xuất bản', updated: 'Hôm nay, 09:24' },
  { id: 2, title: 'Hướng dẫn sử dụng app Công việc', folder: 'Hướng dẫn', duration: '08:15', quality: 'Full HD', status: 'Chờ duyệt', updated: 'Hôm qua, 16:40' },
  { id: 3, title: 'Phỏng vấn khách hàng ngành bán lẻ', folder: 'Khách hàng', duration: '12:08', quality: 'Full HD', status: 'Bản nháp', updated: '05/08/2026' },
  { id: 4, title: 'Bản tin nội bộ tháng 8', folder: 'Truyền thông', duration: '06:20', quality: 'Full HD', status: 'Đã xuất bản', updated: '03/08/2026' },
  { id: 5, title: 'Tổng kết chiến dịch quảng bá thương hiệu', folder: 'Marketing', duration: '03:48', quality: '4K', status: 'Đang xử lý', updated: '01/08/2026' },
])

const filteredFilms = computed(() => {
  const query = search.value.trim().toLocaleLowerCase('vi')
  if (!query) return films.value
  return films.value.filter((film) => [film.title, film.folder, film.status]
    .some((value) => value.toLocaleLowerCase('vi').includes(query)))
})

const selectionMode = computed(() => selected.value.length > 0)

function statusColor(status) {
  if (status === 'Đã xuất bản') return 'success'
  if (status === 'Chờ duyệt' || status === 'Đang xử lý') return 'warning'
  return 'neutral'
}

function toggleSelect(id) {
  const index = selected.value.indexOf(id)
  if (index >= 0) selected.value.splice(index, 1)
  else selected.value.push(id)
}

function removeSelected() {
  films.value = films.value.filter((film) => !selected.value.includes(film.id))
  toast.success(`Đã xóa ${selected.value.length} phim`)
  selected.value = []
}

function openFilm(film) {
  if (selectionMode.value) return toggleSelect(film.id)
  toast.info(`Mở phim: ${film.title}`)
}
</script>

<template>
  <div class="xds-mobile-app relative flex h-full min-w-0 flex-col overflow-hidden bg-[var(--xds-bg)] text-[var(--xds-text)]">
    <XMobileTopBar title="Kho phim" show-more @back="toast.info('Đóng Kho phim')" @more="toast.info('Mở thao tác khác')">
      <template #actions>
        <XButton variant="icon" class="[&]:rounded-full" aria-label="Tải phim lên" @click="toast.info('Mở màn hình tải lên')">
          <template #icon><XIcon name="upload" :size="24" /></template>
        </XButton>
      </template>
    </XMobileTopBar>

    <section class="xds-mobile-gutter-x shrink-0 border-b border-[var(--xds-border-light)] bg-[var(--xds-bg)] pb-3 pt-3">
      <div class="xds-mobile-row-gap-2 flex min-w-0 items-center gap-2">
        <XInput v-model="search" class="min-w-0 flex-1" placeholder="Tìm tên phim, thư mục" clearable>
          <template #prefix><XIcon name="search" :size="20" /></template>
        </XInput>
        <XButton
          variant="icon"
          class="[&]:rounded-lg [&]:border [&]:border-[var(--xds-border)] [&]:bg-[var(--xds-bg)]"
          aria-label="Lọc danh sách"
          @click="toast.info('Mở bộ lọc dạng bottom sheet')"
        >
          <template #icon><XIcon name="filter" :size="20" /></template>
        </XButton>
      </div>
      <p class="mt-2 text-[12px] leading-4 text-[var(--xds-text-secondary)]">{{ filteredFilms.length }} phim · cập nhật gần nhất trước</p>
    </section>

    <main class="min-h-0 flex-1 overflow-y-auto bg-[var(--xds-bg)] pb-4">
      <article
        v-for="film in filteredFilms"
        :key="film.id"
        class="xds-mobile-gutter-x xds-mobile-row-gap-3 flex min-h-[92px] min-w-0 items-center gap-3 border-b border-[var(--xds-border-light)] py-3 active:bg-[var(--xds-bg-hover-soft)]"
        @click="openFilm(film)"
      >
        <div class="-ml-3 grid h-12 w-12 shrink-0 place-items-center" @click.stop="toggleSelect(film.id)">
          <XCheckbox :model-value="selected.includes(film.id)" :input-aria-label="`Chọn ${film.title}`" />
        </div>
        <div class="xds-mobile-list-thumbnail grid h-14 w-20 shrink-0 place-items-center rounded-lg bg-[var(--xds-bg-disabled)] text-[var(--xds-icon-neutral)]">
          <XIcon name="photo" :size="24" />
        </div>
        <div class="min-w-0 flex-1">
          <h2 class="truncate text-[14px] font-semibold leading-5">{{ film.title }}</h2>
          <p class="mt-0.5 truncate text-[12px] leading-4 text-[var(--xds-text-secondary)]">{{ film.folder }} · {{ film.duration }} · {{ film.quality }}</p>
          <div class="xds-mobile-row-gap-2 mt-0.5 flex min-w-0 items-center gap-2">
            <XTag :color="statusColor(film.status)" size="sm">{{ film.status }}</XTag>
            <span class="min-w-0 flex-1 truncate text-[12px] leading-4 text-[var(--xds-text-muted)]">{{ film.updated }}</span>
          </div>
        </div>
      </article>
    </main>

    <div
      v-if="selectionMode"
      class="xds-mobile-gutter-x xds-mobile-row-gap-2 flex shrink-0 items-center justify-between gap-2 border-t border-[var(--xds-border-light)] bg-[var(--xds-bg)] pt-2"
      :style="{ paddingBottom: 'max(8px, var(--xds-mobile-safe-bottom))' }"
    >
      <XButton variant="ghost" @click="selected = []">Bỏ chọn ({{ selected.length }})</XButton>
      <XButton variant="danger" @click="removeSelected">Xóa</XButton>
    </div>
    <XMobileBottomNav v-else :items="navItems" :active="activeNav" @select="(key) => (activeNav = key)" />
    <XToast />
  </div>
</template>
