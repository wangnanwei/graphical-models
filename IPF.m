function m = IPF(y,relaxI,cliques,localneighbours)

eps=1e-8;

nrow=size(relaxI,1);
m=ones(nrow,1);
oldm=m;
newm=2*m;
Counts=cell(length(cliques),1);
for i=1:length(cliques)
[ counts,~,~ ] = MARGINAL( y,relaxI,cliques{i},localneighbours );
Counts{i}=counts;
end

while max(abs(oldm-newm))>eps
    max(abs(oldm-newm))
    oldm=m;
for i=1:length(cliques)

[ mt,I,indx ] = MARGINAL( m,relaxI,cliques{i},localneighbours );
adjust=Counts{i}./mt;

[~, ib]=ismember(relaxI(:,indx),I,'rows');
adjust2=adjust(ib);

newm=m.*adjust2;
m=newm;
end

end
end








