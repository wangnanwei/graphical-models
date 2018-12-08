function [ y,dy] = pseudo2hop( X,nv,I2,J2,theta)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

p=size(J2,1);
n=size(X,1);
y=zeros(n,1);
A=[];
z=zeros(p,1);
for k=1:n

B=zeros(size(I2,1),p);
x=X(k,nv);
I=I2;
I(:,nv)=repmat(x,size(I2,1),1);
for i=1:size(I2,1)
    for j=1:p
        B(i,j)=prod(I(i,find(J2(j,:))));
    end
end
y(k)=log(sum(exp(B*theta)));

for j=1:p
    A(j)=prod(X(k,find(J2(j,:))));
    indx=find(B(:,j));
    z(j)=z(j)-A(j)+sum(exp(B(indx,:)*theta))/sum(exp(B*theta));
end
y(k)=y(k)-A*theta;
end
y=sum(y);

    if nargout > 1
        dy=z;
    end
end
