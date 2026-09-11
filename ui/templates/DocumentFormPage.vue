<script setup>
/**
 * DocumentFormPage — mẫu form chứng từ kế toán full màn hình (mẫu "Phiếu thu"),
 * spec references/patterns/popup-form.md mục 5. Mở full màn hình THAY THẾ vùng
 * nội dung, header + sidebar app vẫn giữ nguyên (dùng chung XHeaderBar/XSidebar
 * app "app Kế toán" — domain khác ListPage/DashboardPage "app Nhân sự").
 * Cấu trúc dọc: Form bar (48px) → Form body (cuộn) → Form footer tối (ghim đáy).
 */
import { computed, reactive, ref } from 'vue'
import XHeaderBar from '../components/XHeaderBar.vue'
import XSidebar from '../components/XSidebar.vue'
import XSettingsDialog from '../components/XSettingsDialog.vue'
import XButton from '../components/XButton.vue'
import XInput from '../components/XInput.vue'
import XCombobox from '../components/XCombobox.vue'
import XDatePicker from '../components/XDatePicker.vue'
import XSelect from '../components/XSelect.vue'
import XSwitch from '../components/XSwitch.vue'
import XUpload from '../components/XUpload.vue'
import XIcon from '../components/XIcon.vue'
import XToast from '../components/XToast.vue'
import { useToast } from '../components/toast.js'
import { currentHeaderMode, sidebarCollapsed } from '../components/theme-state.js'

const toast = useToast()

/* ── Điều hướng app "app Kế toán" ───────────────────────────── */

const sidebarItems = [
  { key: 'tong-quan', label: 'Tổng quan', icon: 'home' },
  {
    key: 'tien-mat',
    label: 'Tiền mặt',
    icon: 'cash',
    children: [
      { key: 'phieu-thu', label: 'Phiếu thu' },
      { key: 'phieu-chi', label: 'Phiếu chi' },
    ],
  },
  { key: 'tien-gui', label: 'Tiền gửi', icon: 'building' },
  { key: 'bao-cao', label: 'Báo cáo', icon: 'chart-bar' },
  { key: 'thiet-lap', label: 'Thiết lập', icon: 'settings' },
]
const activeMenu = ref('phieu-thu')
const showSettings = ref(false)

/* ── Combobox loại chứng từ nguồn ───────────────────────────── */

const documentTypeOptions = [
  { label: 'Phiếu thu tiền mặt', value: 'pt-tien-mat' },
  { label: 'Phiếu thu tạm ứng', value: 'pt-tam-ung' },
  { label: 'Phiếu thu khác', value: 'pt-khac' },
]
const currencyOptions = [
  { label: 'VND', value: 'VND' },
  { label: 'USD', value: 'USD' },
  { label: 'EUR', value: 'EUR' },
]

/* ── State form (mock) ──────────────────────────────────────── */

const form = reactive({
  documentType: 'pt-tien-mat',
  sourceSearch: '',
  date: new Date(2026, 6, 17),
  payer: '',
  reason: '',
  attachedCount: 1,
  currency: 'VND',
  showAccount: true,
})

const entries = ref([
  { id: 1, account: '1111', accountName: 'Tiền mặt VND', debit: 15000000, credit: 0 },
  { id: 2, account: '1311', accountName: 'Phải thu khách hàng — Cty TNHH Việt Phát', debit: 0, credit: 15000000 },
])

const totalAmount = computed(() => entries.value.reduce((sum, e) => sum + e.debit, 0))
const formatMoney = (v) => Number(v || 0).toLocaleString('vi-VN')

function addEntryRow() {
  entries.value.push({ id: Date.now(), account: '', accountName: '', debit: 0, credit: 0 })
}
function clearEntryRows() {
  entries.value = []
}
function removeEntryRow(id) {
  entries.value = entries.value.filter((e) => e.id !== id)
}

/* ── Đính kèm (XUpload — component không tự upload, chỉ mô phỏng ở đây) ── */
const attachments = ref([])
function onAttachFiles(files) {
  for (const file of files) {
    const id = Date.now() + Math.random()
    attachments.value.push({ id, name: file.name, size: file.size, status: 'uploading', progress: 0 })
    const timer = setInterval(() => {
      const item = attachments.value.find((f) => f.id === id)
      if (!item) return clearInterval(timer)
      item.progress = Math.min(100, (item.progress || 0) + 25)
      if (item.progress >= 100) {
        clearInterval(timer)
        item.status = 'done'
      }
    }, 250)
  }
}

function closeForm() {
  toast.info('Đóng phiếu thu PT00020')
}
function saveDocument() {
  toast.success('Đã cất phiếu thu PT00020')
}
function saveAndAdd() {
  toast.success('Đã cất phiếu thu PT00020. Tiếp tục thêm mới.')
}
</script>

<template>
  <div
    class="flex h-full flex-col overflow-hidden bg-[var(--xds-bg-page)] text-[13px] leading-[18px] text-[var(--xds-text)]"
    :style="{ fontFamily: 'var(--xds-font-family)' }"
  >
    <!-- Header app: GIỮ NGUYÊN khi form chứng từ mở full màn hình (spec mục 5) -->
    <XHeaderBar
      :variant="currentHeaderMode"
      app-name="app Kế toán"
      search-placeholder="Tìm kiếm trong app Kế toán"
      :user="{ name: 'Nguyễn Văn An' }"
      @settings="showSettings = true"
    />

    <div class="flex min-h-0 flex-1">
      <XSidebar v-model="activeMenu" v-model:collapsed="sidebarCollapsed" :items="sidebarItems" />

      <!-- Vùng nội dung: form chứng từ thay thế toàn bộ (Form bar/body/footer) -->
      <main class="flex min-w-0 flex-1 flex-col overflow-hidden bg-[var(--xds-bg)]">
        <!-- ── Form bar (thay sub-nav, 48px) ── -->
        <div class="flex h-12 shrink-0 items-center justify-between gap-3 border-b border-[var(--xds-border-light,var(--xds-border))] px-4">
          <div class="flex min-w-0 flex-1 items-center gap-3">
            <span class="flex h-7 w-7 shrink-0 items-center justify-center rounded-md bg-[var(--xds-brand-50)] text-[var(--xds-brand-600)]">
              <XIcon name="cash" :size="16" />
            </span>
            <span class="shrink-0 whitespace-nowrap text-[13px] text-[var(--xds-text)]">
              Phiếu thu <span class="font-semibold">PT00020</span>
            </span>
            <span class="h-5 w-px shrink-0 bg-[var(--xds-border)]" />
            <div class="w-[200px] shrink-0">
              <XCombobox v-model="form.documentType" :options="documentTypeOptions" allow-create @create="toast.info('Thêm nhanh loại chứng từ')" />
            </div>
            <div class="min-w-0 max-w-[360px] flex-1">
              <XInput v-model="form.sourceSearch" placeholder="Tìm chứng từ nguồn (đơn hàng, hợp đồng...)" clearable>
                <template #prefix><XIcon name="search" :size="16" /></template>
              </XInput>
            </div>
          </div>

          <div class="flex shrink-0 items-center gap-2">
            <XButton variant="outline">
              <template #icon><XIcon name="help" :size="16" class="text-[var(--xds-success)]" /></template>
              Hướng dẫn sử dụng
              <XIcon name="chevron-down" :size="16" />
            </XButton>
            <button
              type="button"
              class="flex h-8 w-8 items-center justify-center rounded-lg border border-[var(--xds-border)] text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)]"
              title="Thiết lập"
            >
              <XIcon name="settings" :size="16" />
            </button>
            <button
              type="button"
              class="flex h-8 w-8 items-center justify-center rounded-lg text-[var(--xds-icon-neutral)] hover:bg-[var(--xds-bg-hover-soft)]"
              aria-label="Đóng"
              @click="closeForm"
            >
              <XIcon name="x" :size="16" />
            </button>
          </div>
        </div>

        <!-- ── Form body: cuộn, header/footer ghim ── -->
        <div class="min-h-0 flex-1 overflow-y-auto px-6 py-5">
          <!-- Vùng field thông tin chung + tổng tiền lớn góc phải trên -->
          <div class="mb-6 flex flex-wrap items-start justify-between gap-4">
            <div class="flex flex-1 flex-wrap gap-4">
              <div class="w-[200px]">
                <label class="mb-1 block font-medium text-[var(--xds-text)]">Ngày hạch toán</label>
                <XDatePicker v-model="form.date" />
              </div>
              <div class="min-w-[220px] flex-1">
                <label class="mb-1 block font-medium text-[var(--xds-text)]">Người nộp tiền</label>
                <XInput v-model="form.payer" placeholder="Nhập tên người nộp">
                  <template #suffix><XIcon name="plus" :size="16" class="cursor-pointer" @click="toast.info('Thêm nhanh danh mục người nộp')" /></template>
                </XInput>
              </div>
              <div class="w-[220px]">
                <label class="mb-1 block font-medium text-[var(--xds-text)]">Lý do nộp</label>
                <XInput v-model="form.reason" placeholder="VD: Thu tiền bán hàng">
                  <template #suffix><XIcon name="list" :size="16" class="cursor-pointer" /></template>
                </XInput>
              </div>
              <div class="w-[175px]">
                <label class="mb-1 block font-medium text-[var(--xds-text)]">Kèm theo</label>
                <div class="flex h-8 items-center gap-2 rounded-lg border border-[var(--xds-border)] bg-[var(--xds-bg)] px-2">
                  <input
                    v-model.number="form.attachedCount"
                    type="number"
                    min="0"
                    class="w-8 bg-transparent text-right outline-none [appearance:textfield]"
                  />
                  <span class="h-4 w-px shrink-0 bg-[var(--xds-border)]" />
                  <span class="truncate text-[var(--xds-text-secondary)]">chứng từ gốc</span>
                </div>
              </div>
            </div>

            <div class="shrink-0 text-right">
              <div class="text-[12px] text-[var(--xds-text-secondary)]">Tổng tiền</div>
              <div class="text-[28px] font-bold leading-tight text-[var(--xds-text)]">{{ formatMoney(totalAmount) }}</div>
            </div>
          </div>

          <!-- Section bảng hạch toán (inline edit) -->
          <section class="mb-6">
            <div class="mb-2 flex items-center justify-between gap-3">
              <h3 class="text-[16px] font-semibold leading-[22px] text-[var(--xds-text)]">Hạch toán</h3>
              <div class="flex items-center gap-2">
                <div class="w-[110px]">
                  <XSelect v-model="form.currency" :options="currencyOptions" />
                </div>
              </div>
            </div>

            <div class="overflow-hidden rounded-lg border border-[var(--xds-border)]">
              <table class="w-full table-fixed border-collapse text-[13px] leading-[18px]">
                <thead>
                  <tr class="h-9 bg-[var(--xds-bg-page)] text-[12px] font-medium text-[var(--xds-text-secondary)]">
                    <th class="w-[120px] border-b border-[var(--xds-border)] px-3 text-left">Tài khoản</th>
                    <th class="border-b border-[var(--xds-border)] px-3 text-left">Tên tài khoản</th>
                    <th class="w-[150px] border-b border-[var(--xds-border)] px-3 text-right">Nợ</th>
                    <th class="w-[150px] border-b border-[var(--xds-border)] px-3 text-right">Có</th>
                    <th class="w-10 border-b border-[var(--xds-border)] px-2"></th>
                  </tr>
                </thead>
                <tbody>
                  <tr
                    v-for="row in entries"
                    :key="row.id"
                    class="group h-9 border-b border-[var(--xds-border-light,var(--xds-border))] last:border-b-0 hover:bg-[var(--xds-bg-hover-soft)]"
                  >
                    <td class="px-1">
                      <input
                        v-model="row.account"
                        class="h-7 w-full rounded border border-transparent bg-transparent px-2 outline-none hover:border-[var(--xds-border)] hover:bg-[var(--xds-bg)] focus:border-[var(--xds-brand-600)] focus:bg-[var(--xds-bg)] focus:ring-2 focus:ring-[var(--xds-brand-50)]"
                      />
                    </td>
                    <td class="px-1">
                      <input
                        v-model="row.accountName"
                        class="h-7 w-full truncate rounded border border-transparent bg-transparent px-2 outline-none hover:border-[var(--xds-border)] hover:bg-[var(--xds-bg)] focus:border-[var(--xds-brand-600)] focus:bg-[var(--xds-bg)] focus:ring-2 focus:ring-[var(--xds-brand-50)]"
                      />
                    </td>
                    <td class="px-1">
                      <input
                        v-model.number="row.debit"
                        type="number"
                        class="h-7 w-full rounded border border-transparent bg-transparent px-2 text-right font-[inherit] outline-none [font-feature-settings:'tnum'] hover:border-[var(--xds-border)] hover:bg-[var(--xds-bg)] focus:border-[var(--xds-brand-600)] focus:bg-[var(--xds-bg)] focus:ring-2 focus:ring-[var(--xds-brand-50)]"
                      />
                    </td>
                    <td class="px-1">
                      <input
                        v-model.number="row.credit"
                        type="number"
                        class="h-7 w-full rounded border border-transparent bg-transparent px-2 text-right outline-none [font-feature-settings:'tnum'] hover:border-[var(--xds-border)] hover:bg-[var(--xds-bg)] focus:border-[var(--xds-brand-600)] focus:bg-[var(--xds-bg)] focus:ring-2 focus:ring-[var(--xds-brand-50)]"
                      />
                    </td>
                    <td class="text-center">
                      <button
                        type="button"
                        class="flex h-7 w-7 items-center justify-center rounded text-[var(--xds-danger)] opacity-0 hover:bg-[var(--xds-bg-hover-soft)] group-hover:opacity-100"
                        aria-label="Xóa dòng"
                        @click="removeEntryRow(row.id)"
                      >
                        <XIcon name="trash" :size="16" />
                      </button>
                    </td>
                  </tr>
                </tbody>
                <tfoot>
                  <tr class="h-9 bg-[var(--xds-bg-page)] text-[12px] font-medium text-[var(--xds-text-secondary)]">
                    <td colspan="2" class="border-t border-[var(--xds-border)] px-3">Tổng</td>
                    <td class="border-t border-[var(--xds-border)] px-3 text-right font-semibold text-[var(--xds-text)] [font-feature-settings:'tnum']">{{ formatMoney(totalAmount) }}</td>
                    <td class="border-t border-[var(--xds-border)] px-3 text-right font-semibold text-[var(--xds-text)] [font-feature-settings:'tnum']">{{ formatMoney(totalAmount) }}</td>
                    <td class="border-t border-[var(--xds-border)]"></td>
                  </tr>
                </tfoot>
              </table>
            </div>

            <div class="mt-2 flex items-center justify-between gap-3">
              <div class="flex items-center gap-2">
                <XButton variant="outline" @click="addEntryRow">
                  <template #icon><XIcon name="plus" :size="16" /></template>
                  Thêm dòng
                </XButton>
                <XButton variant="outline" @click="clearEntryRows">
                  <template #icon><XIcon name="trash" :size="16" /></template>
                  Xóa hết dòng
                </XButton>
              </div>
              <span class="text-[12px] text-[var(--xds-text-secondary)]">Tổng số: {{ entries.length }} bản ghi</span>
            </div>
          </section>

          <!-- Đính kèm -->
          <section>
            <XUpload
              v-model="attachments"
              :max-size-m-b="5"
              @select-files="onAttachFiles"
              @oversized="(files) => toast.info(`${files.length} tệp vượt quá 5MB`)"
              @remove="(id) => (attachments = attachments.filter((f) => f.id !== id))"
            />
          </section>
        </div>

        <!-- ── Form footer: thanh tối ghim đáy (điểm nhận diện form chứng từ) ── -->
        <div class="flex h-[52px] shrink-0 items-center justify-between gap-4 bg-[var(--xds-neutral-800,#484E59)] px-4">
          <span class="hidden shrink-0 text-[12px] text-white/50 sm:block">
            F3 - Tìm nhanh, F9 - Thêm nhanh
          </span>
          <div class="ml-auto flex items-center gap-3">
            <button
              type="button"
              class="rounded-lg border border-white/25 px-3.5 py-1.5 text-[13px] font-medium text-white transition-colors hover:bg-white/10"
              @click="closeForm"
            >
              Hủy
            </button>
            <XSwitch v-model="form.showAccount" label="Hiển thị tài khoản" class="text-white" />
            <button
              type="button"
              class="rounded-lg border border-white/25 px-3.5 py-1.5 text-[13px] font-medium text-white transition-colors hover:bg-white/10"
              @click="saveDocument"
            >
              Cất
            </button>
            <!-- Split button primary "Cất và Thêm" — Primary ngoài cùng bên phải theo XDS -->
            <div class="flex overflow-hidden rounded-lg">
              <button
                type="button"
                class="border-r border-white/20 bg-[var(--xds-brand-600)] px-3.5 py-1.5 text-[13px] font-medium text-white transition-colors hover:bg-[var(--xds-brand-700)]"
                @click="saveAndAdd"
              >
                Cất và Thêm
              </button>
              <button
                type="button"
                class="flex items-center justify-center bg-[var(--xds-brand-600)] px-2 text-white transition-colors hover:bg-[var(--xds-brand-700)]"
                aria-label="Chọn biến thể lưu"
              >
                <XIcon name="chevron-down" :size="16" />
              </button>
            </div>
          </div>
        </div>
      </main>
    </div>

    <XSettingsDialog v-model="showSettings" />
    <XToast />
  </div>
</template>
