module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: ['xo', 'prettier', 'plugin:prettier/recommended'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 13,
    sourceType: 'module',
  },
  plugins: ['@typescript-eslint'],
  rules: {
    'new-cap': 'off',
  },
};
