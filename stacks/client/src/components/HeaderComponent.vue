<template>
    <div class="header">
        <div v-if="displayChevronCircle" class="fas fa-chevron-left header__icon header__icon--left" @click="goBack" />
        <div v-else class="fas fa-chevron-left header__icon header__icon--left-disabled" />

        <router-link to="/" class="header__logo">
            <img class="header__logo" src="@/assets/logo.png" alt="logo">
        </router-link>

        <div v-if="isMobile()">
            <a href="cmd://webview-close" class="header__icon header__icon--right">
                <i class="far fa-times-circle" />
            </a>
        </div>
        <div v-else />
    </div>
</template>

<script lang="ts">
import { defineComponent, watch, reactive, toRefs } from 'vue'
import { useRoute } from 'vue-router'
import isMobile from '@/utils/isMobile'
import goBack from '@/utils/goBack'

export default defineComponent({
    name: 'HeaderComponent',
    setup() {
        const route = useRoute()
        const state = reactive({
            displayChevronCircle: false,
        })

        watch(route, () => {
            state.displayChevronCircle = route.path !== '/'
        })
        // Expose to template
        return {
            isMobile,
            goBack,
            ...toRefs(state),
        }
    },
})
</script>

<style lang="scss" scoped>
.header {
    width: $header_width;
    padding: $header_gutter 0;
    background-color: $header_BackgroundColor;
    box-shadow: $header_shadow;
    border-radius: 0 0 $header_radius $header_radius;
    @include positionFixed(0, 0, null, 0);
    @extend %flexAlignCenter;
    justify-content: space-between;
    z-index: 10;
    &__logo {
        max-width: $headerLogo_width;
        height: $headerLogo_height;
        text-decoration: none;
    }
    &__icon {
        line-height: $headerIcon_height;
        width: $headerIcon_width;
        &--left {
            @include circleIcon($headerArrowIcon_color);
        }
        &--right {
            margin-right: $headerIcon_gutter;
            font-size: $headerIcon_width;
            color: $headerCrossIcon_color;
        }
    }
}
</style>
