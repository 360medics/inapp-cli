<template>
	<main v-if="componentFile" class="score">
		<component :is="componentFile" />
	</main>
</template>

<script lang="ts">
import { defineComponent, computed, defineAsyncComponent } from 'vue';
import { useRoute } from 'vue-router';
import capitalize from '@/helpers/capitalize';

export default defineComponent({
	name: 'ScoreViews',
	setup() {
		const route = useRoute();
		const componentFile = computed(() =>
			defineAsyncComponent(() => import(`@/components/scores/${capitalize(route.params.slug)}.vue`)),
		);

		return {
			componentFile,
		};
	},
});
</script>
