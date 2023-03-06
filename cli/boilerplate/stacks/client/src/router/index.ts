import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import { useUserStore } from '@/store'
import Home from '../views/Home.vue'

const routes: Array<RouteRecordRaw> = [
    {
        path: '/',
        name: 'Home',
        component: Home,
    },
    {
        path: '/score/:slug',
        name: 'Score',
        component: () => import('../views/Score.vue'),
    },
]

const router = createRouter({
    history: createWebHashHistory(),
    routes,
})

router.beforeEach(async () => {
    const { isUserAuthenticated } = useUserStore()

    if (!isUserAuthenticated) {
        window.location.href = `https://dev.360medics.com/login?lang=fr`
    }
})

export default router
