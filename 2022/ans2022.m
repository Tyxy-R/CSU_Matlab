%% 1
clc;clear;
x=linspace(-5,5,1000);
y=x;
[X,Y]=meshgrid(x,y);
f=(X+Y)./(X.^2+Y.^4+2);
mesh(X,Y,f)
%% 2
clc;clear;
A=[89  12   -0.713   0;
   21  -45   42      5;
   32  96     0      29;
   5   -9.54  54    2.14];
B=[A(2:4,1) [A(2,2);A(2,4);A(3,4)]];
C=flipud(B);
D=C';
%% 3
% 1
clc;clear;
D=[5    32    21;
    29     5   -45];
p1=D(1,:);
p2=D(2,:);
p=conv(p1,p2);
x=roots(p);
[~,idx]=min(abs(x));
x0=x(idx);
% 2
f=@(x)-polyval(p,x);
[~,maxs]=fminbnd(f,-2,1);
maxs=-maxs;

%% 4

clc;clear;
% 1
tspan=[0,5];
y0=[0 1];
[t,y1]=ode45(@odefun,tspan,y0);



% 2 见q4.slx

% 3

syms x y(x);
dy=diff(y,1);
ddy=diff(y,2);
y3=dsolve(ddy+x*dy+y==0,y(0)==0,dy(0)==1);

plot(t,y1(:,1),0:0.01:5,out.y2.Data,t,subs(y3,t));
legend("y1","y2","y3")

%% 5
clc;clear;
x=0.3:0.2:1.5;
fx=[0.3 0.6 0.9 1.1 1.3 1.6 1.8];
xq=0.4:0.2:1.4;
% 1 
y1=interp1(x,fx,xq,"linear");
y2=interp1(x,fx,xq,"spline");
%3
xq2=0.3:0.1:1.5;
y3=polyval(polyfit(x,fx,5),xq2);
subplot(1,3,1);
stem(xq,y1);
subplot(1,3,2);
stem(xq,y2);
subplot(1,3,3);
stem(xq2,y3);

%% 6
clc;clear;
f=@(x)(x.*log(x));
res=integral(f,1,exp(1));

%% 7
clc;clear;
format short
syms L real;
syms C real;
w=4*pi*10^9;
Zt=150+75j;
Zm=Zt*(1/w*C*j)/(Zt+1/w*C*j)+w*L*j;
[res_L,res_C]=solve(Zm==75-15j,[L,C]);
res_L=eval(res_L.*10^9);
res_C=eval(res_C.*10^-12);
res_L=res_L(res_L>0);
res_C=res_C(res_C>0);

%% 8
clc;clear;
% 1
Zr=[2 2];
Pk=[0 0];
w=linspace(0,2*pi,2000);
H=abs(exp(1i*w)-2).*abs(exp(1i*w)-2)./abs(exp(1i*w))./abs(exp(j*w));
theta=angle(exp(1i*w)-2)*2-angle(exp(1i*w))*2;
theta=mod(theta,2*pi);
subplot(2,2,1);
plot(w,H);
subplot(2,2,2);
plot(w,theta)
axis([0,2*pi,0,2*pi]);
% 2
[H2,theta2]=freqz([1,-4,4],[1],2000,"whole");
subplot(2,2,3);
plot(theta2,abs(H2));
subplot(2,2,4);
plot(theta2,mod(angle(H2),2*pi));
axis([0,2*pi,0,2*pi]);

%% 9
clc;clear;
H=tf([1 -4 4],[1 0 0]);
bode(H)


