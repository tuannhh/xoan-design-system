<script setup>
/**
 * FormPageMobile — form full-screen của mini-app Kho phim.
 * Compact luôn một cột; control 48px; footer sticky và action một dòng.
 */
import { reactive, ref } from 'vue'
import XButton from '../../components/XButton.vue'
import XInput from '../../components/XInput.vue'
import XRadioGroup from '../../components/XRadioGroup.vue'
import XSelect from '../../components/XSelect.vue'
import XTextarea from '../../components/XTextarea.vue'
import XToast from '../../components/XToast.vue'
import { rules, useFormValidation } from '../../components/useFormValidation.js'
import { useToast } from '../../components/toast.js'
import XMobileTopBar from './XMobileTopBar.vue'

const toast = useToast()
const saving = ref(false)

const folderOptions = [
  { label: 'Sự kiện', value: 'su-kien' },
  { label: 'Hướng dẫn', value: 'huong-dan' },
  { label: 'Khách hàng', value: 'khach-hang' },
  { label: 'Marketing', value: 'marketing' },
  { label: 'Truyền thông nội bộ', value: 'noi-bo' },
]

const visibilityOptions = [
  { label: 'Nội bộ', value: 'internal' },
  { label: 'Toàn công ty', value: 'company' },
  { label: 'Công khai', value: 'public' },
]

const form = reactive({
  title: '',
  source: '',
  folder: null,
  owner: 'Bùi Minh Tuấn',
  visibility: 'internal',
  description: '',
})
const { errors, validate } = useFormValidation({
  source: [rules.required('Cần chọn tệp hoặc nhập đường dẫn phim')],
  title: [rules.required('Tên phim không được để trống')],
})

function goBack() {
  toast.info('Quay lại Kho phim')
}

function save() {
  if (!validate(form)) return
  saving.value = true
  toast.success(`Đã lưu ${form.title.trim()}`)
  saving.value = false
}
</script>

<template>
  <div class="xds-mobile-app flex h-full min-w-0 flex-col overflow-hidden bg-[var(--xds-bg)] text-[var(--xds-text)]">
    <XMobileTopBar title="Thêm phim" @back="goBack" />

    <main class="min-h-0 flex-1 overflow-y-auto pb-6">
      <section class="xds-mobile-gutter-x border-b border-[var(--xds-border-light)] py-5">
        <h2 class="text-[16px] font-semibold leading-[22px]">Tệp phim</h2>
        <p class="mt-1 text-[12px] leading-4 text-[var(--xds-text-secondary)]">Dùng tệp từ thiết bị hoặc đường dẫn đã được cấp quyền.</p>
        <div class="mt-4" data-field="source">
          <label class="mb-1 block text-[13px] font-medium leading-[18px]">
            Tệp hoặc đường dẫn <span class="text-[var(--xds-danger)]">*</span>
          </label>
          <XInput v-model="form.source" placeholder="Chọn tệp hoặc dán đường dẫn" :error="errors.source" />
        </div>
      </section>

      <section class="xds-mobile-gutter-x py-5">
        <h2 class="text-[16px] font-semibold leading-[22px]">Thông tin phim</h2>
        <div class="xds-mobile-column-gap-4 mt-4 flex flex-col gap-4">
          <div data-field="title">
            <label class="mb-1 block text-[13px] font-medium leading-[18px]">
              Tên phim <span class="text-[var(--xds-danger)]">*</span>
            </label>
            <XInput v-model="form.title" placeholder="Nhập tên phim" :error="errors.title" />
          </div>

          <div>
            <label class="mb-1 block text-[13px] font-medium leading-[18px]">Thư mục</label>
            <XSelect v-model="form.folder" :options="folderOptions" placeholder="Chọn thư mục" />
          </div>

          <div>
            <label class="mb-1 block text-[13px] font-medium leading-[18px]">Người phụ trách</label>
            <XInput v-model="form.owner" />
          </div>

          <fieldset>
            <legend class="mb-1 text-[13px] font-medium leading-[18px]">Phạm vi xem</legend>
            <XRadioGroup v-model="form.visibility" :options="visibilityOptions" direction="vertical" />
          </fieldset>

          <div>
            <label class="mb-1 block text-[13px] font-medium leading-[18px]">Mô tả</label>
            <XTextarea v-model="form.description" :rows="4" :maxlength="500" placeholder="Nhập nội dung ngắn gọn" />
          </div>
        </div>
      </section>
    </main>

    <footer
      class="xds-mobile-gutter-x xds-mobile-row-gap-2 flex shrink-0 items-center justify-between gap-2 border-t border-[var(--xds-border-light)] bg-[var(--xds-bg)] pt-2"
      :style="{ paddingBottom: 'max(8px, var(--xds-mobile-safe-bottom))' }"
    >
      <XButton variant="neutral" @click="goBack">Hủy</XButton>
      <XButton variant="primary" :loading="saving" @click="save">Lưu phim</XButton>
    </footer>
    <XToast />
  </div>
</template>
