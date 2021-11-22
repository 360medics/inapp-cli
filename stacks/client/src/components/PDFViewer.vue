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
import { defineComponent } from 'vue';
import isMobile from '@/helpers/isMobile';

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
		};
	},
});
</script>
