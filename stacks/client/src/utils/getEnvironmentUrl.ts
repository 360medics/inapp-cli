export function getEnvironmentUrl() {
    const url = document.location.href

    if (url.includes('tools-beta')) {
        return 'https://beta.360medics.com'
    }
    if (url.includes('tools.360medics')) {
        return 'https://360medics.com'
    }

    return 'local'
}
