<template>
    <div v-if="pdfLink" class="pdfviewer">
        <a
            v-if="!isMobile()"
            class="link"
            :href="`https://f.360medics.com/pdfviewer/index.html?f=${pdfLink}`"
            target="_blank"
        >
            {{ pdfName }}
        </a>
        <a v-else class="link" :href="'medics://viewer?m_source=https://f.360medics.com/pdfviewer/index.html?f=' + pdfLink">
            {{ pdfName }}
        </a>
    </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import isMobile from '@/utils/isMobile'

export default defineComponent({
    name: 'PDFViewer',
    props: {
        pdfLink: {
            type: String,
            required: true,
        },
        pdfName: {
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
    color: $linkExternal_color;
    &:active {
        color: $linkExternal_color;
    }
    &:focus {
        color: $linkExternal_color;
        outline: none;
    }
}
</style>
