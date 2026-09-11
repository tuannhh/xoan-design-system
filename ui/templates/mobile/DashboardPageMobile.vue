<script setup>
/**
 * DashboardPageMobile — tổng quan native mini-app Kho phim.
 * KPI 2 cột, chart đọc được không cần hover và danh sách xử lý dạng row phẳng.
 */
import { computed, ref } from 'vue'
import XButton from '../../components/XButton.vue'
import XChart from '../../components/XChart.vue'
import XIcon from '../../components/XIcon.vue'
import XTag from '../../components/XTag.vue'
import XToast from '../../components/XToast.vue'
import { useToast } from '../../components/toast.js'
import XMobileBottomNav from './XMobileBottomNav.vue'
import XMobileTopBar from './XMobileTopBar.vue'

const toast = useToast()
const activeNav = ref('overview')
const chartWidth = ref(390)

const navItems = [
  { key: 'overview', label: 'Tổng quan', icon: 'home' },
  { key: 'library', label: 'Kho phim', icon: 'photo' },
  { key: 'upload', label: 'Tải lên', icon: 'upload', kind: 'fab' },
  { key: 'approval', label: 'Duyệt', icon: 'circle-check' },
  { key: 'more', label: 'Thêm', icon: 'menu-2' },
]

const kpis = [
  { label: 'Tổng phim', value: '1.248', note: '+32 tháng này', color: 'brand' },
  { label: 'Chờ duyệt', value: '18', note: '6 sắp quá hạn', color: 'warning' },
  { label: 'Đã xuất bản', value: '986', note: '79% kho phim', color: 'success' },
  { label: 'Dung lượng', value: '2,4 TB', note: 'Còn 680 GB', color: 'info' },
]

const pendingFilms = [
  { title: 'Hướng dẫn sử dụng app Công việc', owner: 'Bùi Minh Tuấn', due: 'Hôm nay', status: 'Chờ duyệt' },
  { title: 'Phỏng vấn khách hàng ngành bán lẻ', owner: 'Nguyễn Thu Hà', due: 'Ngày mai', status: 'Cần bổ sung' },
  { title: 'Bản tin nội bộ tháng 8', owner: 'Trần Đức Anh', due: '10/08', status: 'Chờ duyệt' },
]

function cssVar(name) {
  if (typeof window === 'undefined') return ''
  return getComputedStyle(document.documentElement).getPropertyValue(name).trim()
}

const chartOption = computed(() => ({
  legend: { show: false },
  grid: { left: 4, right: 4, top: 20, bottom: 0, containLabel: true },
  tooltip: { trigger: 'axis', axisPointer: { type: 'shadow' } },
  xAxis: {
    type: 'category',
    data: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8'],
    axisTick: { show: false },
    axisLine: { lineStyle: { color: cssVar('--xds-border-light') } },
    axisLabel: {
      color: cssVar('--xds-text-secondary'),
      fontSize: chartWidth.value < 340 ? 10 : 11,
      fontFamily: 'Inter',
      hideOverlap: true,
      interval: 0,
    },
  },
  yAxis: {
    type: 'value',
    axisLabel: { color: cssVar('--xds-text-secondary'), fontSize: chartWidth.value < 340 ? 10 : 11, fontFamily: 'Inter', hideOverlap: true },
    splitLine: { lineStyle: { color: cssVar('--xds-border-light'), type: 'dashed' } },
  },
  series: [{
    name: 'Phim tải lên',
    type: 'bar',
    data: [82, 108, 94, 126, 138, 118, 164],
    barMaxWidth: chartWidth.value < 340 ? 18 : 24,
    itemStyle: { color: cssVar('--xds-brand-600'), borderRadius: [4, 4, 0, 0] },
    label: { show: chartWidth.value >= 340, position: 'top', color: cssVar('--xds-text-secondary'), fontSize: 10 },
  }],
}))

function updateChartSize(size) {
  chartWidth.value = size.width
}
</script>

<template>
  <div class="xds-mobile-app flex h-full min-w-0 flex-col overflow-hidden bg-[var(--xds-bg-page)] text-[var(--xds-text)]">
    <XMobileTopBar title="Kho phim" show-more @back="toast.info('Đóng Kho phim')" @more="toast.info('Mở thao tác khác')">
      <template #actions>
        <XButton variant="icon" class="[&]:rounded-full" aria-label="Tìm kiếm" @click="toast.info('Mở tìm kiếm toàn màn hình')">
          <template #icon><XIcon name="search" :size="24" /></template>
        </XButton>
      </template>
    </XMobileTopBar>

    <main class="min-h-0 flex-1 overflow-y-auto pb-5">
      <section class="xds-mobile-gutter-x pb-4 pt-5">
        <div class="xds-mobile-row-gap-3 flex min-w-0 items-center justify-between gap-3">
          <div class="min-w-0">
            <h2 class="truncate text-[20px] font-semibold leading-7">Tổng quan</h2>
            <p class="mt-0.5 truncate text-[13px] leading-[18px] text-[var(--xds-text-secondary)]">Cập nhật lúc 15:37 hôm nay</p>
          </div>
          <XButton variant="neutral" @click="toast.info('Chọn khoảng thời gian')">30 ngày</XButton>
        </div>

        <div class="xds-mobile-kpi-grid mt-4 grid grid-cols-2 gap-3">
          <article v-for="kpi in kpis" :key="kpi.label" class="xds-card min-w-0 p-3">
            <p class="truncate text-[12px] leading-4 text-[var(--xds-text-secondary)]">{{ kpi.label }}</p>
            <p class="mt-1 truncate text-[22px] font-semibold leading-7">{{ kpi.value }}</p>
            <XTag :color="kpi.color" size="sm" class="mt-1 max-w-full">{{ kpi.note }}</XTag>
          </article>
        </div>
      </section>

      <section class="xds-mobile-gutter-x border-y border-[var(--xds-border-light)] bg-[var(--xds-bg)] py-4">
        <div class="xds-mobile-row-gap-3 flex min-w-0 items-center justify-between gap-3">
          <h3 class="min-w-0 truncate text-[16px] font-semibold leading-[22px]">Phim tải lên</h3>
          <span class="shrink-0 text-[12px] text-[var(--xds-text-secondary)]">7 tháng gần nhất</span>
        </div>
        <XChart :option="chartOption" :height="190" aria-label="Số phim tải lên trong 7 tháng gần nhất" @resize="updateChartSize" />
      </section>

      <section class="mt-3 bg-[var(--xds-bg)]">
        <div class="xds-mobile-gutter-x xds-mobile-row-gap-3 flex h-12 items-center justify-between gap-3 border-b border-[var(--xds-border-light)]">
          <h3 class="text-[16px] font-semibold leading-[22px]">Cần xử lý</h3>
          <XButton variant="link" class="[&]:h-auto [&]:min-w-0 [&]:px-0" @click="toast.info('Mở danh sách duyệt')">Xem tất cả</XButton>
        </div>
        <button
          v-for="film in pendingFilms"
          :key="film.title"
          type="button"
          class="xds-mobile-gutter-x xds-mobile-row-gap-3 flex min-h-[76px] w-full min-w-0 items-center gap-3 border-b border-[var(--xds-border-light)] py-2 text-left active:bg-[var(--xds-bg-hover-soft)]"
          @click="toast.info(`Mở ${film.title}`)"
        >
          <span class="grid h-10 w-10 shrink-0 place-items-center rounded-lg bg-[var(--xds-bg-disabled)] text-[var(--xds-icon-neutral)]">
            <XIcon name="photo" :size="20" />
          </span>
          <span class="min-w-0 flex-1">
            <span class="block truncate text-[14px] font-medium leading-5">{{ film.title }}</span>
            <span class="xds-mobile-row-gap-2 mt-1 flex min-w-0 items-center gap-2">
              <span class="min-w-0 flex-1 truncate text-[12px] leading-4 text-[var(--xds-text-secondary)]">{{ film.owner }} · {{ film.due }}</span>
              <XTag :color="film.status === 'Chờ duyệt' ? 'warning' : 'danger'" size="sm">{{ film.status }}</XTag>
            </span>
          </span>
        </button>
      </section>
    </main>

    <XMobileBottomNav :items="navItems" :active="activeNav" @select="(key) => (activeNav = key)" />
    <XToast />
  </div>
</template>
