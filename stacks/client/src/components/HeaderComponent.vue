<template>
    <div>
        <div class="header-bg"></div>
        <div class="header">
            <div v-if="displayChevronSquare" class="fas fa-chevron-left header-icon header-icon--left" @click="goBack" />
            <router-link to="/" class="header-logo">
                <img class="header-logo" :class="{'is-homepage': !displayChevronSquare}" src="@/assets/logo.png" alt="Logo">
            </router-link>
            <div v-if="isMobile()">
                <a href="cmd://webview-close" class="header-icon header-icon--right">
                    <i class="fas fa-times" />
                </a>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { computed, defineComponent } from 'vue'
import { useRoute } from 'vue-router'
import isMobile from "@/utils/isMobile"
import goBack from "@/utils/goBack"

export default defineComponent({
    name: 'HeaderComponents',
    components:{},

    setup(){
        const route = useRoute()
        const displayChevronSquare = computed(() => {
            return route.path !== '/'
        })

        return { isMobile, goBack,displayChevronSquare }
    }

})
</script>

<style lang="scss" scoped>
.header-bg {
    position: absolute;
    top: 0;
    width: 100%;
    height: 30%;
    background-image: url('@/assets/header/header-bg.png');
    background-repeat: no-repeat;
    background-size: cover;
    box-shadow: inset 0 1rem 1rem $light_color;
    opacity: .8;
    z-index: -1;
}

.header {
    width: $header_width;
    margin-top: 1rem;
    padding: $header_gutter 0;
    @extend %flexAlignCenter;
    justify-content: space-between;
    z-index: 10;

    .is-homepage {
        margin-left: 5.2rem;
    }

    &-logo {
        max-width: $header_logo_width;
        height: 3.5rem;
        text-decoration: none;
    }

    &-icon {
        &--left {
            margin-left: 1.25rem;
            @include squareIcon($header_arrow_icon_color);
        }
        &--right {
            margin-right: 1.25rem;
            @include squareIcon($headerCrossIcon_color);
        }
    }
}

</style>
