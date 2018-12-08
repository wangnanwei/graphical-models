function [ y] = marginal_table( data,relaxI,localneighbours)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
y=zeros(size(relaxI,1),1);
data=data(:,localneighbours);
[C,ia,ic]=unique(data,'rows');
ic=sort(ic);
t=zeros(size(C,1),1);
for i=1:size(C,1)
    t(i)=length(find(ic==i));
end

for j=1:size(C,1)
    j
   [~,a]=ismember( C(j,:),relaxI,'rows');
   
   y(a)=y(a)+t(j);
end
   




end

