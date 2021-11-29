module.exports = {
    root: true,
    env: {
        node: true,
    },
    extends: [
        'plugin:vue/vue3-essential',
        'eslint:recommended',
        '@vue/typescript/recommended',
        '360medics-base',
        'plugin:vue/recommended',
    ],
    parserOptions: {
        ecmaVersion: 2020,
    },
    rules: {
        'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
        'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
        'max-len': 'off',
        'vue/max-attributes-per-line': 'off',
        'vue/html-indent': ['error', 4, {
            attribute: 1,
            baseIndent: 1,
            closeBracket: 0,
            alignAttributesVertically: true,
            ignores: [],
        }],
        'no-param-reassign': ['error', { props: true,
            ignorePropertyModificationsFor: [
                'state', // for vuex state
            ] }],
    },
    settings: {
        'import/resolver': {
            alias: {
                map: [
                    ['@', './src'],
                ],
                extensions: ['.vue', '.json', '.ts', '.js'],
            },
        },
    },
}
