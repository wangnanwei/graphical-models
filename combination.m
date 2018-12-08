function [THETA,comtheta ] = combination(J, theta )
% combine the composite likelihood estimation theta, here we simply average
% those two_way interaction parameters.
%input:  neighbours: 1 by g^2 cell array, indices of neighbours;
%         J: indices matrix of parameters
%         theta: 1 by g^2 cell array, composite likelihood estimation of
%         parameters

p=size(J,2);
THETA=zeros(p,size(J,1));
for i=1:p
    THETA(i,find(J(:,i)))=theta{i};
end
comtheta=zeros(size(J,1),1);
for i=1:size(J,1)
    comtheta(i)=mean(THETA(find(THETA(:,i)),i));
end


end

