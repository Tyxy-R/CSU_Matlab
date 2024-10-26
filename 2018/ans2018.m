%% 3
clc;clear;
f=@(x)-x./(1+x.^3);
[~,maxs]=fminbnd(f,0,5);
maxs=-maxs;
fplot(@(x)x./(1+x.^3),[0 5])


%% 4
clc;clear;
xk=[0.3 0.5 0.7 0.9 1.1 1.3 1.5];
fxk=[0.3 0.6 0.9 1.1 1.3 1.6 1.8];
% 1
res_1=trapz(xk,fxk);
% 2
res_2=diff(polyval(polyint(polyfit(xk,fxk,3)),[0.3 1.5]))


%% 6
clc;clear;
syms y(x)
y(x)=exp(-x);
taylor(y,x,0,"order",5);

%% 7
clc;clear;
syms x a; 7                                                                                                                                                                                                                                                                                  
eqn=x.^2+a.*x+1==0;
res=simplify(solve(eqn,x));

%% 8
clc;clear;
sim_res=sim("q9",[0,0.05]);
% 2
subplot(1,2,1);
plot(sim_res.y);
% 3
%T=20ms
N=64;
T=0.02;
t=linspace(0,T,N);
dt=t(2)-t(1);
fs=1/dt;

F=fft(sim_res.y.Data(1:41),N)*2/N;
F=F(1:N/2+1);
abs_F=20*log10(abs(F));
f=fs*(0:N/2)/N;
subplot(1,2,2)
plot(f,abs_F)




