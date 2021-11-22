<template>
	<div class="divider" />
</template>

<script lang="ts">
import { defineComponent } from 'vue';

export default defineComponent({
	name: 'DividerComponent',
});
</script>

<style lang="scss" scoped>
.divider {
	position: relative;
	padding: $gutter_large 0;
	&:after {
		content: '';
		position: absolute;
		top: 50%;
		width: 100%;
		height: 1px;
		background-color: $borderColor;
	}
}
</style>
