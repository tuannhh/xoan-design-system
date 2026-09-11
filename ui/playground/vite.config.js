import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import tailwindcss from '@tailwindcss/vite'
import { fileURLToPath } from 'node:url'

export default defineConfig({
  plugins: [vue(), tailwindcss()],
  resolve: {
    alias: {
      // Trỏ tới bộ component & assets của skill (nằm ngoài thư mục playground)
      '@xds': fileURLToPath(new URL('../components', import.meta.url)),
      '@tpl': fileURLToPath(new URL('../templates', import.meta.url)),
      '@assets': fileURLToPath(new URL('../../assets', import.meta.url)),
      // XChart.vue nằm ngoài root playground → trỏ echarts về node_modules ở đây
      'echarts': fileURLToPath(new URL('./node_modules/echarts', import.meta.url)),
    },
  },
  server: {
    port: 5199,
    fs: { allow: ['../..'] },
  },
})
