<script lang="ts" setup>
</script>

<template>
  <div style="position: fixed; top: 0; z-index: 50; background-color: white;" class="h-56px w-full p-x-4 flex justify-between items-center border-b border-b-solid border-b-gray-200">
    <t-button shape="square" variant="text">
      <template #icon>
        <t-icon name="app" />
      </template>
    </t-button>
    <t-space align="center" class="w-full">
      <div class="flex items-center justify-center">
        <img src="/logo3.png" height="40px" style="object-fit: cover">
      </div>
    </t-space>
    <t-button shape="square" variant="text">
      <template #icon>
        <t-icon name="search" />
      </template>
    </t-button>
  </div>
</template>

<style scoped>

</style>
