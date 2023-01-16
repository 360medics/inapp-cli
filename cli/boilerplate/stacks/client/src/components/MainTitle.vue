<template>
    <div>
        <h3>{{ title }}</h3>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
    name: 'MainTitle',
    props: {
        title: {
            type: String,
            required: true,
            default: ''
        }
    },
})
</script>

<style scoped lang="scss">
h3 {
    margin: 0 0 $gutterMedium 0;
    font-size: $fontSizeBig;
    color: $primaryColor;
}
</style>
