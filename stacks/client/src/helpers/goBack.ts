import router from '@/router'

export default () => {
    return window.history.length > 2 ? router.go(-1) : router.push('/')
}
