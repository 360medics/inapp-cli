<template>
    <ul class="scoreList">
        <li v-for="list in scores" :key="list.id" class="scoreList__items">
            <span
                v-if="list.submenu"
                class="scoreList__item"
                :class="
                    selectedMenuRef === list.id
                        ? 'scoreList__item--open'
                        : 'scoreList__item--close'
                "
                @click="setItemSelected(list.id)"
            >
                {{ list.name }}
                <i
                    class="scoreList__item__icon fas"
                    :class="`${
                        list.id === selectedMenuRef ? 'fa-chevron-down' : 'fa-chevron-up'
                    }`"
                />
            </span>

            <collapse-transition :duration="200" name="dropdown">
                <div v-show="list.id === selectedMenuRef" :id="list.id" class="submenu">
                    <div
                        v-for="submenu in list.children"
                        :key="submenu.id"
                        class="submenu__items"
                    >
                        <router-link :to="`/score/${submenu.slug}`" class="submenu__item">
                            {{ submenu.name }}
                            <i class="submenu__item__arrow fas fa-chevron-right" />
                        </router-link>
                    </div>
                </div>
            </collapse-transition>
        </li>
    </ul>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive, toRefs } from "vue"
import CollapseTransition from "@ivanv/vue-collapse-transition/src/CollapseTransition.vue"
import { useScoresStore, useOpenMenuStore } from "@/store"

export default defineComponent({
    name: "ScoreList",
    components: { CollapseTransition },
    setup() {
        const { updateCollapsibleMenu, selectedMenu } = useOpenMenuStore()
        const { getScores, scores } = useScoresStore()
        onMounted(() => {
            getScores()
        })
        const data = reactive({
            selectedMenuRef: selectedMenu.value,
            scores,
        })
        const setItemSelected = (item: number): void => {
            if (!data.selectedMenuRef) {
                updateCollapsibleMenu(item)
                data.selectedMenuRef = item
            } else if (data.selectedMenuRef === item) {
                updateCollapsibleMenu(0)
                data.selectedMenuRef = 0
            } else {
                updateCollapsibleMenu(item)
                data.selectedMenuRef = item
            }
        }
        // expose to template
        return {
            setItemSelected,
            ...toRefs(data),
        }
    },
})
</script>

<style scoped lang="scss">
.scoreList {
  display: flex;
  flex-flow: column nowrap;
  font-weight: 700;
  margin: $menuItemGutter 0;
  max-width: 37.5rem;
  &__items {
    margin-top: $menuItemGutter;
    filter: drop-shadow($submenuItemDropShadow);
    border-radius: $menuItemRadius;
  }
  &__item {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: $menuItemGutter;
    border-radius: $menuItemRadius;
    color: $menuItemColor;
    background-color: $menuItemBackgroundColor
;
    font-size: $menuItemFontSize;
    &--open {
      border-radius: 8px 8px 0 0;
      transition: border-radius 0.1s ease;
    }
    &--close {
      border-radius: 8px;
      transition: border-radius 1.35s ease;
    }
    &__icon {
      border-radius: $menuItemIconGutter;
      padding: $menuItemIconGutter;
      margin-left: 1em;
      color: $menuItemIconColor;
      background-color: $menuItemIconBackgroundColor;
    }
  }
}
.submenu {
  transition: all 3s ease;
  border-radius: 0 0 8px 8px;

  &__items {
    background-color: $menuItemBackgroundColor;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0 $menuItemIconGutter;
    &:first-child > .submenu__item {
      margin-top: 0;
    }
    &:last-child {
      border-radius: $submenuItemCorner;
      padding-bottom: $menuItemIconGutter;
    }
  }
  &__item {
    width: 100%;
    display: flex;
    justify-content: space-between;
    text-decoration: none;
    color: $menuItemColor;
    background-color: $submenuItemBackgroundColor;
    padding: $menuItemIconGutter $gutterSmall;
    margin: $submenuItemIconGutter;
    border-radius: $menuItemRadius;
    &__arrow {
      display: flex;
      align-items: center;
    }
  }
  &--hidden {
    display: none;
  }
}
</style>
