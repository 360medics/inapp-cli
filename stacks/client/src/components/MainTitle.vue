<template>
    <div>
        <h3>{{ title }}</h3>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'

export default defineComponent({
    name: 'MainTitle',
    props: ['title'],
})
</script>

<style scoped lang="scss">
h3 {
    margin: $gutter_large 0;
    font-size: $font_size_big;
    color: $primary_color;
}
</style>
