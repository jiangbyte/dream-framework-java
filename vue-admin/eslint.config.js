import antfu from '@antfu/eslint-config'
import eslintConfigPrettier from '@antfu/eslint-config-prettier'

// https://github.com/antfu/eslint-config
export default antfu(
  {
    stylistic: false,
    // 启用 Vue 相关规则
    vue: true,
    vue: {
      overrides: {
        'vue/no-unused-refs': 'off',
        'vue/no-reserved-component-names': 'off',
        'vue/component-definition-name-casing': 'off',
        // 关闭与 Prettier 冲突的 Vue 格式化规则
        'vue/html-closing-bracket-newline': 'off',
        'vue/multiline-html-element-content-newline': 'off',
        'vue/singleline-html-element-content-newline': 'off',
        'vue/first-attribute-linebreak': 'off',
        'vue/max-attributes-per-line': 'off',
        'vue/html-indent': 'off',
        'vue/html-self-closing': 'off'
      }
    },
    typescript: {
      overrides: {
        'perfectionist/sort-exports': 'off',
        'perfectionist/sort-imports': 'off',
        'ts/no-unused-expressions': ['error', { allowShortCircuit: true }]
      }
    },
    rules: {
      'no-console': 'off', // 全局禁用 no-console 规则
      // 关闭与 Prettier 冲突的规则
      'style/brace-style': 'off',
      'style/jsx-wrap-multilines': 'off',
      'style/object-curly-newline': 'off',
      'style/array-bracket-newline': 'off',
      'style/array-element-newline': 'off',
      'style/arrow-parens': 'off',
      'style/comma-dangle': 'off'
    }
  },
  // 将 Prettier 配置放在最后，覆盖冲突的规则
  eslintConfigPrettier
)
