function [ n] = cell_count( index,i,I,nodes,data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[~,aa]=ismember(index,nodes);

[~,bb]=ismember(I(:,aa),i,'rows');
bb=find(bb);
n=sum(data(bb));


end