function [ theta] = thetaIPF( m,I,J)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
lg=size(J,1);
theta=zeros(lg,1);

for j=1:lg
    index=find(J(j,:));
    for k=1:j
        index2=find(J(k,:));
        if ismember(index2,index)
            [~,indx]=ismember(J(k,:),I,'rows');
            theta(j)=theta(j)+(-1)^(length(index)-length(index2))*log(m(indx)/m(1));
        end
    end
end


            


end

