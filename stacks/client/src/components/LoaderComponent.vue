<template>
    <div class="spinner">
        <div class="spinner__circle spinner__circle--1"></div>
        <div class="spinner__circle spinner__circle--2"></div>
    </div>
</template>

<script  lang="ts">
import { defineComponent } from "vue"

export default defineComponent({
    name: 'LoaderComponent',
})
</script>

<style  lang="scss" scoped>
.spinner {
    box-sizing: border-box;
    width: 60px;
    height: 60px;
    border-radius: 100%;
    position: relative;
    margin: auto;
    &__circle {
        position: absolute;
        width: 100%;
        height: 100%;
        border-radius: 100%;
        border: calc(60px / 10) solid transparent;
        &--1 {
            border-top-color: #202023;
            animation: half-circle-spinner-animation 1s infinite;
        }
        &--2 {
            border-bottom-color: #202023;
            animation: half-circle-spinner-animation 1s infinite alternate;
        }
    }
}

@keyframes half-circle-spinner-animation {
    0% {
        transform: rotate(0deg);

    }
    100%{
        transform: rotate(360deg);
    }
}
</style>