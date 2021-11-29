<template>
    <div class="home">
        <MainTitle :title="appInfo.name" />
        <p>Exemple de lien externe :</p>
        <LinkComponent link-external="https://www.google.com" />
        <p>Exemple de lien externe vers un pdf inclus dans un viewer :</p>
        <PDFViewer
            pdf-link="https://med-cdn.ams3.digitaloceanspaces.com/assets/docs/dir69000-69299/69062/main-69062.pdf"
            pdf-name="open pdf"
        />
        <ScoreList />
        <ScoreList />
        <ScoreList />
    </div>
</template>

<script lang="ts">
import axios from 'axios'
import { defineComponent } from 'vue'
import MainTitle from '@/components/MainTitle.vue'
import LinkComponent from '@/components/LinkComponent.vue'
import PDFViewer from '@/components/PDFViewer.vue'
import ScoreList from '@/components/ScoreList.vue'

export default defineComponent({
    name: 'HomeViews',
    components: { MainTitle, ScoreList, PDFViewer, LinkComponent },
    data() {
        return {
            appInfo: {},
        }
    },
    mounted() {
        this.loadData()
            .then((result) => {
                this.appInfo = result.appData
            })
    },
    methods: {
        async loadData() {
            const data = await axios.get(`${window.location.origin + window.location.pathname}/dataTree.json`)
            return data.data
        },
    },
})
</script>

<style scoped lang="scss">
.home {
	width: 100%;
}

p {
    margin: $gutter_small 0;
}
</style>
