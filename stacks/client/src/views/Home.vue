<template>
    <div class="page-content">
        <MainTitle v-if="areAppInfosLoaded" :title="appInfos.name" />
        <p>Exemple de lien externe :</p>
        <LinkComponent link-external="https://www.google.com" />
        <p>Exemple de lien externe vers un pdf inclus dans un viewer :</p>
        <PDFViewer pdf-link="https://med-cdn.ams3.digitaloceanspaces.com/assets/docs/dir69000-69299/69062/main-69062.pdf" pdf-name="open pdf" />
        <ScoreList />
        <p>Exemple de petits bouton </p>
        <div class="page-content__container">
            <ButtonComponent :onClick="showAlert">360</ButtonComponent>
            <ButtonComponent :onClick="showAlert">360</ButtonComponent>
            <ButtonComponent :onClick="showAlert">360</ButtonComponent>
            <ButtonComponent :onClick="showAlert">360</ButtonComponent>
            <ButtonComponent :onClick="showAlert">360</ButtonComponent>
            <ButtonComponent :onClick="showAlert">360</ButtonComponent>
        </div>
        <p>Exemple de bouton 'half' </p>
        <div class="page-content__container">
            <ButtonComponent size="halfsize" :onClick="showAlert">bouton</ButtonComponent>
            <ButtonComponent size="halfsize" :onClick="showAlert">bouton</ButtonComponent>
        </div>
        <p>Exemple de bouton 'full' </p>
        <div class="page-content__container">
            <ButtonComponent size="fullsize" :onClick="showAlert">bouton</ButtonComponent>
        </div>
        <Footer />
    </div>
</template>

<script lang="ts">
import axios from 'axios'
import { defineComponent } from 'vue'
import MainTitle from '@/components/MainTitle.vue'
import LinkComponent from '@/components/LinkComponent.vue'
import PDFViewer from '@/components/PDFViewer.vue'
import ScoreList from '@/components/ScoreList.vue'
import ButtonComponent from '@/components/ButtonComponent.vue'
import Footer from "@/components/FooterComponent.vue"

export default defineComponent({
    name: 'HomeViews',
    components: {
        MainTitle,
        ScoreList,
        PDFViewer,
        LinkComponent,
        ButtonComponent,
        Footer
    },
    data() {
        return {
            appInfos: {},
            areAppInfosLoaded: false,
        }
    },
    mounted() {
        this.loadData().then((result) => {
            this.appInfos = result.appData
            this.areAppInfosLoaded = true
        })
    },
    methods: {
        async loadData() {
            const data = await axios.get('./dataTree.json')
            return data.data
        },
        showAlert() {
            alert('Alerte test')
        }
    },
})
</script>

<style lang="scss">
.page-content {
    width: 100%;
    background-color: $light_color;
    border-top-left-radius: 1.875rem;
    border-top-right-radius: 1.875rem;
    box-shadow: $page_content_shadow;
    padding: 1.5625rem 1.25rem;
    min-height: 100vh;

    &__container {
        display: flex;
        justify-content: space-between;
        margin: $gutter_small 0;
    }
}
</style>
