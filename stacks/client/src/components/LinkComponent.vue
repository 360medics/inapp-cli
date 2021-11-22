<template>
	<div v-if="linkExternal">
		<a v-if="!isMobile()" class="link" :href="linkExternal" target="_blank">{{ linkExternal }}</a>
		<a v-else class="link" :href="'medics://viewer?m_source=' + linkExternal">{{ linkExternal }}</a>
	</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';
import isMobile from '@/helpers/isMobile';

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
		};
	},
});
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
