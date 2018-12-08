function [ counts,I,indx ] = MARGINAL( y,relaxI,cliques,localneighbours )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[~,indx]=ismember(cliques,localneighbours);
I=unique(relaxI(:,indx),'rows');
p=length(I);
q=length(y);
A=zeros(p,q);
 [~,b]=ismember(relaxI(:,indx),I,'rows');
for i=1:p
    A(i,b==i)=1;
end
counts=A*y;
end
