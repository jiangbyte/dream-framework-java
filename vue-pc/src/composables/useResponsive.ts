import { useWindowSize } from './useWindowSize'

/**
 * 响应式显示便捷 Hook
 */
export function useResponsive() {
  const { breakpointState, showOn, hideOn, isMobile, isTablet, isDesktop, isLargeDesktop }
    = useWindowSize()

  return {
    // 当前断点状态
    ...breakpointState,

    // 设备类型判断
    isMobile: isMobile(),
    isTablet: isTablet(),
    isDesktop: isDesktop(),
    isLargeDesktop: isLargeDesktop(),

    // 显示/隐藏控制
    showOn,
    hideOn,

    // 常用响应式模式（完全匹配你的CSS断点）
    showOnXs: () => showOn('xs'), // < 640px
    showOnSm: () => showOn('sm'), // ≥ 640px
    showOnMd: () => showOn('md'), // ≥ 768px
    showOnLg: () => showOn('lg'), // ≥ 1024px
    showOnXl: () => showOn('xl'), // ≥ 1280px
    showOnXxl: () => showOn('xxl'), // ≥ 1536px

    hideOnXs: () => hideOn('xs'),
    hideOnSm: () => hideOn('sm'),
    hideOnMd: () => hideOn('md'),
    hideOnLg: () => hideOn('lg'),
    hideOnXl: () => hideOn('xl'),
    hideOnXxl: () => hideOn('xxl'),

    // 组合断点
    showOnMobile: () => showOn('xs'), // < 640px
    showOnTablet: () => showOn(['sm', 'md']), // 640px - 1023px
    showOnDesktop: () => showOn(['lg', 'xl', 'xxl']), // ≥ 1024px

    hideOnMobile: () => hideOn('xs'),
    hideOnTablet: () => hideOn(['sm', 'md']),
    hideOnDesktop: () => hideOn(['lg', 'xl', 'xxl']),
  }
}
