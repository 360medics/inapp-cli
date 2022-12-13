<template>
    <div v-if="linkExternal">
        <a v-if="!isMobile()" class="link" :href="linkExternal" target="_blank" rel="noopener noreferrer">{{ linkExternal }}</a>
        <a v-else class="link" :href="'medics://viewer?m_source=' + linkExternal">{{ linkExternal }}</a>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import isMobile from '@/utils/isMobile'

export default defineComponent({
    name: 'LinkComponent',
    props: {
        linkExternal: {
            type: String,
            required: true,
        },
    },

    setup() {
        return {
            isMobile,
        }
    },
})
</script>

<style lang="scss" scoped>
.link {
    word-break: break-word;
    user-select: none;
    text-decoration: none;
    color: $linkExternalColor;
    &:active {
        color: $linkExternalColor;
    }
    &:focus {
        color: $linkExternalColor;
        outline: none;
    }
}
</style>
