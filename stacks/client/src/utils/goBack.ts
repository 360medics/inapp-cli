import router from '@/router'

export default () => (window.history.length > 2 ? router.go(-1) : router.push('/'))
