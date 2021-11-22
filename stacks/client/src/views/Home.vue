<template>
	<div class="home">
		<div />
		<LinkComponent link-external="http://www.google.com" />
		<PDFViewer
			pdf-link="https://med-cdn.ams3.digitaloceanspaces.com/assets/docs/dir69000-69299/69062/main-69062.pdf"
			pdf-name="open pdf"
		/>
		<ScoreList />
	</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import LinkComponent from '@/components/LinkComponent.vue';
import PDFViewer from '@/components/PDFViewer.vue';
import ScoreList from '@/components/ScoreList.vue';

export default defineComponent({
	name: 'HomeViews',
	components: { ScoreList, PDFViewer, LinkComponent },
});
</script>

<style>
.home {
	width: 100%;
}
</style>
