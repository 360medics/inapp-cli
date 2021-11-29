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
};
