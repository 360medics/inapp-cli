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
    margin: 0 0 $gutter_medium 0;
    font-size: $font_size_big;
    color: $primary_color;
}
</style>
