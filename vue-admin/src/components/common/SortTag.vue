<script setup>
// defineProps({
//   value: {
//     type: Number,
//     required: true,
//   },
// })
defineProps({
  value: {
    type: null,
    required: true,
  },
})
</script>

<template>
  <t-tag theme="primary">
    {{ value }}
  </t-tag>
</template>
