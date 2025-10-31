%% 相空间分析集成示例 / Phase Space Analysis Integration Example
% 此脚本展示如何将相空间分析集成到现有的考试代码中
% This script demonstrates how to integrate phase space analysis into existing exam code
%
% 基于 2023 年和 2022 年考试中的 ODE 问题
% Based on ODE problems from 2023 and 2022 exams

clc; clear; close all;

fprintf('========================================================\n');
fprintf('相空间分析集成示例 / Integration Example\n');
fprintf('========================================================\n\n');

%% 示例 1: 2023年考试题型 / Example 1: 2023 Exam Type Problem
% 原始问题：exp(t)*d²y/dt² - dy/dt + 2y = 0
% 初始条件：y(0) = 0, dy/dt(0) = 1
% Original problem: exp(t)*d²y/dt² - dy/dt + 2y = 0
% Initial conditions: y(0) = 0, dy/dt(0) = 1

fprintf('示例 1: 类似2023年考试的ODE问题\n');
fprintf('Example 1: ODE problem similar to 2023 exam\n');
fprintf('----------------------------------------\n\n');

% 定义 ODE 函数（与考试中的 odefun 相同）
% Define ODE function (same as odefun in exam)
odefun_2023 = @(t, y) [y(2); (y(2) - 2*y(1))/exp(t)];

% 传统方法：只绘制时间序列 / Traditional method: only plot time series
tspan = [0, 5];
y0 = [0; 1];
[t, y] = ode45(odefun_2023, tspan, y0);

figure('Position', [100, 100, 1400, 500]);

subplot(1, 3, 1);
plot(t, y(:,1), 'b-', 'LineWidth', 2);
grid on;
xlabel('时间 t / Time t');
ylabel('y(t)');
title('传统时间序列图 / Traditional Time Series Plot');

% 新方法：添加相空间分析 / New method: add phase space analysis
subplot(1, 3, 2);
plot(y(:,1), y(:,2), 'b-', 'LineWidth', 2);
hold on;
plot(y(1,1), y(1,2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g');
plot(y(end,1), y(end,2), 'rs', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
grid on;
xlabel('y');
ylabel('dy/dt');
title('简单相空间图 / Simple Phase Space Plot');
legend('轨迹', '起点', '终点', 'Location', 'best');

% 高级方法：使用 phase_space_analysis 函数
% Advanced method: use phase_space_analysis function
subplot(1, 3, 3);

% 多个初始条件以显示系统行为 / Multiple initial conditions to show system behavior
ic_multiple = [0, 1; 0.5, 0; -0.5, 0; 0, 0.5];

% 由于 subplot 中不能创建新 figure，我们需要在当前 axes 中绘制
% Since we can't create new figure in subplot, we plot in current axes
axes_handle = gca;
hold(axes_handle, 'on');
grid(axes_handle, 'on');
box(axes_handle, 'on');

% 手动绘制矢量场和轨迹 / Manually plot vector field and trajectories
xlim_range = [-1, 1.5];
ylim_range = [-1, 1.5];

% 矢量场 / Vector field
[X, Y] = meshgrid(linspace(xlim_range(1), xlim_range(2), 15), ...
                  linspace(ylim_range(1), ylim_range(2), 15));
U = zeros(size(X));
V = zeros(size(Y));
for i = 1:numel(X)
    dy = odefun_2023(0, [X(i); Y(i)]);
    U(i) = dy(1);
    V(i) = dy(2);
end
magnitude = sqrt(U.^2 + V.^2);
U = U ./ (magnitude + eps);
V = V ./ (magnitude + eps);
quiver(axes_handle, X, Y, U, V, 0.5, 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);

% 轨迹 / Trajectories
colors = lines(size(ic_multiple, 1));
for i = 1:size(ic_multiple, 1)
    [~, y_traj] = ode45(odefun_2023, tspan, ic_multiple(i, :));
    plot(axes_handle, y_traj(:,1), y_traj(:,2), 'LineWidth', 1.5, 'Color', colors(i,:));
    plot(axes_handle, ic_multiple(i,1), ic_multiple(i,2), 'o', 'MarkerSize', 8, ...
        'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'k', 'LineWidth', 1);
end

axis(axes_handle, [xlim_range ylim_range]);
xlabel(axes_handle, 'y');
ylabel(axes_handle, 'dy/dt');
title(axes_handle, '完整相空间分析 / Complete Phase Space Analysis');

fprintf('✓ 示例 1 完成 / Example 1 completed\n\n');

%% 示例 2: 2022年考试题型 / Example 2: 2022 Exam Type Problem
% 原始问题：d²y/dt² + t*dy/dt + y = 0
% 初始条件：y(0) = 0, dy/dt(0) = 1
% Original problem: d²y/dt² + t*dy/dt + y = 0
% Initial conditions: y(0) = 0, dy/dt(0) = 1

fprintf('示例 2: 类似2022年考试的ODE问题\n');
fprintf('Example 2: ODE problem similar to 2022 exam\n');
fprintf('----------------------------------------\n\n');

% 定义 ODE 函数 / Define ODE function
odefun_2022 = @(t, y) [y(2); -y(1) - t*y(2)];

% 使用完整的 phase_space_analysis 函数
% Use the complete phase_space_analysis function
figure('Position', [100, 100, 800, 600]);
phase_space_analysis(odefun_2022, [-2, 2], [-2, 2], ...
    'InitialConditions', [0, 1; 1, 0; -1, 0; 0.5, 0.5], ...
    'TimeSpan', [0, 5], ...
    'VectorField', true, ...
    'GridDensity', 20, ...
    'Nullclines', false, ...
    'XLabel', 'y', ...
    'YLabel', 'dy/dt', ...
    'Title', '2022年考试题型相空间分析 / 2022 Exam Problem Phase Space Analysis');

fprintf('✓ 示例 2 完成 / Example 2 completed\n\n');

%% 示例 3: 比较不同阻尼系数 / Example 3: Compare Different Damping Coefficients

fprintf('示例 3: 比较不同阻尼系数的效果\n');
fprintf('Example 3: Compare effects of different damping coefficients\n');
fprintf('----------------------------------------------------------\n\n');

% 三种不同的阻尼情况 / Three different damping cases
damping_cases = [0.1, 0.5, 2.0];  % 欠阻尼、临界阻尼附近、过阻尼 / Under, critical, over-damped
titles = {'欠阻尼 ζ=0.1 / Under-damped', ...
          '阻尼 ζ=0.5 / Damped', ...
          '过阻尼 ζ=2.0 / Over-damped'};

figure('Position', [100, 100, 1400, 400]);
for idx = 1:3
    zeta = damping_cases(idx);
    odefun_damped = @(t, y) [y(2); -y(1) - 2*zeta*y(2)];
    
    subplot(1, 3, idx);
    
    % 绘制相空间 / Plot phase space
    hold on;
    grid on;
    box on;
    
    % 矢量场 / Vector field
    [X, Y] = meshgrid(linspace(-3, 3, 15), linspace(-3, 3, 15));
    U = zeros(size(X));
    V = zeros(size(Y));
    for i = 1:numel(X)
        dy = odefun_damped(0, [X(i); Y(i)]);
        U(i) = dy(1);
        V(i) = dy(2);
    end
    magnitude = sqrt(U.^2 + V.^2);
    U = U ./ (magnitude + eps);
    V = V ./ (magnitude + eps);
    quiver(X, Y, U, V, 0.5, 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);
    
    % 多个初始条件 / Multiple initial conditions
    ic = [2, 0; 0, 2; -2, 0; 0, -2];
    colors = lines(size(ic, 1));
    for i = 1:size(ic, 1)
        [~, y_traj] = ode45(odefun_damped, [0, 20], ic(i, :));
        plot(y_traj(:,1), y_traj(:,2), 'LineWidth', 1.5, 'Color', colors(i,:));
        plot(ic(i,1), ic(i,2), 'o', 'MarkerSize', 6, ...
            'MarkerFaceColor', colors(i,:), 'MarkerEdgeColor', 'k');
    end
    
    axis([-3 3 -3 3]);
    xlabel('位移 y / Position y');
    ylabel('速度 dy/dt / Velocity dy/dt');
    title(titles{idx});
end

fprintf('✓ 示例 3 完成 / Example 3 completed\n\n');

%% 总结 / Summary

fprintf('========================================================\n');
fprintf('集成示例总结 / Integration Summary\n');
fprintf('========================================================\n\n');

fprintf('相空间分析的优势 / Advantages of Phase Space Analysis:\n');
fprintf('1. 直观显示系统的长期行为 / Intuitive visualization of long-term behavior\n');
fprintf('2. 容易识别稳定性和周期性 / Easy identification of stability and periodicity\n');
fprintf('3. 可以同时比较多个初始条件 / Can compare multiple initial conditions simultaneously\n');
fprintf('4. 揭示时间序列图中不明显的模式 / Reveals patterns not obvious in time series plots\n\n');

fprintf('如何在考试代码中使用 / How to use in exam code:\n');
fprintf('1. 定义 ODE 函数（已经在做）/ Define ODE function (already doing this)\n');
fprintf('2. 添加一行调用 phase_space_analysis / Add one line to call phase_space_analysis\n');
fprintf('3. 提供适当的坐标轴范围和初始条件 / Provide appropriate axis ranges and initial conditions\n\n');

fprintf('========================================================\n');
fprintf('所有集成示例完成！/ All integration examples completed!\n');
fprintf('========================================================\n');
