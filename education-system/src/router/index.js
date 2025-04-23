import { createRouter, createWebHistory } from 'vue-router'
import dashboard from '@/views/dashboard/index.vue'
import test from '@/views/test/index.vue'
import career from '@/views/career/index.vue'
import CareerStories from '@/views/career-stories/index.vue'


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
    {
      path: '/career-stories',
      name: 'CareerStories',
      component: CareerStories,
    },
  ],
})

export default router
