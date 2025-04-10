import { createRouter, createWebHistory } from 'vue-router'
import dashboard from '@/views/dashboard/index.vue'
import test from '@/views/test/index.vue'
import career from '@/views/career/index.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'dashboard',
      component: dashboard,
    },
    {
      path: '/test',
      name: 'test',
      component: test,
    },
    {
      path: '/career',
      name: 'career',
      component: career,
    },
  ],
})

export default router
