function [J Theta]=get_parameters(neighbours)

% Generate parameters and indicate matrix J for our graphical models
%input:    neighbours: a cell array, indices of neighbours of vertexes.
%output:   Theta: true parameters of our gride graph
%           J:  NO. of parameters by NO. of vertexes matrix, rows are indices of
%           parameters.

p=size(neighbours,2); % get the NO. of vertexes.
q=0; %get the NO.of parameters from the neighbours of each vertex.
for i=1:p
    q=q+size(neighbours{i},2);
end
q=q/2+p;
% generate matrix J.
J=zeros(p);
for i=1:p
    J(i,i)=1;
end
for i=1:p
    for j=i:p
        if ismember(j,neighbours{i})
            J=[J;J(i,:)+J(j,:)];
        end
    end
end



%generate  the parameters Theta with values 0.5 or -0.5 randomly.
R=unifrnd(0,1,size(J,1),1);
Theta=zeros(size(J,1),1);
for k=1:size(J,1)
    if R(k)>=0.5
        Theta(k)=0.5;
    else
        Theta(k)=-0.5;
    end
end
end
