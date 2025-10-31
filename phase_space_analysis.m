function phase_space_analysis(odefun, xlim, ylim, varargin)
% PHASE_SPACE_ANALYSIS 相空间分析工具 / Phase Space Analysis Tool
%
% 用法 / Usage:
%   phase_space_analysis(odefun, xlim, ylim)
%   phase_space_analysis(odefun, xlim, ylim, Name, Value)
%
% 输入参数 / Input Parameters:
%   odefun - 函数句柄，定义微分方程 dy/dt = f(t,y)
%            Function handle defining the ODE dy/dt = f(t,y)
%            其中 y = [y1; y2] 是状态向量 / where y = [y1; y2] is the state vector
%   xlim   - x轴（第一个状态变量）范围 [xmin, xmax]
%            Range for x-axis (first state variable) [xmin, xmax]
%   ylim   - y轴（第二个状态变量）范围 [ymin, ymax]
%            Range for y-axis (second state variable) [ymin, ymax]
%
% 可选参数 (Name-Value对) / Optional Parameters (Name-Value pairs):
%   'InitialConditions' - 初始条件矩阵，每行一个初始点 [x0, y0]
%                         Matrix of initial conditions, each row is [x0, y0]
%                         默认值 / Default: empty (no trajectories)
%   'TimeSpan'         - 时间跨度 [t0, tf]
%                         Time span [t0, tf]
%                         默认值 / Default: [0, 10]
%   'VectorField'      - 是否显示矢量场 true/false
%                         Whether to show vector field true/false
%                         默认值 / Default: true
%   'GridDensity'      - 矢量场网格密度
%                         Vector field grid density
%                         默认值 / Default: 20
%   'Nullclines'       - 是否显示零倾线 true/false
%                         Whether to show nullclines true/false
%                         默认值 / Default: false
%   'XLabel'           - x轴标签 / x-axis label
%                         默认值 / Default: 'y_1'
%   'YLabel'           - y轴标签 / y-axis label
%                         默认值 / Default: 'y_2'
%   'Title'            - 图标题 / Figure title
%                         默认值 / Default: '相空间图 / Phase Space Plot'
%
% 示例 / Examples:
%   % 例1: 简单的线性系统 / Example 1: Simple linear system
%   f = @(t,y) [y(2); -y(1)];
%   phase_space_analysis(f, [-3,3], [-3,3], 'InitialConditions', [1,0; 0,1; 2,1]);
%
%   % 例2: Van der Pol振荡器 / Example 2: Van der Pol oscillator
%   mu = 1;
%   f = @(t,y) [y(2); mu*(1-y(1)^2)*y(2)-y(1)];
%   phase_space_analysis(f, [-3,3], [-3,3], 'InitialConditions', [0.1,0.1; 2,2]);
%
% 作者 / Author: MATLAB Phase Space Analysis Tool
% 日期 / Date: 2025

    % 解析可选参数 / Parse optional arguments
    p = inputParser;
    addParameter(p, 'InitialConditions', [], @isnumeric);
    addParameter(p, 'TimeSpan', [0, 10], @isnumeric);
    addParameter(p, 'VectorField', true, @islogical);
    addParameter(p, 'GridDensity', 20, @isnumeric);
    addParameter(p, 'Nullclines', false, @islogical);
    addParameter(p, 'XLabel', 'y_1', @(x) ischar(x) || isstring(x));
    addParameter(p, 'YLabel', 'y_2', @(x) ischar(x) || isstring(x));
    addParameter(p, 'Title', '相空间图 / Phase Space Plot', @(x) ischar(x) || isstring(x));
    parse(p, varargin{:});
    
    % 提取参数 / Extract parameters
    ic = p.Results.InitialConditions;
    tspan = p.Results.TimeSpan;
    showVectorField = p.Results.VectorField;
    gridDensity = p.Results.GridDensity;
    showNullclines = p.Results.Nullclines;
    
    % 创建新图形 / Create new figure
    figure;
    hold on;
    grid on;
    box on;
    
    % 绘制矢量场 / Plot vector field
    if showVectorField
        [X, Y] = meshgrid(linspace(xlim(1), xlim(2), gridDensity), ...
                          linspace(ylim(1), ylim(2), gridDensity));
        U = zeros(size(X));
        V = zeros(size(Y));
        
        for i = 1:numel(X)
            dy = odefun(0, [X(i); Y(i)]);
            U(i) = dy(1);
            V(i) = dy(2);
        end
        
        % 归一化矢量以便更好地显示 / Normalize vectors for better display
        magnitude = sqrt(U.^2 + V.^2);
        U = U ./ (magnitude + eps);
        V = V ./ (magnitude + eps);
        
        quiver(X, Y, U, V, 0.5, 'Color', [0.7 0.7 0.7], 'LineWidth', 0.5);
    end
    
    % 绘制零倾线 / Plot nullclines
    if showNullclines
        [X, Y] = meshgrid(linspace(xlim(1), xlim(2), 100), ...
                          linspace(ylim(1), ylim(2), 100));
        U = zeros(size(X));
        V = zeros(size(Y));
        
        for i = 1:numel(X)
            dy = odefun(0, [X(i); Y(i)]);
            U(i) = dy(1);
            V(i) = dy(2);
        end
        
        % x-零倾线 (dy1/dt = 0) / x-nullcline (dy1/dt = 0)
        contour(X, Y, U, [0 0], 'r--', 'LineWidth', 1.5, 'DisplayName', 'x-nullcline');
        % y-零倾线 (dy2/dt = 0) / y-nullcline (dy2/dt = 0)
        contour(X, Y, V, [0 0], 'b--', 'LineWidth', 1.5, 'DisplayName', 'y-nullcline');
    end
    
    % 绘制轨迹 / Plot trajectories
    if ~isempty(ic)
        colors = lines(size(ic, 1));
        for i = 1:size(ic, 1)
            [~, y] = ode45(odefun, tspan, ic(i, :));
            plot(y(:,1), y(:,2), 'LineWidth', 1.5, 'Color', colors(i,:));
            plot(ic(i,1), ic(i,2), 'o', 'MarkerSize', 8, 'MarkerFaceColor', colors(i,:), ...
                'MarkerEdgeColor', 'k', 'LineWidth', 1);
            
            % 添加箭头指示方向 / Add arrows to indicate direction
            if size(y, 1) > 10
                mid_idx = round(size(y, 1) * 0.5);
                dx = y(mid_idx+1, 1) - y(mid_idx, 1);
                dy = y(mid_idx+1, 2) - y(mid_idx, 2);
                quiver(y(mid_idx, 1), y(mid_idx, 2), dx, dy, 0, ...
                    'Color', colors(i,:), 'LineWidth', 2, 'MaxHeadSize', 2);
            end
        end
    end
    
    % 设置坐标轴和标签 / Set axes and labels
    axis([xlim(1) xlim(2) ylim(1) ylim(2)]);
    xlabel(p.Results.XLabel, 'FontSize', 12);
    ylabel(p.Results.YLabel, 'FontSize', 12);
    title(p.Results.Title, 'FontSize', 14, 'FontWeight', 'bold');
    
    if showNullclines
        legend('Location', 'best');
    end
    
    hold off;
end
