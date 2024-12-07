function dydt=odefun(t,y)
%需要更改函数，假设为二阶微分方程
%dydt(1),y(2)为y
%y(1)为dy
%dydt(2)为ddy
%
dydt=zeros(2,1);
dydt(1)=y(2);
dydt(2)=(y(2)-2*y(1))./(exp(t));
end
