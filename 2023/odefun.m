function dy=odefun(t,y)
dy=zeros(2,1);
dy(1)=y(2);
dy(2)=(-2*y(1)+dy(1))/(exp(t));
end