<template>
    <template v-if="isUserAuthenticated || isLocalEnvironnement">
        <div id="app-container">
            <Header />
            <main class="page page__scrollable">
                <router-view v-if="!isLoading"/>
                <div v-else class="loader-content page-content">
                    <span class="loader-content__spinner"></span>
                </div>
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
import { defineComponent, onMounted, ref } from "vue"
import { useRoute, useRouter } from 'vue-router'
import Footer from "@/components/FooterComponent.vue"
import Header from "@/components/HeaderComponent.vue"
import Loader from "@/components/LoaderComponent.vue"
import { useUserStore } from '@/store'
import { getNavigatorLanguage, i18n, updateLocale } from "@/i18n"

export default defineComponent({
    components: {
        Footer,
        Header,
        Loader
    },
    setup() {
        const isLoading = ref<boolean>(true)
        const route = useRoute()
        const router = useRouter()
        const { authenticateUserFrom360, isUserAuthenticated } = useUserStore()
        const isLocalEnvironnement = ref<boolean>(false)

        onMounted(async () => {
            if (process.env.NODE_ENV !== "development") {
                await router.isReady()
                const { apiKey } = route.query
                await authenticateUserFrom360(apiKey)
            } else {
                isLocalEnvironnement.value = true
            }
            updateLocale(getNavigatorLanguage() || 'en', i18n)
            isLoading.value = false
        })

        return {
            isUserAuthenticated,
            isLocalEnvironnement,
            isLoading,
        }
    }
})
</script>

<style lang="scss">
@import "./sass";
#app-container {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  flex: 1 1 0;
}
.loader-content {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 10px;
    padding-bottom: 10px;

    &__spinner {
        position: relative;
        bottom: 15rem;
        width: 3rem;
        height: 3rem;
        border: 5px solid $primaryColor;
        border-bottom-color: transparent;
        border-radius: 50%;
        display: inline-block;
        box-sizing: border-box;
        animation: rotation 1s linear infinite;
    }
}

    @keyframes rotation {
    0% {
        transform: rotate(0deg);
    }
    100% {
        transform: rotate(360deg);
    }
}
</style>
