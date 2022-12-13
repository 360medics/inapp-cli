<template>
    <footer class="footer">
        <Divider />
        <p>
            L’évaluation d’un patient est avant tout clinique et/ou biologique. Le traitement d’un patient ne peut reposer sur
            le seul résultat de cette application
        </p>
    </footer>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import Divider from '@/components/DividerComponent.vue'

export default defineComponent({
    name: 'FooterComponent',
    components: { Divider },
})
</script>

<style lang="scss" scoped>
.footer {
    display: flex;
    flex-direction: column;
    padding: 0 $gutterLarge $gutterLarge $gutterLarge;
    font-size: $footerFontSize;
    color: $footerColor;
    }
</style>
