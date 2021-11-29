module.exports = {
    root: true,
    env: {
        node: true,
    },
    extends: [
        'plugin:vue/vue3-essential',
        'eslint:recommended',
        '@vue/typescript/recommended',
        // do not inclue airbnb rules, this break import/resolver
        // as airbnb use react style import and not Vue style import
    ],
    parserOptions: {
        ecmaVersion: 2020,
    },
    rules: {
        // taken from 360-medics-base
        '@typescript-eslint/ban-ts-comment': ['error', { 'ts-ignore': 'allow-with-description' }],
        '@typescript-eslint/no-shadow': 'error',
        '@typescript-eslint/no-unused-vars': ['error', { 'argsIgnorePattern': 'next' }],
        'arrow-body-style': 'off',
        'class-methods-use-this': 'off',
        'import/prefer-default-export': 'off',
        indent: ['error', 4],
        'lines-between-class-members': ['error', 'always', { 'exceptAfterSingleLine': true }],
        'no-plusplus': ['error', { 'allowForLoopAfterthoughts': true }],
        'no-shadow': 'off',
        'no-unused-vars': ['error', { 'argsIgnorePattern': 'next' }],
        'no-use-before-define': ['error', { 'functions': false }],
        'object-curly-newline': ['error', { 'ImportDeclaration': 'never' }],
        semi: ['error', 'never', { 'beforeStatementContinuationChars': 'always'}],
        // taken from usual 360 vue projects
        'no-console': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
        'no-debugger': process.env.NODE_ENV === 'production' ? 'warn' : 'off',
        'max-len': 'off',
        'vue/max-attributes-per-line': 'off',
        'vue/html-indent': [
            'error',
            4,
            {
                attribute: 1,
                baseIndent: 1,
                closeBracket: 0,
                alignAttributesVertically: true,
                ignores: [],
            },
        ],
        'no-param-reassign': [
            'error',
            {
                props: true,
                ignorePropertyModificationsFor: [
                    'state', // for vuex state
                ],
            },
        ],
    },
    settings: {
    // taken from usual 360 vue projects
    // this does nothing because it's included in vue3 eslint plugin
    // 'import/resolver': {
    //   alias: {
    //     map: [['@', './src']],
    //     extensions: ['.vue', '.json', '.ts', '.js'],
    //   },
    // },
    },
}
