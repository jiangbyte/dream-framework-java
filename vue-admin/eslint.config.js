import antfu from '@antfu/eslint-config'

// https://github.com/antfu/eslint-config
export default antfu(
  {
    stylistic: true,
    // 启用 Vue 相关规则
    vue: {
      overrides: {
        'vue/no-unused-refs': 'off',
        'vue/no-reserved-component-names': 'off',
        'vue/component-definition-name-casing': 'off',
        'vue/max-attributes-per-line': ['error', {
          singleline: 3, // 单行最多允许 3 个属性（可调）
          multiline: 1, // 多行时每行最多 1 个属性
        }],
        'vue/html-closing-bracket-newline': ['error', {
          multiline: 'always',
          singleline: 'never',
        }],
      },
    },
    typescript: {
      overrides: {
        'perfectionist/sort-exports': 'off',
        'perfectionist/sort-imports': 'off',
        'ts/no-unused-expressions': ['error', { allowShortCircuit: true }],
      },
    },
    rules: {
      'no-console': 'off', // 全局禁用 no-console 规则
    },
  },
)
