import { createI18n } from 'vue-i18n'

import en from '@/assets/locales/en.json'
import fr from '@/assets/locales/fr.json'

type MessageSchema = typeof en;

const i18n = createI18n<[MessageSchema], 'fr' | 'en'>({
    legacy: false,
    locale: 'fr',
    fallbackLocale: 'en',
    messages: {
        fr,
        en,
    }
})
const getNavigatorLanguage  = ():string | undefined => {
    return i18n.global.availableLocales.find((lang) => navigator.language.startsWith(lang))
}
const updateLocale = (locale: string, i18nInstance: any) => {
    i18nInstance.global.locale.value = locale
}
export default i18n

export { i18n, getNavigatorLanguage, updateLocale }
