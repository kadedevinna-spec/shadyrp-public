import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  // Use relative paths so assets work when served from a subfolder (e.g. CFX NUI).
  base: './',
  plugins: [react()],
})
