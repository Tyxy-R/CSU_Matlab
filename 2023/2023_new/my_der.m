function [y3]=my_der(a1, a2,a3,b,tspan,y0,y,t)
% 用法：
%   y3 = my_der(a1, a2, a3, b, tspan, y0, y, t)
%
% 输入参数：
%   a1, a2, a3  - 系数或函数，分别表示方程中的不同项，通常为符号函数。
%   b           - 方程的右侧常数项或符号表达式。
%   tspan       - 时间区间，用于求解 ODE 数值解，格式为 [t0, tf]。
%   y0          - 初始条件，长度为 2，分别对应 y(0) 和 y'(0)。
%   y           - 符号变量，表示未知函数 y(t)，需要在函数外部定义。
%   t           - 符号变量，表示时间，通常在符号解中用作自变量。
%
% 输出参数：
%   y3          - 符号解，使用符号计算得到的微分方程解。
%
% 该函数的功能：
% 1. 使用 ode45 数值求解常微分方程。
% 2. 使用符号计算求解常微分方程的符号解。
% 3. 使用 Simulink 模拟（通过 `sim`）并获取其结果。
% 4. 绘制图形，显示数值解（ode45）、Simulink 解和符号解的比较。
%
% 步骤说明：
% 1. 通过 `ode45` 解算微分方程，得到数值解 `y1`。
% 2. 使用 `dsolve` 和符号计算求解微分方程的符号解 `y3`。
% 3. 使用 Simulink 仿真模型 `der2023b.slx` 进行仿真，并得到仿真结果。
% 4. 绘制数值解（蓝色点）、符号解（红色虚线）和 Simulink 解（黑色虚线）的比较图。
%
% 注意：
% 1. `sim("der2023b.slx")` 需要确保模型文件 `der2023b.slx` 已经存在并正确设置。
% 2. 在使用符号计算时，`a1`, `a2`, `a3`, 和 `b` 都应该是符号表达式或符号变量。
% 3. 数值解和符号解可能需要在某些情况下进行相应的单位或尺度调整。


if length(y0) ~= 2
        error('y0 must have two initial conditions: [y(0), dy(0)].');
end

%% ode45 
[time,y1]=ode45(@odefun,tspan,y0);

    function dydt = odefun(tt, yy)
        dydt = zeros(2, 1);
        dydt(1) = yy(2);
        dydt(2)=(subs(b,t,tt)-subs(a3,t,tt)*yy(1)-subs(a2,t,tt)*dydt(1))./subs(a1,t,tt);
    end

%% siumlink
out=sim("der2023b.slx","stoptime","5");

%% 符号函数
dy=diff(y,1);
ddy=diff(y,2);
y3=dsolve(a1*ddy+a2*dy+a3*y==b,y(0)==y0(1),dy(0)==y0(2));



%% 绘图
figure(1)
plot(time,y1(:,1),".b",time,subs(y3,time),":r")
hold on 
plot(out.y2.Time,out.y2.Data,"-.k")
legend("Ode45","Simulink","sym","Box","on")
grid on
end






