%% 1
clc;clear;
f=@(x)(x-1)./(x.^2+2);
fplot(f,[-5,5]);
[mins_idx,minx]=fminbnd(f,-5,5);
g=@(x)-(x-1)./(x.^2+2);
[maxs_idx,maxs]=fminbnd(g,-5,5);
maxs=-maxs;
hold on
plot(mins_idx,minx,"Marker","*","MarkerSize",10);
plot(maxs_idx,maxs,"Marker","*","MarkerSize",10);
grid on 
%% 2
clc;clear;
format short
f=@(x,y)exp(-(x.^2+y.^2));
I=integral2(f,0,pi,0,1);
%% 3
clc;clear;
A=[38 21 0.71 0;
    12 -3.2 2 15;
    32 96 0.5 -2.9;
    5 -8.5 59 2.1;
    ];
% a
means=mean(A(:));
% b
q2=max(A(:));
% c
q3=A(A<0);
% 4
q4=flipud(q3);
r=roots(q4);
qq4=r(r<1 & r> -1);
%% 4
clc;clear;
syms y(t)
y3=my_der(exp(t),-1,2,0,[0,5],[0,1],y,t);
%% 5
clc;clear;
x=linspace(-pi/4,pi/4,100);
for i=2:+inf
    if(abs(polyval(polyfit(x,cos(x),i),x)-cos(x))<1e-4)
        break
    end
end
plot(x,abs(polyval(polyfit(x,cos(x),i),x)-cos(x)))
grid on
%% 6
clc;clear;
syms x
f=(sqrt(sym(pi))-sqrt(acos(x)))./(sqrt(x+1));
res=eval(limit(f,x,-1,"right"));
fplot(f,[-1 0])
grid on 
%% 7

clc;clear;
format short 
W0=2*pi*(2.4*10^9);
L=50;
C=0.04;
Ls_f=@(Wu,Wl,Wc)L./(Wu-Wl)*1e9;
Cs_f=@(Wu,Wl,Wc)(Wu-Wl)./(Wc.^2*L)*1e12;
Lp_f=@(Wu,Wl,Wc)(Wu-Wl)./(Wc.^2*C)*1e9;
Cp_f=@(Wu,Wl,Wc)C./(Wu-Wl)*1e12;

%% 7a
syms Wu Wl positive real 
Wc=W0;
eqns=[Wu-Wl==0.2*W0,Wc==sqrt(Wu*Wl),Wu>Wl];
[x,y]=solve(eqns,[Wu,Wl]);
x=eval(x);
y=eval(y);
res=[Ls_f(x,y,Wc),Cs_f(x,y,Wc),Lp_f(x,y,Wc),Cp_f(x,y,Wc)];

%% 7b
syms Wc positive real 
Wu=1.1*W0;
Wl=0.9*W0;
Wc=sqrt(Wu*Wl);
x=Wu;
y=Wl;
res=[Ls_f(x,y,Wc),Cs_f(x,y,Wc),Lp_f(x,y,Wc),Cp_f(x,y,Wc)];






