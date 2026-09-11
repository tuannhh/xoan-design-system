<script setup>
/**
 * XSettingsDialog — dialog "Thiết lập màu sắc và hiển thị" mở từ nút Thiết lập
 * (gear) trên XHeaderBar. 3 tab: Thiết lập màu sắc (theme 11 lựa chọn + chế độ
 * header Màu sắc/Sáng), Thiết lập hiển thị (mật độ 3 mức) và Hình nền
 * (wallpaper — bật wallpaper tự kéo theo hiệu ứng kính, không có toggle riêng).
 * Thay đổi chỉ áp dụng khi bấm Lưu (draft state), khớp
 * references/patterns/header-bar.md mục 3b/3.
 */
import { computed, ref, watch } from 'vue'
import XDialog from './XDialog.vue'
import XIcon from './XIcon.vue'
import {
  THEME_LIST, currentTheme, applyTheme,
  currentHeaderMode, applyHeaderMode,
  DENSITY_LIST, currentDensity, applyDensity,
  WALLPAPER_LIST, currentWallpaper, applyWallpaper,
} from './theme-state.js'

const props = defineProps({
  modelValue: { type: Boolean, default: false },
})
const emit = defineEmits(['update:modelValue'])

const activeTab = ref('color')
const tabs = [
  { id: 'color', label: 'Thiết lập màu sắc' },
  { id: 'display', label: 'Thiết lập hiển thị' },
  { id: 'wallpaper', label: 'Hình nền' },
]

const draftTheme = ref(currentTheme.value)
const draftMode = ref(currentHeaderMode.value)
const draftDensity = ref(currentDensity.value)
const draftWallpaper = ref(currentWallpaper.value)

// Mở dialog: nạp lại draft từ giá trị đang áp dụng (hủy không mất thay đổi cũ)
watch(
  () => props.modelValue,
  (open) => {
    if (open) {
      draftTheme.value = currentTheme.value
      draftMode.value = currentHeaderMode.value
      draftDensity.value = currentDensity.value
      draftWallpaper.value = currentWallpaper.value
      activeTab.value = 'color'
    }
  }
)

const previewTheme = computed(() => THEME_LIST.find((t) => t.id === draftTheme.value) || THEME_LIST[0])

function close() {
  emit('update:modelValue', false)
}
function onCancel() {
  close()
}
function onSave() {
  applyTheme(draftTheme.value)
  applyHeaderMode(draftMode.value)
  applyDensity(draftDensity.value)
  applyWallpaper(draftWallpaper.value)
  close()
}
</script>

<template>
  <XDialog
    :model-value="modelValue"
    title="Thiết lập màu sắc và hiển thị"
    :width="640"
    type="confirm"
    confirm-text="Lưu"
    cancel-text="Hủy"
    @update:model-value="(v) => !v && close()"
    @cancel="onCancel"
    @confirm="onSave"
  >
    <!-- Tabs -->
    <div class="mb-4 flex items-end gap-1 border-b border-[var(--xds-border-light,var(--xds-border))]">
      <button
        v-for="tab in tabs"
        :key="tab.id"
        type="button"
        class="h-11 border-b-2 px-4 text-[13px] font-medium leading-[18px] transition-colors"
        :class="
          activeTab === tab.id
            ? 'border-[var(--xds-brand-600)] font-semibold text-[var(--xds-brand-600)]'
            : 'border-transparent text-[var(--xds-text-secondary)] hover:text-[var(--xds-text)]'
        "
        @click="activeTab = tab.id"
      >
        {{ tab.label }}
      </button>
    </div>

    <!-- ── Tab: Thiết lập màu sắc ── -->
    <div v-if="activeTab === 'color'" class="flex flex-col gap-5 pb-2">
      <div class="flex items-center justify-center gap-6">
        <span class="text-[13px] font-medium text-[var(--xds-text)]">Giao diện</span>
        <label
          v-for="m in [{ value: 'brand', label: 'Màu sắc' }, { value: 'light', label: 'Sáng' }]"
          :key="m.value"
          class="flex cursor-pointer items-center gap-2 text-[13px] text-[var(--xds-text)]"
        >
          <input v-model="draftMode" type="radio" :value="m.value" class="sr-only" />
          <span
            class="flex h-4 w-4 shrink-0 items-center justify-center rounded-full border-2 transition-colors"
            :class="draftMode === m.value ? 'border-[var(--xds-brand-600)] bg-[var(--xds-brand-600)] shadow-[inset_0_0_0_3px_white]' : 'border-[var(--xds-border)] bg-[var(--xds-bg)]'"
          />
          {{ m.label }}
        </label>
      </div>

      <div class="flex flex-wrap justify-center gap-2.5">
        <button
          v-for="c in THEME_LIST"
          :key="c.id"
          type="button"
          class="flex min-w-[80px] flex-col items-center gap-1.5 rounded-lg border-2 p-1.5 transition-colors"
          :class="draftTheme === c.id ? '' : 'border-transparent hover:bg-[var(--xds-bg-hover-soft)]'"
          :style="draftTheme === c.id ? { borderColor: c.main } : {}"
          @click="draftTheme = c.id"
        >
          <span
            class="relative flex h-10 w-[72px] overflow-hidden rounded-md border border-[var(--xds-border-light,var(--xds-border))]"
            :style="{ background: c.gradient || c.main }"
          >
            <XIcon
              v-if="draftTheme === c.id"
              name="check"
              :size="12"
              class="absolute right-1 top-1 text-white drop-shadow"
            />
          </span>
          <span class="whitespace-nowrap text-[12px] font-medium text-[var(--xds-text)]">{{ c.label }}</span>
        </button>
      </div>
    </div>

    <!-- ── Tab: Hình nền ── -->
    <div v-else-if="activeTab === 'wallpaper'" class="flex flex-col gap-3 pb-2">
      <p class="text-center text-[12px] text-[var(--xds-text-secondary)]">
        Chọn hình nền cho ứng dụng — khi bật, các khối nội dung tự chuyển sang hiệu ứng kính (glass)
      </p>
      <div class="flex flex-wrap justify-center gap-3">
        <button
          v-for="w in WALLPAPER_LIST"
          :key="w.id"
          type="button"
          class="flex w-[120px] flex-col items-center gap-1.5 rounded-lg border-2 p-1.5 transition-colors"
          :class="draftWallpaper === w.id ? 'border-[var(--xds-brand-600)]' : 'border-transparent hover:bg-[var(--xds-bg-hover-soft)]'"
          @click="draftWallpaper = w.id"
        >
          <span
            class="relative flex h-16 w-full items-center justify-center overflow-hidden rounded-md border border-[var(--xds-border-light,var(--xds-border))]"
            :style="w.css ? { backgroundImage: w.css, backgroundSize: 'cover' } : { background: 'repeating-linear-gradient(45deg, var(--xds-bg-disabled), var(--xds-bg-disabled) 6px, var(--xds-bg) 6px, var(--xds-bg) 12px)' }"
          >
            <XIcon v-if="!w.css" name="circle-x" :size="20" class="text-[var(--xds-text-placeholder)]" />
            <XIcon
              v-if="draftWallpaper === w.id"
              name="check"
              :size="12"
              class="absolute right-1 top-1 text-white drop-shadow"
            />
          </span>
          <span class="whitespace-nowrap text-[12px] font-medium text-[var(--xds-text)]">{{ w.label }}</span>
        </button>
      </div>
    </div>

    <!-- ── Tab: Thiết lập hiển thị ── -->
    <div v-else-if="activeTab === 'display'" class="flex flex-wrap justify-center gap-4 pb-2">
      <button
        v-for="d in DENSITY_LIST"
        :key="d.id"
        type="button"
        class="flex min-w-[160px] flex-col items-center gap-3 rounded-lg border-2 p-4 text-center transition-colors"
        :class="draftDensity === d.id ? 'border-[var(--xds-brand-600)]' : 'border-[var(--xds-border-light,var(--xds-border))] hover:bg-[var(--xds-bg-hover-soft)]'"
        @click="draftDensity = d.id"
      >
        <!-- Preview 3 hàng đúng chiều cao thật của mức mật độ -->
        <div class="flex w-full flex-col overflow-hidden rounded border border-[var(--xds-border-light,var(--xds-border))] bg-[var(--xds-bg-page)]">
          <div
            v-for="i in 3"
            :key="i"
            class="flex items-center gap-1.5 border-b border-[var(--xds-border-light,var(--xds-border))] bg-[var(--xds-bg)] px-2 last:border-b-0"
            :style="{ height: d.height + 'px' }"
          >
            <span class="h-2 w-[60%] rounded-sm bg-[var(--xds-bg-disabled)]" />
            <span class="h-2 w-[30%] rounded-sm bg-[var(--xds-bg-disabled)]" />
          </div>
        </div>
        <div class="flex flex-col gap-0.5">
          <span class="text-[13px] font-semibold text-[var(--xds-text)]">{{ d.label }}</span>
          <span class="text-[11px] leading-tight text-[var(--xds-text-secondary)]">{{ d.description }}</span>
        </div>
      </button>
    </div>
  </XDialog>
</template>
