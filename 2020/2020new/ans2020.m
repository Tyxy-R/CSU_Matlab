%% 1
clc;clear;
f=@(x,y)x.^2./(x.^2+y.^4+5);
fsurf(f,[-5,5,-5,5])
%% 2
clc;clear;
f=@(x)-sin(x).*x.^2;
[maxs_idx,maxs]=fminbnd(f,0,2*pi);
maxs=-maxs;
fplot(@(x)sin(x).*x.^2,[0,2*pi])
hold on 
plot(maxs_idx,maxs,"Marker","+")
%% 3
clc;clear;
A=[15 12 87;
    32 26 55;];
B=A';
C=[A(1,3) A(2,1);
    B(2,:)];
D=diag(diag(C));
E=inv(D);
%% 4
clc;clear;
p1=[1,2,1,0];
p2=[1,1];
p3=[5,4,3];
p=conv(p1,p2)+[0,0,p3];
poly2sym(p)
%% 5
clc;clear;
x=linspace(0,pi,10);
dx=diff(cos([x,x(end)+x(2)-x(1)]),1);
%% 6
clc;clear;
syms y(x)
y(x)=sin(x);
taylor(y,x,0,Order=6);
%% 7
clc;clear;
T0=1/50;
f=50;
fs=750;
N=fs/f;
t=(0:N-1)/fs;
f=sin(2*pi*f*t);
for i=1:+inf
    if(f(i)*f(i+1)<0)
        loc=[i,i+1];
        fval=[f(i),f(i+1)];
        break
    end
end
% xq=linspace(x0(1),x0(2),200000000);
% vq=interp1(x0(1:2),y(x0(3:4)),xq,"linear");
% [~,x_truth_idx]=min(abs(vq));
% x_truth=xq(x_truth_idx);
% sprintf("误差为%f%%",(x_truth-1/100)/(1/100)*100)
vq=interp1(y(x0(3:4)),x0(1:2),0,"linear");
sprintf("误差为%f%%",(vq-1/100)/(1/100)*100)

%% 8
% a
clc;clear;
syms Lr Li r x
eqn1=(Lr-r./(r+1)).^2+Li.^2==(1./(r+1)).^2;
eqn2=(Lr-1).^2+(Li-1./x).^2==(1./x).^2;
fimplicit(subs(eqn1,r,[0,1/2,1,3/2,2]))
hold on
fimplicit(subs(eqn2,x,[-2,-3/2,-1,-1/2,1/2,1,3/2,2]))

fplot(0,[-1,1])

axis([-1,1,-1,1])
axis square
% b
[res_Lr,res_Li]=solve([Lr~=1,subs(eqn1,r,1),subs(eqn2,x,1)],[Lr,Li]);
res_abs=eval(abs(res_Lr+res_Li*1i));
res_angle=angle(res_Lr+res_Li*1i);
% c
line([0,res_Lr],[0,res_Li]);
plot(0,0,"Marker","o","MarkerSize",10)
plot(res_Lr,res_Li,"Marker","*","MarkerSize",10)
hold off