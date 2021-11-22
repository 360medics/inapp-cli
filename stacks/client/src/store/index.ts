import { createStore, Commit, useStore } from 'vuex'
import { computed } from 'vue'
import axios from 'axios'
import type { Scores, Score } from '@/types'

export interface State {
    scores: Scores[]
    score: Score
}

export default createStore({
    state: {
        scores: [],
        score: {} as Score,
    },
    mutations: {
        SET_SCORES(state: State, scores: Scores[]) {
            state.scores = scores
        },
        SET_SCORE(state: State, score: Score) {
            state.score = score
        },
    },
    actions: {
        async getScores({ commit }: { commit: Commit }) :Promise<void> {
            try {
                const response = await axios.get('./dataTree.json')
                const data = await response.data.tree
                commit('SET_SCORES', data)
            } catch (error) {
                console.error('error', error) // TypeError: failed
            }
        },
        async getScore({ commit }: { commit: Commit }, payload : string) :Promise<void> {
            try {
                const response = await axios.get('./dataTree.json')
                let currentScore = []
                response.data.tree.forEach((category) => category.children.forEach((score) => {
                    if (score.slug === payload) { currentScore = score }
                    return currentScore
                }))
                commit('SET_SCORE', currentScore)
            } catch (error) {
                console.error(error) // TypeError: failed
            }
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
