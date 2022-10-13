<template>
    <template v-if="isUserAuthenticated">
        <div id="app-container">
            <Header />
            <main class="page page__scrollable">
                <router-view />
            </main>
            <Footer />
        </div>
    </template>

    <template v-else>
        <div id="app-container">
            <Loader />
        </div>
    </template>
</template>

<script lang="ts">
import { defineComponent, onMounted } from "vue"
import { useRoute, useRouter } from 'vue-router'
import Footer from "@/components/FooterComponent.vue"
import Header from "@/components/HeaderComponent.vue"
import Loader from "@/components/LoaderComponent.vue"
import { useUserStore } from '@/store'

export default defineComponent({
    components: {
        Footer,
        Header,
        Loader
    },
    setup() {
        const route = useRoute()
        const router = useRouter()
        const { authenticateUserFrom360, isUserAuthenticated } = useUserStore()

        onMounted(async () => {
            await router.isReady()

            const { apiKey } = route.query

            await authenticateUserFrom360(apiKey)
        })

        return {
            isUserAuthenticated
        }
    }
})
</script>

<style lang="scss">
@import "./sass";
#app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  flex: 1 1 0;
}
</style>
