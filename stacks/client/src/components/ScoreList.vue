<template>
    <ul class="scoreList">
        <li v-for="list in scores" :key="list.id" class="scoreList__items">
            <span
                v-if="list.submenu"
                class="scoreList__item"
                @click="
                    onToggle = !onToggle;
                    itemSelected(list.id);
                "
            >
                {{ list.name }}
                <i
                    class="scoreList__item__icon fas"
                    :class="`${onToggle && list.id === optionSelectedID ? 'fa-chevron-up' : 'fa-chevron-down'}`"
                />
            </span>

            <div
                :id="list.id"
                class="submenu"
                :class="`${onToggle && list.id === optionSelectedID ? '' : 'submenu--hidden'}`"
            >
                <div v-for="submenu in list.children" :key="submenu.id" class="submenu__items">
                    <router-link :to="`/score/${submenu.slug}`" class="submenu__item">
                        {{ submenu.name }}
                        <i class="submenu__item__arrow fas fa-chevron-right" />
                    </router-link>
                </div>
            </div>
        </li>
    </ul>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive, toRefs } from 'vue'
import { useScoresStore } from '@/store'

export default defineComponent({
    name: 'ScoreList',
    setup() {
        const { getScores, scores } = useScoresStore()
        const state = reactive({
            scores,
            onToggle: false,
            optionSelectedID: 0,
        })
        const itemSelected = (item: number): void => {
            state.optionSelectedID = item
        }

        onMounted(() => {
            getScores()
        })
        // expose to template
        return {
            ...toRefs(state),
            itemSelected,
        }
    },
})
</script>

<style scoped lang="scss">
.scoreList {
    display: flex;
    flex-flow: column nowrap;
    font-weight: 700;
    margin: $menuItem_gutter 0;
    &__items {
        margin-top: $menuItem_gutter;
    }
    &__item {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: $menuItem_gutter;
        border-radius: $menuItem_radius;
        box-shadow: $menuItem_shadow;
        color: $menuItem_color;
        background-color: $menuItem_backgroundColor;
        font-size: $menuItem_fontsize;
        &__icon {
            border-radius: $menuItemIcon_gutter;
            padding: $menuItemIcon_gutter;
            margin-left: 1em;
            color: $menuItemIcon_color;
            background-color: $menuItemIcon_backgroundColor;
        }
    }
}
.submenu {
    box-shadow: $submenuItem_shadow;
    border-radius: $submenuItem_corner;
    margin-top: -$menuItem_gutter;
    &__items {
        background-color: $menuItem_backgroundColor;
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 0 $menuItemIcon_gutter;
        &:first-child {
            padding-top: $menuItemIcon_gutter;
        }
        &:last-child {
            border-radius: $submenuItem_corner;
            padding-bottom: $menuItemIcon_gutter;
        }
    }
    &__item {
        width: 100%;
        display: flex;
        justify-content: space-between;
        text-decoration: none;
        color: $menuItem_color;
        background-color: $submenuItem_backgroundColor;
        padding: $menuItemIcon_gutter $gutter_small;
        margin: $submenuItemIcon_gutter;
        border-radius: $menuItem_radius;
        &__arrow {
            display: flex;
            align-items: center;
        }
    }
    &--hidden {
        display: none;
        transition: display 1s ease-in-out;
    }
}
</style>
