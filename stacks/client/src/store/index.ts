import { createStore, Commit, useStore } from 'vuex'
import { LocationQueryValue } from 'vue-router'
import { computed } from 'vue'
import axios from 'axios'
import type { Scores, Score } from '@/types'
import { User } from '@/models'

export interface State {
    user: User | null
    scores: Scores[]
    score: Score
    selectedMenu: number
}

export default createStore({
    state: {
        user: new User(),
        scores: [],
        score: {} as Score,
        selectedMenu: 0,
    },
    getters: {
        isUserAuthenticated (state) {
            return state.user.uuid
        }
    },
    mutations: {
        SET_USER(state: State, user: User) {
            state.user = user
        },
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
        async authenticateUserFrom360({ commit }: { commit: Commit }, apiKey: LocationQueryValue | LocationQueryValue[]): Promise<void> {
            try {
                const headers = {
                    'Authorization': `Token 4SJxKlCP9ucc6pzVXVv9zurURQ96Um7d`,
                    'X-User-Api-Key': `${apiKey}`
                }

                const response = await axios.get(`https://dev.360medics.com/rest/profile`, { headers })
                const user = new User(response.data)
                commit('SET_USER', user)
            } catch (error) {
                console.error('error', error) // TypeError: failed
                window.location.href = `https://dev.360medics.com/login?lang=fr`
            }
        },
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

export const useUserStore = () => {
    const store = useStore<State>()
    return {
        user: computed(() => store.state.user),
        isUserAuthenticated: computed(() => store.getters.isUserAuthenticated),
        authenticateUserFrom360: (apiKey: LocationQueryValue | LocationQueryValue[]) => store.dispatch('authenticateUserFrom360', apiKey),
    }
}

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
