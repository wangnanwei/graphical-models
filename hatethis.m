function [ y,JJ ] = hatethis(w,v,nodes,relaxJ)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
indx=find(nodes==v);
indx2=find(relaxJ(:,indx));
y=w(indx2);
JJ=relaxJ(indx2,:);


end

