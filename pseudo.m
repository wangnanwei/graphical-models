function [ y,dy ] = pseudo( X,v,Nv,theta)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
d=X(:,v);
dd=X(:,Nv);
t0=theta(1);t1=theta(2:end);
y=sum(log(1+exp(t0+dd*t1))-t0*d-d.*(dd*t1));

if nargout > 1
        dy=zeros(length(Nv)+1,1);
        %dy(1)=sum(exp(t0+dd*t1)./(1+exp(t0+dd*t1))-d);
        dy(1)=sum(exp(t0+dd*t1)./(1+exp(t0+dd*t1))-d);
        
        dy(2:end)=sum(repmat(exp(t0+dd*t1)./(1+exp(t0+dd*t1)),1,length(Nv)).*dd-repmat(d,1,length(Nv)).*dd,1);
end
end
