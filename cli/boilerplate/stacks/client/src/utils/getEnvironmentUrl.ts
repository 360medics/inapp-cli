export function getEnvironmentUrl() {
    const url = document.location.href
    //@TODO: use var env
    if (url.includes('tools-beta')) {
        return `${process.env.VUE_APP_BETA_360}`
    }
    if (url.includes('tools.360medics')) {
        return `${process.env.VUE_APP_PROD_360}`
    }

    return 'local'
}
