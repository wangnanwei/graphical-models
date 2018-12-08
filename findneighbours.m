function [ neighboursMatrix, localneighbours,B,P ] = findneighbours( graph,M )
%%
%written by nanwei, refer to the code of meng wei
%the code is written according to meng and wei's paper "Distributed
%Learning of Gaussian Graphical Models via Marginal Likelihoods"
% input : graph: adjacency matrix of our grid graphs;
%           M :  number of hops.

%output : neighboursMatrix:   hard to explain, I didn't use it in my
%algorithm, so it,s ok to skip it;
%         localneighbours:    1 by g^2 cell array, indices of neighbours of
%         each vertex, which is different from the variable 'neighbours' we
%         used in composite likelihood method.
%         B:    1 by g^2 cell array, buffer set of vertexes of each vertex
%         P:    1 BY G^2 CELL array, protected set of vertexes of each
%         vertex.

%%
p=size(graph,2);
neighbours1=cell(1,p);
neighboursMatrix=cell(M+1,p);
for i=1:p
    for j=1:p
        if graph(i,j)==1
           neighbours1{i}=[neighbours1{i},j];
        end
    end
    neighboursMatrix{1,i}=neighbours1{i};
end

for m=2:M+1
    for i=1:p
        for j= [neighboursMatrix{m-1,i}]
            neighboursMatrix{m,i}=union(neighboursMatrix{m,i},neighbours1{j});
        end
    end
end
localneighbours=cell(1,p);
for i=1:p
    localneighbours{i}=neighboursMatrix{M,i};
end
notneighbours=cell(1,p);
for i=1:p
    notneighbours{i}=setdiff([1:p],localneighbours{i});
end
B=cell(1,p);
P=cell(1,p);
for i=1:p
    for j=[localneighbours{i}]
        for k=[notneighbours{i}]
            if graph(j,k)==1
                B{i}=[B{i} j];
            end
        end
    end
    B{i}=unique(B{i});
    P{i}=setdiff(localneighbours{i},B{i});
end
end






