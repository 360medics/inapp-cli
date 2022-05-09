import { ref } from "vue"

/**
 * Get the dynamic asset url no matter which env is running
 * 
 * @param path a path within the public folder
 * @example useDynamicAssets(`/img/illustration-article-${props.articleId}.jpg`)
 */
export default function useDynamicAssets (path: string){

    const basePath = window.location.pathname.indexOf("/index.html") > -1 ? window.location.pathname.replace("/index.html", "") : window.location.pathname
    const url = ref(`${window.location.origin}${basePath}${path}`)

    return url
}