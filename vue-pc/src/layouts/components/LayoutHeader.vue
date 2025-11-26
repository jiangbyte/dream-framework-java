<script lang="ts" setup>
import { useResponsive } from '@/composables'
import Desktop from './header/Desktop.vue'
import Mobile from './header/Mobile.vue'

const responsive = useResponsive()

// 根据你的断点定义响应式显示逻辑
const showFullNavigation = computed(() => responsive.showOnDesktop()) // ≥1024px 显示完整导航
// const showTabletNavigation = computed(() => responsive.showOnTablet()) // 640px-1023px 平板布局
// const showMobileNavigation = computed(() => responsive.showOnMobile()) // <640px 移动端布局
</script>

<template>
  <Desktop v-if="showFullNavigation" />
  <Mobile v-else />
</template>

<style scoped></style>
