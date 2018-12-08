

function [graph,values,neighbours,edges ]=graph_parameters(g)
%generate grid graph, adjacency matrix, the values each vertex can take, and
%the neighbours of each vertex.

%input:   g: the size of your grid graph.
%output: graph: g^2 by g^2 adjacency matrix with values 0(no edge) or 1(edge);
%        values: 1 by g^2 cell array;
%        neighbours: 1 by g^2 cell array, indices of neighbours.

graph=zeros(g*g,g*g);
neighbours=cell(1,g*g);
neighbours{1}=[ 1+1 1+g];
neighbours{g}=[g-1  g+g];
neighbours{g*g-g+1}=[g*g-g+1-g  g*g-g+1+1];
neighbours{g*g}=[g*g-g g*g-1];
for i=2:g-1
    neighbours{i}=[i-1  i+1 i+g];
end

for i=g*g-g+2:g*g-1
    neighbours{i}=[i-g i-1  i+1];
end

for i=g+1:g:g*g-g+1-g
    neighbours{i}=[i-g  i+1 i+g];
end

for i=g*2:g:g*g-g
    neighbours{i}=[ i-g i-1  i+g];
end

interior=[g+2:g+g-1];
for i=1:g-3
    interior=[interior g+2+g*i:g+g-1+g*i];
end

for i=interior
    neighbours{i}=[i-g i-1  i+1 i+g];
end


for i=1:g*g
    graph(i,i)=1;
    for j=neighbours{i}
    graph(i,j)=1;
    end
end

values=cell(1,g*g);
for i=1:g*g
values{i}=[1 0];
end

edges=[];
for i=1:g*g
    for j=1:size(neighbours{i},2)
        if neighbours{i}(j)>i
        edges=[edges; i neighbours{i}(j)];
        
    end
end
end
end

