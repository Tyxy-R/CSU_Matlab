%% 1
clc;clear;
syms x;
f=(x*(exp(sin(x))+1)-2*(exp(x)-1))/sin(x)^3;
limit(f,x,0);

%% 2
clc;clear;
res=0;
for i=1:+inf
    res=res+(2*i-1)/(2^i);
end

%% 4
clc;clear;
syms a b c x y;
eqns=[a*x^2+b*y+c==0,a*x+b==0;];
[X,Y]=solve(eqns,[x,y]);

%% 5
clc;clear;
syms a b;
A=[2 a 1;2 a+2 b+3;2 a+4 2*a+7];
det(A);

%% 6
clc;clear;
syms x;
f=cos(x)*exp(-x);
taylor(f,x,0,"order",10);

%% 7
clc;clear;
syms x;
y=x*(log(x)+1/2);
ff=int(y);

%% 8
clc;clear;
syms y(x);
dy=diff(y,1);
eqn=x*dy+y-exp(x)==0;
cond=y(1)==exp(1);
res=eval(dsolve(eqn,cond));

%% 应用题
%% 1
clc;clear;
A=[1 2 3 0;0 0 0 0];
res=fun1(A);
function res=fun1(A)
res=sum(sum(~A));
end

%% 2
clear;clc;
x=1:0.2:6;
y=cos(x).^2-log(x);
y_poly=polyval(polyfit(x,y,8),x);
plot(x,y,x,y_poly);
%泰勒展开？

%% 3
clc;clear;
[t,y]=ode45(@odefun,[0,10],[1 0]);
plot(t,y(:,1))

function dydx=odefun(t,y)
dydx=zeros(2,1);
dydx(1)=y(2);
dydx(2)=(1-y(1).^2)*dydx(1).^2-y(1);
end








