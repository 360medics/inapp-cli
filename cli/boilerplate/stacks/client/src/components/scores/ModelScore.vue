<template>
    <div class="page-content">
        <h3>{{ $t('modelScorePage.hello') }}</h3>
    </div>
</template>

<script lang="ts">
import { defineComponent, onMounted } from 'vue'
import { useRoute } from 'vue-router'
import { useScoreStore } from '@/store'

export default defineComponent({
    name: 'ModelScore',
    setup() {
        const route = useRoute()
        const { getScore, score } = useScoreStore()
        onMounted(() => {
            getScore(route.params.slug)
        })

        return {
            score,
        }
    },
})
</script>
