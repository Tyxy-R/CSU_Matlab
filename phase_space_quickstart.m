%% 相空间分析快速入门 / Quick Start Guide for Phase Space Analysis
% 这是一个简单的教程，展示如何将相空间分析应用于常见的MATLAB ODE问题
% This is a simple tutorial showing how to apply phase space analysis to common MATLAB ODE problems

clc; clear; close all;

%% 基础示例：二阶ODE转换为相空间 / Basic Example: Second-order ODE to Phase Space
% 
% 问题：求解二阶微分方程并绘制相空间图
% Problem: Solve a second-order differential equation and plot phase space
%
% 方程: d²y/dt² + 0.3*dy/dt + y = 0
% 初始条件: y(0) = 2, dy/dt(0) = 0

fprintf('=======================================================\n');
fprintf('  相空间分析快速入门 / Quick Start Guide\n');
fprintf('=======================================================\n\n');

%% 步骤 1: 定义微分方程 / Step 1: Define the differential equation

% 将二阶方程转换为一阶方程组：
% Convert second-order equation to first-order system:
% 令 y1 = y, y2 = dy/dt
% Let y1 = y, y2 = dy/dt
% 则: dy1/dt = y2
%     dy2/dt = -y1 - 0.3*y2

odefun = @(t, y) [y(2); -y(1) - 0.3*y(2)];

%% 步骤 2: 使用 ode45 求解 / Step 2: Solve using ode45

tspan = [0, 30];  % 时间范围 / time span
y0 = [2; 0];      % 初始条件 [y(0), dy/dt(0)]

[t, y] = ode45(odefun, tspan, y0);

%% 步骤 3: 绘制时间序列图 / Step 3: Plot time series

figure('Position', [100, 100, 1200, 400]);

subplot(1, 3, 1);
plot(t, y(:,1), 'b-', 'LineWidth', 1.5);
grid on;
xlabel('时间 t / Time t', 'FontSize', 11);
ylabel('位移 y / Position y', 'FontSize', 11);
title('时间-位移图 / Time-Position Plot', 'FontSize', 12, 'FontWeight', 'bold');

subplot(1, 3, 2);
plot(t, y(:,2), 'r-', 'LineWidth', 1.5);
grid on;
xlabel('时间 t / Time t', 'FontSize', 11);
ylabel('速度 dy/dt / Velocity dy/dt', 'FontSize', 11);
title('时间-速度图 / Time-Velocity Plot', 'FontSize', 12, 'FontWeight', 'bold');

%% 步骤 4: 绘制相空间图 / Step 4: Plot phase space

subplot(1, 3, 3);
plot(y(:,1), y(:,2), 'k-', 'LineWidth', 2);
hold on;
plot(y(1,1), y(1,2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g', 'LineWidth', 2);
plot(y(end,1), y(end,2), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r', 'LineWidth', 2);
plot(0, 0, 'k*', 'MarkerSize', 12, 'LineWidth', 2);
grid on;
xlabel('位移 y / Position y', 'FontSize', 11);
ylabel('速度 dy/dt / Velocity dy/dt', 'FontSize', 11);
title('相空间图 / Phase Space Plot', 'FontSize', 12, 'FontWeight', 'bold');
legend('轨迹 / Trajectory', '起点 / Start', '终点 / End', '平衡点 / Equilibrium', ...
       'Location', 'best', 'FontSize', 9);

fprintf('✓ 基础示例完成 / Basic example completed\n\n');

%% 使用 phase_space_analysis 函数的高级示例
%  Advanced Example Using phase_space_analysis Function

fprintf('-------------------------------------------------------\n');
fprintf('使用 phase_space_analysis 函数 / Using phase_space_analysis function\n');
fprintf('-------------------------------------------------------\n\n');

% 定义多个初始条件 / Define multiple initial conditions
initial_conditions = [
    2.0,  0.0;
    1.5,  0.5;
    1.0,  1.0;
   -1.0, -1.0;
   -2.0,  0.0;
];

% 调用 phase_space_analysis 函数
% Call phase_space_analysis function
figure('Position', [100, 100, 800, 600]);
phase_space_analysis(odefun, [-3, 3], [-2, 2], ...
    'InitialConditions', initial_conditions, ...
    'TimeSpan', [0, 30], ...
    'VectorField', true, ...
    'GridDensity', 20, ...
    'Nullclines', true, ...
    'XLabel', '位移 y / Position y', ...
    'YLabel', '速度 dy/dt / Velocity dy/dt', ...
    'Title', '阻尼振荡器完整相空间分析 / Complete Phase Space Analysis of Damped Oscillator');

fprintf('✓ 高级示例完成 / Advanced example completed\n\n');

%% 实际应用：分析考试中的ODE问题
%  Practical Application: Analyze ODE problems from exams

fprintf('-------------------------------------------------------\n');
fprintf('实际应用示例 / Practical Application Example\n');
fprintf('-------------------------------------------------------\n\n');

% 类似于 2023 年考试中的 ODE 问题
% Similar to ODE problems from 2023 exam
% 方程: exp(t)*d²y/dt² - dy/dt + 2y = 0

% 重新整理为标准形式: d²y/dt² = (dy/dt - 2y)/exp(t)
% Rearrange to standard form: d²y/dt² = (dy/dt - 2y)/exp(t)

exam_odefun = @(t, y) [y(2); (y(2) - 2*y(1))/exp(t)];

% 初始条件 / Initial conditions
ic_exam = [0, 1];

% 求解 / Solve
[t_exam, y_exam] = ode45(exam_odefun, [0, 5], ic_exam);

% 绘制结果 / Plot results
figure('Position', [100, 100, 1200, 400]);

subplot(1, 2, 1);
plot(t_exam, y_exam(:,1), 'b-', 'LineWidth', 2);
grid on;
xlabel('时间 t / Time t', 'FontSize', 11);
ylabel('y(t)', 'FontSize', 11);
title('解的时间演化 / Solution Time Evolution', 'FontSize', 12, 'FontWeight', 'bold');

subplot(1, 2, 2);
plot(y_exam(:,1), y_exam(:,2), 'b-', 'LineWidth', 2);
hold on;
plot(y_exam(1,1), y_exam(1,2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
plot(y_exam(end,1), y_exam(end,2), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
grid on;
xlabel('y', 'FontSize', 11);
ylabel('dy/dt', 'FontSize', 11);
title('相空间轨迹 / Phase Space Trajectory', 'FontSize', 12, 'FontWeight', 'bold');
legend('轨迹', '起点 y(0)=0, dy/dt(0)=1', '终点', 'Location', 'best');

fprintf('✓ 实际应用示例完成 / Practical application example completed\n\n');

%% 总结 / Summary
fprintf('=======================================================\n');
fprintf('  总结 / Summary\n');
fprintf('=======================================================\n');
fprintf('1. 相空间分析可以直观地显示系统的动力学行为\n');
fprintf('   Phase space analysis provides intuitive visualization of system dynamics\n\n');
fprintf('2. 轨迹收敛到原点表示系统是稳定的\n');
fprintf('   Trajectories converging to origin indicate system stability\n\n');
fprintf('3. 闭合轨迹表示周期性振荡\n');
fprintf('   Closed trajectories indicate periodic oscillations\n\n');
fprintf('4. 矢量场显示系统在每个点的演化方向\n');
fprintf('   Vector field shows evolution direction at each point\n\n');
fprintf('5. 零倾线显示状态变量不变的位置\n');
fprintf('   Nullclines show where state variables don''t change\n\n');
fprintf('=======================================================\n\n');

fprintf('教程完成！可以查看 phase_space_examples.m 获取更多示例。\n');
fprintf('Tutorial completed! See phase_space_examples.m for more examples.\n');
