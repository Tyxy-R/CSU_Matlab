%% 相空间分析示例 / Phase Space Analysis Examples
% 此脚本演示如何使用 phase_space_analysis 函数分析不同的动力学系统
% This script demonstrates how to use the phase_space_analysis function
% to analyze different dynamical systems

%% 示例 1: 简谐振荡器 (线性系统) / Example 1: Harmonic Oscillator (Linear System)
% 方程: d²y/dt² + y = 0 或 dy1/dt = y2, dy2/dt = -y1
% Equation: d²y/dt² + y = 0 or dy1/dt = y2, dy2/dt = -y1

clc; clear; close all;

fprintf('示例 1: 简谐振荡器 / Example 1: Harmonic Oscillator\n');
fprintf('--------------------------------------------------\n\n');

% 定义微分方程 / Define ODE
harmonic_osc = @(t, y) [y(2); -y(1)];

% 初始条件 / Initial conditions
ic1 = [1, 0; 0, 1; 2, 0; 0, 2; 1.5, 1.5];

% 绘制相空间图 / Plot phase space
figure('Name', '简谐振荡器相空间 / Harmonic Oscillator Phase Space');
phase_space_analysis(harmonic_osc, [-3, 3], [-3, 3], ...
    'InitialConditions', ic1, ...
    'TimeSpan', [0, 20], ...
    'VectorField', true, ...
    'GridDensity', 20, ...
    'XLabel', '位移 y / Position y', ...
    'YLabel', '速度 dy/dt / Velocity dy/dt', ...
    'Title', '简谐振荡器相空间图 / Harmonic Oscillator Phase Portrait');

fprintf('简谐振荡器是一个保守系统，轨迹为闭合椭圆。\n');
fprintf('The harmonic oscillator is a conservative system with closed elliptical trajectories.\n\n');

%% 示例 2: 阻尼振荡器 / Example 2: Damped Oscillator
% 方程: d²y/dt² + 0.5*dy/dt + y = 0
% Equation: d²y/dt² + 0.5*dy/dt + y = 0

fprintf('示例 2: 阻尼振荡器 / Example 2: Damped Oscillator\n');
fprintf('--------------------------------------------------\n\n');

% 阻尼系数 / Damping coefficient
damping = 0.5;

% 定义微分方程 / Define ODE
damped_osc = @(t, y) [y(2); -y(1) - damping*y(2)];

% 初始条件 / Initial conditions
ic2 = [2, 0; 0, 2; -2, 0; 0, -2; 1.5, 1.5; -1.5, -1.5];

% 绘制相空间图 / Plot phase space
figure('Name', '阻尼振荡器相空间 / Damped Oscillator Phase Space');
phase_space_analysis(damped_osc, [-3, 3], [-3, 3], ...
    'InitialConditions', ic2, ...
    'TimeSpan', [0, 20], ...
    'VectorField', true, ...
    'GridDensity', 20, ...
    'Nullclines', true, ...
    'XLabel', '位移 y / Position y', ...
    'YLabel', '速度 dy/dt / Velocity dy/dt', ...
    'Title', '阻尼振荡器相空间图 / Damped Oscillator Phase Portrait');

fprintf('阻尼振荡器的轨迹螺旋收敛到原点（稳定平衡点）。\n');
fprintf('Trajectories of the damped oscillator spiral into the origin (stable equilibrium).\n\n');

%% 示例 3: Van der Pol 振荡器 / Example 3: Van der Pol Oscillator
% 方程: d²y/dt² - μ(1-y²)dy/dt + y = 0
% Equation: d²y/dt² - μ(1-y²)dy/dt + y = 0

fprintf('示例 3: Van der Pol 振荡器 / Example 3: Van der Pol Oscillator\n');
fprintf('---------------------------------------------------------------\n\n');

% 非线性参数 / Nonlinearity parameter
mu = 1.0;

% 定义微分方程 / Define ODE
vanderpol = @(t, y) [y(2); mu*(1 - y(1)^2)*y(2) - y(1)];

% 初始条件 / Initial conditions
ic3 = [0.1, 0.1; 0.5, 0; 1.5, 0; 2.5, 0; 0.1, 1];

% 绘制相空间图 / Plot phase space
figure('Name', 'Van der Pol振荡器相空间 / Van der Pol Oscillator Phase Space');
phase_space_analysis(vanderpol, [-3, 3], [-4, 4], ...
    'InitialConditions', ic3, ...
    'TimeSpan', [0, 30], ...
    'VectorField', true, ...
    'GridDensity', 20, ...
    'Nullclines', true, ...
    'XLabel', 'y', ...
    'YLabel', 'dy/dt', ...
    'Title', sprintf('Van der Pol振荡器 (μ=%.1f) / Van der Pol Oscillator (μ=%.1f)', mu, mu));

fprintf('Van der Pol振荡器具有极限环，所有轨迹都收敛到同一个周期轨道。\n');
fprintf('The Van der Pol oscillator has a limit cycle; all trajectories converge to the same periodic orbit.\n\n');

%% 示例 4: 单摆 / Example 4: Pendulum
% 方程: d²θ/dt² + (g/L)sin(θ) = 0
% Equation: d²θ/dt² + (g/L)sin(θ) = 0

fprintf('示例 4: 单摆 / Example 4: Pendulum\n');
fprintf('-----------------------------------\n\n');

% 参数 / Parameters
g = 9.81;  % 重力加速度 / gravitational acceleration (m/s²)
L = 1.0;   % 摆长 / pendulum length (m)

% 定义微分方程 / Define ODE
pendulum = @(t, y) [y(2); -(g/L)*sin(y(1))];

% 初始条件（不同能量级别） / Initial conditions (different energy levels)
ic4 = [0.5, 0; 1.0, 0; 2.0, 0; 3.0, 0; 0.1, 1; 0.1, 3];

% 绘制相空间图 / Plot phase space
figure('Name', '单摆相空间 / Pendulum Phase Space');
phase_space_analysis(pendulum, [-pi, pi], [-5, 5], ...
    'InitialConditions', ic4, ...
    'TimeSpan', [0, 10], ...
    'VectorField', true, ...
    'GridDensity', 20, ...
    'Nullclines', true, ...
    'XLabel', '角度 θ (rad) / Angle θ (rad)', ...
    'YLabel', '角速度 dθ/dt (rad/s) / Angular velocity dθ/dt (rad/s)', ...
    'Title', '单摆相空间图 / Pendulum Phase Portrait');

fprintf('单摆的相空间显示周期振荡（闭合曲线）和旋转运动（开放曲线）。\n');
fprintf('The pendulum phase space shows periodic oscillations (closed curves) and rotational motion (open curves).\n\n');

%% 示例 5: Lotka-Volterra (捕食者-猎物模型) / Example 5: Lotka-Volterra (Predator-Prey Model)
% 方程: dx/dt = αx - βxy, dy/dt = δxy - γy
% Equation: dx/dt = αx - βxy, dy/dt = δxy - γy

fprintf('示例 5: Lotka-Volterra 捕食者-猎物模型 / Example 5: Lotka-Volterra Predator-Prey Model\n');
fprintf('-------------------------------------------------------------------------------------\n\n');

% 参数 / Parameters
alpha = 1.0;   % 猎物增长率 / prey growth rate
beta = 0.5;    % 捕食率 / predation rate
gamma = 0.5;   % 捕食者死亡率 / predator death rate
delta = 0.2;   % 捕食效率 / predation efficiency

% 定义微分方程 / Define ODE
lotka_volterra = @(t, y) [alpha*y(1) - beta*y(1)*y(2); 
                          delta*y(1)*y(2) - gamma*y(2)];

% 初始条件 / Initial conditions
ic5 = [4, 2; 6, 3; 3, 4; 2, 1; 5, 5];

% 绘制相空间图 / Plot phase space
figure('Name', 'Lotka-Volterra相空间 / Lotka-Volterra Phase Space');
phase_space_analysis(lotka_volterra, [0, 8], [0, 8], ...
    'InitialConditions', ic5, ...
    'TimeSpan', [0, 30], ...
    'VectorField', true, ...
    'GridDensity', 15, ...
    'Nullclines', true, ...
    'XLabel', '猎物数量 x / Prey population x', ...
    'YLabel', '捕食者数量 y / Predator population y', ...
    'Title', 'Lotka-Volterra 相空间图 / Lotka-Volterra Phase Portrait');

fprintf('Lotka-Volterra模型显示周期性振荡，代表捕食者和猎物种群的周期性变化。\n');
fprintf('The Lotka-Volterra model shows periodic oscillations representing cyclic population changes.\n\n');

fprintf('\n所有示例完成！/ All examples completed!\n');
