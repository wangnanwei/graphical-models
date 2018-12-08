function [ edges, cliques] = findcliques( relaxJ,P,B,nodes)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
edges=[];
for i=P
    indx=find(nodes==i);
    indx=find(relaxJ(:,indx));
    for j=indx'
        if sum(relaxJ(j,:))>1
            indx2=find(relaxJ(j,:));
            
            edges=[edges;nodes(indx2)];
        end
    end
end
edges=unique(edges, 'rows');

n=size(edges,1);
cliques=cell(1,n+1);
for i=1:n
    cliques{i}=edges(i,:);
end
cliques{n+1}=B;

            


end

