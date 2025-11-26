<script setup lang="ts">
import LayoutHeader from './components/LayoutHeader.vue'
import LayoutContent from './components/LayoutContent.vue'
import LayoutFooter from './components/LayoutFooter.vue'
</script>

<template>
  <t-layout class="layout-main">
    <t-header class="layout-header">
      <LayoutHeader />
    </t-header>
    <t-content class="layout-content">
      <LayoutContent />
    </t-content>
    <t-footer>
      <LayoutFooter />
    </t-footer>
  </t-layout>
</template>

<style scoped>
  .layout-main {
    flex: 1;
    min-width: 0; /* 防止flex项目溢出 */
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  .layout-header {
    flex-shrink: 0;
  }
</style>
