%% 1
clc;clear;
res=999+randi(101,1);
bool=isprime(res);
%% 2
clc;clear;
p1=[2,4,0,5];
p2=[1,2];
p3=[1,2,3];
p=conv(p1,p2)+[0,0,p3];
poly2sym(p)
roots(p)
%% 3
clc;clear;
f=@(x,y)(x.^4+y.^4)./(x.^2+y.^2+2);
fsurf(f,[-5,5,-5,5])
%% 4
clc;clear;
A=[10 5 23;89 2 -35];
B=A';
C=[B(1,:);B(3,:)];
D=diag(diag(C));
E=inv(D);
%% 5
clc;clear;
f=@(x)x.^5+x.^3+1;
res=fzero(f,-1);
%% 6
clc;clear;
f=@(x)-(1+x)./(1+x.^3);
[maxs_idx,maxs]=fminbnd(f,0,2);
maxs=-maxs;
fplot(@(x)(1+x)./(1+x.^3),[0,2])
hold on 
plot(maxs_idx,maxs,"Marker","*","MarkerSize",10)
%% 7
clc;clear;
x=linspace(0,pi,10);
dx=diff(cos([x,x(end)+x(2)-x(1)]),1);

%% 8
clc;clear;
syms x
res=taylor(exp(x),x,0,Order=6);
%% 10

%%  a
clc;clear;
syms f d
G0=-1;
beta=2*pi*f./(2.*10^8);
Gd=G0.*exp(-1i*2*beta*d);
Zd=50*(1+Gd)./(1-Gd);
fplot(abs(subs(Zd,d,0.1)),[0,4*10^9])
grid on 
%% b
clc;clear;
clc;clear;
syms k
G0=-1;
Gd=G0.*exp(-1i*2*2*pi.*k);
Zd=50*(1+Gd)./(1-Gd);
fplot(abs(Zd),[0,1])
grid on 


%% c
clc;clear;
G0=(25-50)./(25+50);
syms f d
beta=2*pi*f./(2.*10^8);
Gd=G0.*exp(-1i*2*beta*d);
Zd=50*(1+Gd)./(1-Gd);
fsurf(abs(Zd),[0.1,0.2,0,4*10^9],"EdgeColor","none");
xlabel("d")
ylabel("f")


