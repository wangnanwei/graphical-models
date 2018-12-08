function [THETA,comtheta ] = combination2(J, theta,JJ,localneighbours )
% combine the composite likelihood estimation theta, here we simply average
% those two_way interaction parameters.
%input:  neighbours: 1 by g^2 cell array, indices of neighbours;
%         J: indices matrix of parameters
%         theta: 1 by g^2 cell array, composite likelihood estimation of
%         parameters

p=size(J,2);
THETA=zeros(p,size(J,1));
for i=1:p
    [~,indx]=ismember(JJ{i},J(:,localneighbours{i}),'rows');
    THETA(i,indx)=theta{i};
end
THETA(isnan(THETA))=0;
comtheta=zeros(1,size(J,1));
for i=1:size(J,1)
    comtheta(i)=mean(THETA(find(THETA(:,i)),i));
end
comtheta=comtheta';


end
