function [ relaxI,relaxJ  ] = newij(graph, J,localneighbours,P,B)

% g=sqrt(size(graph,2));
    subgraph=graph;

for i=[B]
    for j=[B]
        subgraph(i,j)=1;
    end
end

%%
nodes=localneighbours;
l=length(nodes);

I=cell(1,l);
for i=1:l
  I{i}=combnk(nodes,i);
end
maxl=size(I{l},2);
relaxI=zeros(1,l);
for i=1:l
    relaxI=[   relaxI;[I{i} zeros(size(I{i},1),maxl-size(I{i},2))]];
end


relaxJ=[];
for i=2:2^l
    [~,~,w]=find(relaxI(i,:));
    [~,b]=ismember(w,nodes);
    relaxI(i,:)=zeros(1,l);
    relaxI(i,b)=ones(1,length(b));
%     I(i,w)=ones(1,length(w));
    if subgraph(w,w)==ones(length(w))
        temp=zeros(1,l);
        temp(b)=ones(1,length(w));
        relaxJ=[relaxJ;temp];
    end
end


%% delect some rows in relaxJ that not in buffer set.
    
    rows=[];
    for j=1:size(relaxJ,1)
        for k=P
             [~,b]=ismember(k,nodes);
        if relaxJ(j,b)==1 &&  (~ ismember(relaxJ(j,:),J(:,nodes),'rows'))
            rows=[rows j];
        end
        end
    end
    rows=unique(rows);
   relaxJ(rows,:)=[]; 
   
   

   

    


end