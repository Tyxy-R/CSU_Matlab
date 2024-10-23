%% 1
clc;clear;
x=linspace(-5,5,100);
y=linspace(-5,5,100);
[X,Y]=meshgrid(x,y);
f=X.^2./(X.^2+y.^4+5);
surf(X,Y,f)

%% 2
clc;clear;
x=linspace(0,2*pi,100);
f=@(x)-sin(x).*x.^2;
[~,mins]=fminbnd(f,0,2*pi);
mins=-mins;

%% 3
A=[15 12 87;32 26 55];
B=A';
C=[A(1,3) A(2,1);B(2,:)];
D=diag(diag(C));
E=inv(D);

%% 4
p1=[1,2,1,0];
p2=[1,0];
p3=[5,4,3];
p=conv(p1,p2)+[0 0 p3];

%% 5
clc;clear;
x=linspace(0,pi,10);
f=@(x)cos(x);
res=diff(f([x,1.1*pi]));

%% 6
clc;clear;
syms x;
y=taylor(sin(x),x,0,"order",6);

%% 7
%1
clc;clear;
fs=750;
F0=50;
T0=1/F0;
T=1/fs;
N=T0/T;

t=linspace(0,2*T0,2*N);
y=sin(2*pi*50*t);
plot(t,y,"-*")
dt=t(2)-t(1);
for i=1:N
    if y(i)*y(i+1)<0
        x0=[(i-1)*dt,i*dt i,i+1];
        break
    end
end
%2
xq=linspace(x0(1),x0(2),2);
vq=interp1(x0(1:2),y(x0(3:4)),xq,"linear");
[~,x_truth_idx]=min(abs(vq));
x_truth=x0(1)+x_truth_idx*(xq(2)-xq(1));
sprintf("误差为%f%%",(x_truth-1/100)*(1/100)*100)

%% 8





