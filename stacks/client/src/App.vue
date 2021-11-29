<template>
    <div id="app-container">
        <Header />
        <main class="page page__scrollable">
            <router-view />
        </main>
        <Footer />
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import Header from '@/components/HeaderComponent.vue'
import Footer from '@/components/FooterComponent.vue'

export default defineComponent({
    components: {
        Header,
        Footer,
    },
})
</script>

<style lang="scss">
#app-container {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    flex: 1 1 0;
}
</style>
