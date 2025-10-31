# 相空间解析模型 / Phase Space Analysis Model

## 概述 / Overview

**中文说明**：
这是一套用于分析动力学系统相空间行为的MATLAB工具。相空间分析是理解微分方程解的行为的重要方法，特别适用于二阶常微分方程组的可视化分析。本工具包提供了绘制相空间图、矢量场、零倾线和多条轨迹的完整功能。

**English Description**:
This is a MATLAB toolkit for analyzing the phase space behavior of dynamical systems. Phase space analysis is an important method for understanding the behavior of differential equation solutions, particularly useful for visualizing second-order ordinary differential equations. This toolkit provides complete functionality for plotting phase portraits, vector fields, nullclines, and multiple trajectories.

## 文件说明 / File Descriptions

### 核心函数 / Core Functions

1. **`phase_space_analysis.m`** - 主要的相空间分析函数
   - 绘制相空间图（相轨迹）
   - 显示矢量场（方向场）
   - 显示零倾线
   - 支持多个初始条件
   - 完全可定制的绘图选项

### 示例脚本 / Example Scripts

2. **`phase_space_quickstart.m`** - 快速入门教程
   - 基础示例：如何将二阶ODE转换为相空间表示
   - 展示时间序列图和相空间图的对比
   - 实际应用：分析类似考试中的ODE问题
   - 适合初学者

3. **`phase_space_examples.m`** - 完整示例集
   - 简谐振荡器（线性系统）
   - 阻尼振荡器
   - Van der Pol振荡器（非线性系统）
   - 单摆
   - Lotka-Volterra捕食者-猎物模型
   - 展示各种动力学行为

## 快速开始 / Quick Start

### 基本用法 / Basic Usage

```matlab
% 1. 定义你的ODE系统 / Define your ODE system
% 例如：阻尼振荡器 / Example: Damped oscillator
odefun = @(t, y) [y(2); -y(1) - 0.5*y(2)];

% 2. 调用相空间分析函数 / Call phase space analysis function
phase_space_analysis(odefun, [-3, 3], [-3, 3], ...
    'InitialConditions', [2, 0; 0, 2], ...
    'TimeSpan', [0, 20], ...
    'VectorField', true);
```

### 运行示例 / Run Examples

```matlab
% 运行快速入门教程 / Run quick start tutorial
phase_space_quickstart

% 运行完整示例集 / Run complete example set
phase_space_examples
```

## 详细用法 / Detailed Usage

### 函数签名 / Function Signature

```matlab
phase_space_analysis(odefun, xlim, ylim, Name, Value)
```

### 必需参数 / Required Parameters

- **`odefun`**: 函数句柄，定义微分方程 `dy/dt = f(t,y)`，其中 `y = [y1; y2]`
  - Function handle defining ODE `dy/dt = f(t,y)` where `y = [y1; y2]`

- **`xlim`**: x轴范围 `[xmin, xmax]`
  - Range for x-axis `[xmin, xmax]`

- **`ylim`**: y轴范围 `[ymin, ymax]`
  - Range for y-axis `[ymin, ymax]`

### 可选参数 / Optional Parameters

| 参数名 / Parameter | 类型 / Type | 默认值 / Default | 说明 / Description |
|-------------------|-------------|-----------------|-------------------|
| `InitialConditions` | 矩阵 / Matrix | `[]` | 初始条件，每行一个 `[x0, y0]` / Initial conditions, each row `[x0, y0]` |
| `TimeSpan` | 向量 / Vector | `[0, 10]` | 时间范围 `[t0, tf]` / Time span `[t0, tf]` |
| `VectorField` | 逻辑值 / Logical | `true` | 是否显示矢量场 / Whether to show vector field |
| `GridDensity` | 数值 / Numeric | `20` | 矢量场网格密度 / Vector field grid density |
| `Nullclines` | 逻辑值 / Logical | `false` | 是否显示零倾线 / Whether to show nullclines |
| `XLabel` | 字符串 / String | `'y_1'` | x轴标签 / x-axis label |
| `YLabel` | 字符串 / String | `'y_2'` | y轴标签 / y-axis label |
| `Title` | 字符串 / String | `'相空间图 / Phase Space Plot'` | 图标题 / Figure title |

## 应用示例 / Application Examples

### 示例 1: 简谐振荡器 / Example 1: Harmonic Oscillator

```matlab
% 无阻尼振荡器：d²y/dt² + y = 0
% Undamped oscillator: d²y/dt² + y = 0
odefun = @(t, y) [y(2); -y(1)];

phase_space_analysis(odefun, [-3, 3], [-3, 3], ...
    'InitialConditions', [1, 0; 2, 0; 0, 1], ...
    'VectorField', true, ...
    'Title', '简谐振荡器 / Harmonic Oscillator');
```

**特征 / Characteristics**: 闭合的椭圆轨迹，表示周期性振荡 / Closed elliptical trajectories indicating periodic oscillations

### 示例 2: Van der Pol 振荡器 / Example 2: Van der Pol Oscillator

```matlab
% Van der Pol方程 / Van der Pol equation
mu = 1.0;
odefun = @(t, y) [y(2); mu*(1 - y(1)^2)*y(2) - y(1)];

phase_space_analysis(odefun, [-3, 3], [-4, 4], ...
    'InitialConditions', [0.1, 0.1; 2, 2], ...
    'TimeSpan', [0, 30], ...
    'VectorField', true, ...
    'Nullclines', true, ...
    'Title', 'Van der Pol振荡器 / Van der Pol Oscillator');
```

**特征 / Characteristics**: 极限环，所有轨迹收敛到同一周期轨道 / Limit cycle where all trajectories converge to the same periodic orbit

### 示例 3: 捕食者-猎物模型 / Example 3: Predator-Prey Model

```matlab
% Lotka-Volterra方程 / Lotka-Volterra equations
alpha = 1.0; beta = 0.5; gamma = 0.5; delta = 0.2;
odefun = @(t, y) [alpha*y(1) - beta*y(1)*y(2); 
                  delta*y(1)*y(2) - gamma*y(2)];

phase_space_analysis(odefun, [0, 8], [0, 8], ...
    'InitialConditions', [4, 2; 6, 3], ...
    'TimeSpan', [0, 30], ...
    'VectorField', true, ...
    'Nullclines', true, ...
    'Title', 'Lotka-Volterra模型 / Lotka-Volterra Model');
```

**特征 / Characteristics**: 闭合轨迹表示种群数量的周期性振荡 / Closed trajectories showing periodic population oscillations

## 理解相空间图 / Understanding Phase Space Plots

### 轨迹分析 / Trajectory Analysis

- **闭合轨迹 / Closed trajectories**: 周期性行为 / Periodic behavior
- **螺旋向内 / Spiraling inward**: 稳定的平衡点 / Stable equilibrium
- **螺旋向外 / Spiraling outward**: 不稳定的平衡点 / Unstable equilibrium
- **直线 / Straight lines**: 特征方向 / Eigendirections

### 零倾线 / Nullclines

- **x-零倾线（红色虚线）/ x-nullcline (red dashed)**: 满足 dy₁/dt = 0 的点 / Points where dy₁/dt = 0
- **y-零倾线（蓝色虚线）/ y-nullcline (blue dashed)**: 满足 dy₂/dt = 0 的点 / Points where dy₂/dt = 0
- **交点 / Intersections**: 平衡点（不动点）/ Equilibrium points (fixed points)

### 矢量场 / Vector Field

- **箭头方向 / Arrow direction**: 系统演化方向 / System evolution direction
- **箭头长度 / Arrow length**: 已归一化以便显示 / Normalized for display
- **灰色箭头 / Gray arrows**: 背景矢量场 / Background vector field

## 与现有代码集成 / Integration with Existing Code

本工具可以轻松集成到现有的MATLAB作业或考试代码中：

```matlab
% 现有代码 / Existing code
tspan = [0, 5];
y0 = [0, 1];
[t, y] = ode45(@odefun, tspan, y0);
plot(t, y(:,1));

% 添加相空间分析 / Add phase space analysis
figure;
phase_space_analysis(@odefun, [-2, 2], [-2, 2], ...
    'InitialConditions', y0', ...
    'TimeSpan', tspan);
```

## 技术要求 / Technical Requirements

- MATLAB R2016b 或更高版本 / MATLAB R2016b or later
- 无需额外工具箱 / No additional toolboxes required
- 使用的核心函数 / Core functions used:
  - `ode45` - 数值ODE求解器 / Numerical ODE solver
  - `quiver` - 矢量场绘图 / Vector field plotting
  - `contour` - 等高线绘图（用于零倾线）/ Contour plotting (for nullclines)

## 常见问题 / FAQ

### Q1: 如何分析高阶（n>2）ODE系统？
**A**: 本工具专为2D相空间设计。对于高阶系统，可以选择两个变量绘制2D投影。

### Q2: 如何找到平衡点？
**A**: 设置 `Nullclines` 为 `true`，零倾线的交点即为平衡点。

### Q3: 如何判断平衡点的稳定性？
**A**: 观察轨迹行为：
- 向平衡点收敛 → 稳定
- 远离平衡点发散 → 不稳定
- 围绕平衡点闭合 → 中心（中性稳定）

### Q4: 矢量场太密集怎么办？
**A**: 减小 `GridDensity` 参数值，例如 `'GridDensity', 15`。

## 参考资料 / References

1. Strogatz, S. H. (2015). *Nonlinear Dynamics and Chaos*. Westview Press.
2. Hirsch, M. W., Smale, S., & Devaney, R. L. (2013). *Differential Equations, Dynamical Systems, and an Introduction to Chaos*. Academic Press.
3. MATLAB Documentation: [Ordinary Differential Equations](https://www.mathworks.com/help/matlab/ordinary-differential-equations.html)

## 许可证 / License

本代码遵循 MIT 许可证，可自由用于教育和研究目的。
This code is provided under the MIT License and is free to use for educational and research purposes.

## 作者 / Author

CSU MATLAB 课程项目 / CSU MATLAB Course Project

## 更新日志 / Changelog

### Version 1.0 (2025-10-31)
- 初始版本发布 / Initial release
- 核心相空间分析功能 / Core phase space analysis functionality
- 包含5个经典示例 / Includes 5 classical examples
- 完整的中英文双语文档 / Complete bilingual documentation (Chinese/English)
