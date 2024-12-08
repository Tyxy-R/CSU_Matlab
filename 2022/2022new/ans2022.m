%% 1
clc;clear;
f=@(x,y)(x+y)./(x.^2+y.^4+2);
fsurf(f,[-5,5,-5,5])
%% 2
clc;clear;
A=[89 12 -0.713 0;
21 -45 42 5;
32 96 0 29;
5 -9.54 54 2.14;];
B=[A(2:4,1) [A(2,2);A(2,4);A(3,4)]];
C=flipud(B);
D=C'
%% 3
clc;clear;
D=[ 5    32    21;
    29     5    -45];
p=conv(D(1,:),D(2,:));
res=roots(p);
[f,f_idx]=min(abs(res));

fp=@(x)-polyval(p,x);
[maxs_idx,maxs]=fminbnd(fp,-2,1);
maxs=-maxs;
fplot(@(x)polyval(p,x),[-2,1])
hold on 

plot(maxs_idx,maxs,"Marker","*","MarkerSize",10)
grid on
%% 4
clc;clear;
syms y(t)
tspan=[0,5];
y0=[0,1];
my_der(1,t,1,0,tspan,y0,y,t)
%% 5
clc;clear;
format short
xk=[0.3 0.5 0.7 0.9 1.1 1.3 1.5];
fxk=[0.3 0.6 0.9 1.1 1.3 1.6 1.8];
xq=0.4:0.2:1.4;
y1=interp1(xk,fxk,xq,"linear");
y2=interp1(xk,fxk,xq,"spline");
xq2=0.3:0.1:1.5;
y3=polyval(polyfit(xk,fxk,5),xq2);
%% 6
clc;clear;
f=@(x)x.*log(x);
res=integral(f,1,exp(1));
%% 7
clc;clear;
format short
syms L real 
syms C real 
w=2*pi*2*10^9;
Zt=150+75j;
eqn=1i*w*L+1./(1i*w*C+1/Zt)==75-15j;
[res_L,res_C]=solve(eqn,[L,C]);
res_L=eval(res_L)*10^9;
res_L=res_L(real(res_L)>0)
res_C=eval(res_C)*10^12;
res_C=res_C(real(res_C)>0)
%% 8
clc;clear;
w=linspace(0,2*pi,100);
abs_H=(abs(exp(1i*w)-2)).^2./(abs(exp(1i*w))).^2;
angle_H=angle(exp(1i*w)-2)*2-2*angle(exp(1i*w));
subplot(2,2,1)
plot(w,abs_H)
grid on 

subplot(2,2,2)
plot(w,mod(angle_H,2*pi))
grid on 
b=[1,-4,4];
a=1;
[h,w]=freqz(b,a,'whole',2000);
subplot(2,2,3)
plot(w,abs(h))
grid on 
subplot(2,2,4)
plot(w,mod(angle(h),2*pi))
grid on