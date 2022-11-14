<template>
    <div id="app-container">
        <Header />
        <main class="page page__scrollable">
            <router-view v-if="!isLoading"/>
            <div class="loader-content page-content" v-else>
                <span class="loader"></span>
            </div>
        </main>
        <Footer />
    </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, ref } from "vue"
import Header from "@/components/HeaderComponent.vue"
import Footer from "@/components/FooterComponent.vue"

export default defineComponent({
    components: {
        Header,
        Footer,
    },
    setup() {
        const isLoading = ref<boolean>(true)

        onMounted(() => {
            isLoading.value = false   
        })

        return { isLoading }
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
.loader-content {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 10px;
    padding-bottom: 10px;
}

.loader {
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

    @keyframes rotation {
    0% {
        transform: rotate(0deg);
    }
    100% {
        transform: rotate(360deg);
    }
} 
</style>
