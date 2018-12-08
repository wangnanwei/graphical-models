function [ mv,nv,I2,J2 ] = twohop( neighbours,localneighbours,v ,J)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
mv=[v neighbours{v}];

    nv=setdiff(localneighbours{v},mv);
    indx=[];
for j=1:size(J,1)
    if J(j,mv)==zeros(1,length(mv))
        indx=[indx j];
    end
    J2=J(setdiff([1:size(J,1)],indx),:);

end
I2=zeros(1,size(J,2));

for i=1:length(mv)
  k=combnk(mv,i);
  I=zeros(size(k,1),size(J,2));
  for j=1:size(k,1)
      I(j,k(j,:))=ones(1,length(k(j,:)));
  end
I2=[I2; I];
end
end

