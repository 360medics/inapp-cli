<template>
    <div class="loader-content page-content">
        <span class="loader-content__spinner"></span>
    </div>
</template>

<script  lang="ts">
import { defineComponent } from "vue"

export default defineComponent({
    name: 'LoaderComponent',
})
</script>

<style  lang="scss" scoped>
.loader-content {
    display: flex;
    justify-content: center;
    align-items: center;
    padding-top: 10px;
    padding-bottom: 10px;

    &__spinner {
        position: relative;
        bottom: 15rem;
        width: 3rem;
        height: 3rem;
        border: 5px solid $primaryColor;
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
