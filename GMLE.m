%using UGM
function w=GMLE(data,graph,J)
y=data+1;
[nInstances,nNodes] = size(y);
adj=graph;
for i=1:nNodes
    adj(i,i)=0;
end
nStates=2;
edgeStruct = UGM_makeEdgeStruct(adj,nStates);
nodeMap = zeros(nNodes,2,'int32');
for i=1:nNodes
    nodeMap(i,2)=i;
end

nEdges = edgeStruct.nEdges;
edgeMap = zeros(2,2,nEdges,'int32');
for j=1:nEdges
edgeMap(2,2,j) = nNodes+j;
end
w = zeros(size(J,1),1);
%[nodePot,edgePot] = UGM_MRF_makePotentials(w,nodeMap,edgeMap,edgeStruct);
suffStat = UGM_MRF_computeSuffStat(y,nodeMap,edgeMap,edgeStruct);
%nll = UGM_MRF_NLL(w,nInstances,suffStat,nodeMap,edgeMap,edgeStruct,@UGM_Infer_Exact)

w = minFunc(@UGM_MRF_NLL,w,[],nInstances,suffStat,nodeMap,edgeMap,edgeStruct,@UGM_Infer_Junction);
end