<script setup>
/**
 * FormPage — template màn hình Thêm/Sửa (dạng Page) chuẩn XDS
 * Header trắng đơn giản (back + tiêu đề), body form 2 cột trên card trắng
 * căn giữa nền xám; nút Lưu/Hủy GHIM (sticky) ở cuối trang — không trôi khi cuộn,
 * Primary ngoài cùng bên phải theo XDS.
 */
import { ref, reactive } from 'vue'
import XButton from '../components/XButton.vue'
import XInput from '../components/XInput.vue'
import XSelect from '../components/XSelect.vue'
import XDatePicker from '../components/XDatePicker.vue'
import XRadioGroup from '../components/XRadioGroup.vue'
import XTextarea from '../components/XTextarea.vue'
import XToast from '../components/XToast.vue'
import XIcon from '../components/XIcon.vue'
import { useToast } from '../components/toast.js'
import { useFormValidation, rules } from '../components/useFormValidation.js'

const toast = useToast()

/* ── Options ────────────────────────────────────────────────── */

const genderOptions = [
  { label: 'Nam', value: 'nam' },
  { label: 'Nữ', value: 'nu' },
  { label: 'Khác', value: 'khac' },
]

const departmentOptions = [
  { label: 'Kinh doanh', value: 'kinh-doanh' },
  { label: 'Kế toán', value: 'ke-toan' },
  { label: 'Nhân sự', value: 'nhan-su' },
  { label: 'Marketing', value: 'marketing' },
  { label: 'Phát triển sản phẩm', value: 'phat-trien-san-pham' },
  { label: 'Chăm sóc khách hàng', value: 'cskh' },
]

/* ── State form ─────────────────────────────────────────────── */

const form = reactive({
  name: '',
  code: 'NV-0011',
  gender: 'nam',
  birthday: null,
  department: null,
  title: '',
  email: '',
  phone: '',
  note: '',
})

const saving = ref(false)

// Validate dùng chung: bắt buộc focus vào ô lỗi đầu tiên khi bấm Lưu mà còn lỗi
// (KHÔNG disable nút — spec popup-form.md mục 4). Field cần focus được phải bọc
// bằng data-field="key" trong template (xem useFormValidation.js).
const { errors, validate, clearErrors } = useFormValidation({
  name: [rules.required('Họ tên không được để trống')],
  email: [rules.email()],
  phone: [rules.phoneVN()],
})

function resetForm() {
  form.name = ''
  form.gender = 'nam'
  form.birthday = null
  form.department = null
  form.title = ''
  form.email = ''
  form.phone = ''
  form.note = ''
  clearErrors()
  // Mã NV mock: tăng số cuối để mô phỏng sinh mã tự động
  form.code = `NV-${String(Number(form.code.slice(3)) + 1).padStart(4, '0')}`
}

function goBack() {
  toast.info('Quay lại danh sách nhân viên')
}

function cancel() {
  goBack()
}

function save() {
  if (!validate(form)) return
  saving.value = true
  toast.success(`Đã lưu nhân viên ${form.name.trim()}`)
  saving.value = false
  goBack()
}

// Lưu và Thêm mới: lưu xong reset form để nhập tiếp bản ghi mới
function saveAndNew() {
  if (!validate(form)) return
  saving.value = true
  toast.success(`Đã lưu nhân viên ${form.name.trim()}. Tiếp tục thêm mới.`)
  saving.value = false
  resetForm()
}
</script>

<template>
  <div
    class="flex h-full flex-col overflow-hidden bg-[var(--xds-bg-disabled)] text-[13px] leading-[18px] text-[var(--xds-text)]"
    :style="{ fontFamily: 'var(--xds-font-family)' }"
  >
    <!-- Header trắng đơn giản: back + tiêu đề trang -->
    <header
      class="flex h-14 shrink-0 items-center gap-2 border-b border-[var(--xds-border)] bg-[var(--xds-bg)] px-4"
    >
      <button
        type="button"
        class="flex h-8 w-8 items-center justify-center rounded-lg text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)] focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-[var(--xds-brand-600)]"
        aria-label="Quay lại"
        @click="goBack"
      >
        <XIcon name="chevron-left" :size="20" />
      </button>
      <h1 class="text-[20px] font-semibold leading-[28px] text-[var(--xds-text)]">Thêm nhân viên</h1>
    </header>

    <!-- Body cuộn được, card form căn giữa -->
    <main class="min-h-0 flex-1 overflow-y-auto">
      <div class="mx-auto w-full max-w-3xl px-4 py-6">
        <div class="rounded-lg bg-[var(--xds-bg)] shadow-[var(--xds-shadow-card)] p-6">
          <h3 class="mb-4 text-[16px] font-semibold leading-[22px] text-[var(--xds-text)]">
            Thông tin nhân viên
          </h3>

          <!-- Form 2 cột; label 13px medium trên input, dấu * đỏ cho bắt buộc -->
          <div class="grid grid-cols-1 gap-x-6 gap-y-4 sm:grid-cols-2">
            <div data-field="name">
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Họ tên <span class="text-[var(--xds-danger)]">*</span>
              </label>
              <XInput v-model="form.name" placeholder="Nhập họ tên" :error="errors.name" />
            </div>

            <div>
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Mã nhân viên
              </label>
              <XInput v-model="form.code" placeholder="Mã tự sinh" />
            </div>

            <div>
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Giới tính
              </label>
              <!-- RadioGroup ngang, canh theo chiều cao control 32px -->
              <div class="flex h-8 items-center">
                <XRadioGroup v-model="form.gender" :options="genderOptions" direction="horizontal" />
              </div>
            </div>

            <div>
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Ngày sinh
              </label>
              <XDatePicker v-model="form.birthday" :max="new Date()" />
            </div>

            <div>
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Phòng ban
              </label>
              <XSelect v-model="form.department" :options="departmentOptions" placeholder="Chọn phòng ban" />
            </div>

            <div>
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Chức danh
              </label>
              <XInput v-model="form.title" placeholder="VD: Nhân viên kinh doanh" />
            </div>

            <div data-field="email">
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Email
              </label>
              <XInput v-model="form.email" type="email" placeholder="ten@congty.vn" :error="errors.email" />
            </div>

            <div data-field="phone">
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Số điện thoại
              </label>
              <XInput v-model="form.phone" placeholder="VD: 0912 345 678" :error="errors.phone" />
            </div>

            <!-- Ghi chú: full 2 cột -->
            <div class="sm:col-span-2">
              <label class="mb-1 block text-[13px] font-medium leading-[18px] text-[var(--xds-text)]">
                Ghi chú
              </label>
              <XTextarea v-model="form.note" :rows="3" :maxlength="500" placeholder="Nhập ghi chú" />
            </div>
          </div>
        </div>
      </div>
    </main>

    <!-- Footer STICKY cuối trang (nguyên tắc màn Thêm/Sửa: Lưu/Hủy luôn ghim,
         không trôi khi cuộn) — Primary ngoài cùng bên phải theo XDS -->
    <footer
      class="flex shrink-0 items-center justify-between border-t border-[var(--xds-border)] bg-[var(--xds-bg)] px-4 py-3"
    >
      <XButton variant="secondary" @click="cancel">Hủy</XButton>
      <div class="flex items-center gap-2">
        <XButton variant="secondary" :loading="saving" @click="save">Lưu</XButton>
        <XButton variant="primary" :loading="saving" @click="saveAndNew">Lưu và Thêm mới</XButton>
      </div>
    </footer>

    <XToast />
  </div>
</template>
