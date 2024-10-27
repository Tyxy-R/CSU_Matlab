%% 选择题
% A A B 
% B
clc;clear;
syms y(x);
y(x)=x*cos(x);
eval(subs(diff(y,2),5))
eval(subs(diff(y,3),5))
%  A
clc;clear;
t=0:0.1:2;
tspan=[0 2]

f=@(t,x)[2*x(2);-0.5*x(1)];
ode45(f,tspan,[1; 1]);
legend("x(1)","x(2)")

%% 填空
%% 1  0.473
clc;clear;
f=@(x)(abs(x)+sin(x)).*x.^2;
res=integral(f,0,1);

%% 2  0.9346
clc;clear;
f=@(x)-sin((x+1)./(x.^2+1));
[~,maxs]=fminbnd(f,0,10);
maxs=-maxs

%% 3 0.8179
clc;clear;
syms y(x);
dy=diff(y);
ddy=diff(y,2);
eqn=ddy+2*dy+2*y==0;
cond=[y(0)==1 dy(0)==1];
res=dsolve(eqn,cond);
eval(subs(res,x,1))

%% 4    7.7495
clc;clear;
res=0;
for i=1:50
    res=res+(i+2)/i^2;
end

%% 5
clc;clear;
P=[1 0 0 0 0  -1];
roots(P);
%% 编程题
% 3
clc;clear;
syms u(t)
du=diff(u,t);
eqn=du+2*u==cos(t)-2*sin(t);
cond=u(0)==0;
res=simplify(dsolve(eqn,cond));
x=0:0.2:10;
plot(x,subs(res,t,x),LineStyle="-.",Color="r",LineWidth=2,Marker="*",MarkerSize=10)
grid on




