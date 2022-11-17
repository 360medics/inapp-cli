<template>
    <div id="app-container">
        <Header />
        <main class="page page__scrollable">
            <router-view v-if="!isLoading"/>
            <div class="loader-content page-content" v-else>
                <span class="loader-content__spinner"></span>
            </div>
        </main>
    </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from "vue"
import { getNavigatorLanguage, i18n, updateLocale } from "@/i18n"
import Header from "@/components/HeaderComponent.vue"

export default defineComponent({
    components: {
        Header,
    },
    setup() {
        const isLoading = ref<boolean>(true)
        onMounted(() => {
            updateLocale(getNavigatorLanguage() || 'en', i18n)
            isLoading.value = false
        })

        return { isLoading }
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
        width: 50px;
        height: 50px;
        border: 5px solid $primary_color;
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
