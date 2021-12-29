import { createStore, Commit, useStore } from 'vuex'
import { computed } from 'vue'
import axios from 'axios'
import type { Scores, Score } from '@/types'

export interface State {
    scores: Scores[]
    score: Score
    selectedMenu: number
}

export default createStore({
    state: {
        scores: [],
        score: {} as Score,
        selectedMenu: 0,
    },
    mutations: {
        SET_SCORES(state: State, scores: Scores[]) {
            state.scores = scores
        },
        SET_SCORE(state: State, score: Score) {
            state.score = score
        },
        SET_COLLAPSIBLE(state, data) {
            state.selectedMenu = data
        },
    },
    actions: {
        async getScores({ commit }: { commit: Commit }): Promise<void> {
            try {
                const response = await axios.get('./dataTree.json')
                const data = await response.data.tree
                commit('SET_SCORES', data)
            } catch (error) {
                console.error('error', error) // TypeError: failed
            }
        },
        async getScore({ commit }: { commit: Commit }, payload: string): Promise<void> {
            try {
                const response = await axios.get('./dataTree.json')
                let currentScore = []
                response.data.tree.forEach((category) => category.children.forEach((score) => {
                    if (score.slug === payload) {
                        currentScore = score
                    }

                    return currentScore
                }))
                commit('SET_SCORE', currentScore)
            } catch (error) {
                console.error(error) // TypeError: failed
            }
        },
        updateCollapsibleMenu({ commit }: { commit: Commit }, itemSelected: number) {
            commit('SET_COLLAPSIBLE', itemSelected)
        },
    },
})

export const useScoresStore = () => {
    const store = useStore<State>()
    return {
        scores: computed(() => store.state.scores),
        getScores: () => store.dispatch('getScores'),
    }
}

export const useScoreStore = () => {
    const store = useStore<State>()
    return {
        score: computed(() => store.state.score),
        getScore: (slug: string | string[]) => store.dispatch('getScore', slug),
    }
}
export const useOpenMenuStore = () => {
    const store = useStore<State>()
    return {
        selectedMenu: computed(() => store.state.selectedMenu),
        updateCollapsibleMenu: (item) => store.dispatch('updateCollapsibleMenu', item),
    }
}