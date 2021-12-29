module.exports = {
  env: {
    browser: true,
    es2021: true,
  },
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended', 'xo'],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaVersion: 13,
    sourceType: 'module',
  },
  plugins: ['@typescript-eslint'],
  rules: {
    'new-cap': 'off',
    'object-curly-spacing': ['error', 'always'],
    indent: ['error', 2],
    'capitalized-comments': 'off',
  },
};
