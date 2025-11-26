// 响应式窗口大小类型
export interface WindowSize {
  width: number
  height: number
}

// 断点配置（根据你的CSS配置）
export interface Breakpoints {
  sm: number // 640px
  md: number // 768px
  lg: number // 1024px
  xl: number // 1280px
  xxl: number // 1536px
}

// 完全匹配你的CSS断点
export const defaultBreakpoints: Breakpoints = {
  sm: 640,
  md: 768,
  lg: 1024,
  xl: 1280,
  xxl: 1536,
}

// 断点状态类型
export interface BreakpointState {
  isSm: boolean // ≥ 640px
  isMd: boolean // ≥ 768px
  isLg: boolean // ≥ 1024px
  isXl: boolean // ≥ 1280px
  isXxl: boolean // ≥ 1536px

  // 当前激活的断点名称
  currentBreakpoint: keyof Breakpoints | 'xs'

  // 窗口尺寸
  windowSize: WindowSize
}

/**
 * 响应式窗口大小检测 Hook
 * @param customBreakpoints 自定义断点配置
 * @returns 断点状态和窗口尺寸
 */
export function useWindowSize(customBreakpoints?: Partial<Breakpoints>) {
  const breakpoints = { ...defaultBreakpoints, ...customBreakpoints }

  const windowSize = ref<WindowSize>({
    width: window.innerWidth,
    height: window.innerHeight,
  })

  const breakpointState = ref<BreakpointState>({
    isSm: false,
    isMd: false,
    isLg: false,
    isXl: false,
    isXxl: false,
    currentBreakpoint: 'xs',
    windowSize: windowSize.value,
  })
  // 更新断点状态
  const updateBreakpointState = () => {
    const { width } = windowSize.value

    // 计算当前断点
    let current: BreakpointState['currentBreakpoint'] = 'xs'

    if (width >= breakpoints.xxl) {
      current = 'xxl'
    }
    else if (width >= breakpoints.xl) {
      current = 'xl'
    }
    else if (width >= breakpoints.lg) {
      current = 'lg'
    }
    else if (width >= breakpoints.md) {
      current = 'md'
    }
    else if (width >= breakpoints.sm) {
      current = 'sm'
    }
    else {
      current = 'xs'
    }

    breakpointState.value = {
      isSm:
        current === 'sm'
        || current === 'md'
        || current === 'lg'
        || current === 'xl'
        || current === 'xxl',
      isMd: current === 'md' || current === 'lg' || current === 'xl' || current === 'xxl',
      isLg: current === 'lg' || current === 'xl' || current === 'xxl',
      isXl: current === 'xl' || current === 'xxl',
      isXxl: current === 'xxl',
      currentBreakpoint: current,
      windowSize: windowSize.value,
    }
  }

  // 更新窗口尺寸
  const updateWindowSize = () => {
    windowSize.value = {
      width: window.innerWidth,
      height: window.innerHeight,
    }

    updateBreakpointState()
  }

  // 监听窗口大小变化
  const handleResize = () => {
    updateWindowSize()
  }

  onMounted(() => {
    updateBreakpointState()
    window.addEventListener('resize', handleResize)
  })

  onUnmounted(() => {
    window.removeEventListener('resize', handleResize)
  })

  return {
    windowSize,
    breakpointState,

    // 便捷方法
    isMobile: () => breakpointState.value.currentBreakpoint === 'xs',
    isTablet: () => breakpointState.value.currentBreakpoint === 'sm',
    isDesktop: () =>
      breakpointState.value.currentBreakpoint === 'md'
      || breakpointState.value.currentBreakpoint === 'lg'
      || breakpointState.value.currentBreakpoint === 'xl'
      || breakpointState.value.currentBreakpoint === 'xxl',
    isLargeDesktop: () =>
      breakpointState.value.currentBreakpoint === 'lg'
      || breakpointState.value.currentBreakpoint === 'xl'
      || breakpointState.value.currentBreakpoint === 'xxl',

    // 响应式显示方法
    showOn: (
      breakpoint: BreakpointState['currentBreakpoint'] | BreakpointState['currentBreakpoint'][],
    ) => {
      const breakpointsArray = Array.isArray(breakpoint) ? breakpoint : [breakpoint]
      return breakpointsArray.includes(breakpointState.value.currentBreakpoint)
    },

    hideOn: (
      breakpoint: BreakpointState['currentBreakpoint'] | BreakpointState['currentBreakpoint'][],
    ) => {
      const breakpointsArray = Array.isArray(breakpoint) ? breakpoint : [breakpoint]
      return !breakpointsArray.includes(breakpointState.value.currentBreakpoint)
    },
  }
}
