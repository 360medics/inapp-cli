<template>
    <button class="button" :class="{ button__halfsize: size === 'halfsize' ,button__fullsize: size === 'fullsize'}" @click="onClick">
        <slot>Please insert text</slot>
    </button>
</template>

<script lang="ts">
/**
   *
   * @displayName Button reusable
   */
export default {
    name: 'ButtonComponent',
    props: {
        /**
       * Gets called when the user clicks on the button
       */
        onClick: {
            type: Function,
            required: true
        },
        /**
       * The size of the button
       * @values small, regular, large
       */
        size: {
            type: String,
            default: '',
        }
    },
}
</script>

<style lang="scss" scoped>
.button {
    // you can edit btn mixin args... => padding, fontSize, color, backgroundColor, cornerSize, fontWeight
    @include btn();
    &__halfsize {
        min-width: calc(50% - $gutterSmall/2);
    }
    &__fullsize {
        min-width: 100%;
    }
}
</style>
