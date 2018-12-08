clc, clear, close all;
% This file shows you how to use my code to compute different MLEs for
% graphical models
%% First step
%build model and set true parameters, here I use a 5by5
%graphical model as an example

g=5;     % offer a small size of grid graph;

%generate the adjacency matrix and neighbours;
[graph,values,neighbours,edges ]=graph_parameters(g);
%This function gives you:
% graph: a adjacency matrix of the 5by5 graph, we set the diagnal value as
% 1.  values: the values each node can take, we set binary values here.
% neighbours: the neighbours of each node, e.g. the neighbours of 1 is {2,
% 6}. edges: the edges in the 5by5 graph.



%generate parameters of graph;
[J ,Theta]=get_parameters(neighbours);
% This function gives the parameters of this model, In our example,we have 65 parameters, we use
% a vector "Theta" denote the values of the parameters, and a matrix "J"
% denote the indexes of the parameters. From the result you will notice
% that J is a 65*25 matrix. Each row indexes a parameter in the model, e.g.
% the first parameter is $\theta_1$, then the first row of J has value 1 in
% the first column, and 0 otherwise.

save('5by5.mat','g','J','Theta','graph','edges','neighbours') % we save the model for future use.

%% Generate data
% Here we use Gibbs Sampling method to generate data
x=zeros(1,g*g); % we give a starting point, a 25*1 zeros vector.
[ X ] = gibbs_sampling(x,neighbours,J,Theta,5000,4000); % We generate 5000 data points and burn the first 4000, i.e. we keep 1000 data point
save('X.mat','X') % save our data "X"

%% Compute the global MLE
% We use some functions from the UGM toolbox to compute the global MLE 
cd UGM
addpath(genpath(pwd))
cd ..



gTheta=GMLE(X,graph,J);

%% Compute the one-hop pseudolikelihood:
matlabpool % use parallel computing method, maybe you need other code to do parallel computing if your matlab versions is different from mine
p=25; % the number of variables 
ptheta=cell(1,p); % initialize a cell array to save the estimation 
% use a for loop to compute the pseudolikelihood for all the valiables
parfor v=1:p
theta0=zeros(1+length(neighbours{v}),1);
% we use minFunc function to maximize the pseudo-loglikelihood.
ptheta{v}=minFunc(@(theta) pseudo( X,v,neighbours{v},theta),theta0); 
% function "pseudo" is the loglikelihood function and its first derivative we wrote
end
% After we get all the pseudo MLE for every node, we combine them by the
% following function "combination"
[THETA1,t1] = combination( J, ptheta ); 
%"THETA1" is a 25*65 matrix where we store all the local estimationa, "t1" is the
%final estimation, we average the estimations from different local models.

%% Compute the two hop pseudolikelihood:
[ ~, localneighbours,B,P ] = findneighbours( graph,2);
% this function gives your the two-hop neighbours " localneighbours" and
% buffer set "B", protect set "P"
ptheta=cell(p,1);
parfor v=1:p
[ mv,nv,I2,J2 ] = twohop( neighbours,localneighbours,v ,J);
theta0=zeros(size(J2,1),1);
temp=minFunc(@(theta) pseudo2hop( X,nv,I2,J2,theta),theta0);
indx=find(J2(:,v));
ptheta{v}=temp(indx);
end
[THETA2,t2] = combination(J, ptheta );

%% Compute the one-hop marginal likelihood


[ ~, localneighbours,B,P ] = findneighbours( graph,1 );
% this function gives your the one-hop neighbours " localneighbours" and
% buffer set "B", protect set "P". In one-hop case, the "localneighours" is
% the same as "neighbours"

theta=cell(p,1);% initialize a cell array to save the estimation 
JJ=cell(p,1);% initialize a cell array to save the indexes matrix for parameters of every local models 

parfor v=1:p

[ relaxI,relaxJ] = newij(graph, J,localneighbours{v},P{v},B{v});
% This "newij" function gives us two important matrix in the relaxed
% marginal model of one variable. Before you run the for loops you can try
% a v to see the result. E.g. let v=1, so the variable in the local model
% is {1,2,6},  "relaxI" is a 8*3 matrix, each row indexes a cell in the
% model, "relaxJ" is a 6*8 matrix, each column indexes a parameter in the
% relaxed maginal model.

[ edges, cliques] = findcliques( relaxJ,P{v},B{v},localneighbours{v});
% This "findcliques" function is used to get the cliques in the model, we
% will need cliques to do IPF algorithm.


[ y] = marginal_table( X,relaxI,localneighbours{v});
% this marginal_table" function is used to get the marginal data for
% variable in the marginal model from the global data, we store the data in
% a contingency table. E.g. let v=1, "y" is a 8*1 vector, because we have 8
% cells in this local model.

y=y+1/2^p; 
% We add a very small value to each cell count. The MLE may not exist if
% there are some zeros in some cell counts.
m = IPF(y,relaxI,cliques,localneighbours{v});
% We use IPF algorithm to get the expected cell counts "m".

w = thetaIPF( m,relaxI,relaxJ);
%  the function "thetaIPF" is used to get parameter estimation. 
%From expected cell counts "m", we compute the parameter estimation "w".

[ theta{v},JJ{v} ] = hatethis(w,v,localneighbours{v},relaxJ);
% From our paper we know we don't keep all the parameters. This functions
% "hatethis" is used to choose the right parameters "theta{v}" and the
% indexes "JJ{v}".
end
[THETA3,t3] = combination2(J, theta,JJ,localneighbours );
% After we get all the marginal MLE for every node, we combine them by the
% the function "combination2", be careful it is different from the one in
% pseudolikelihood.
%"THETA3" is a 25*65 matrix where we store all the local estimationa, "t3" is the
%final estimation, we average the estimations from different local models.




%% Compute the two-hop marginal likelihood
% this code in this section is the same as the one-hop marginal likelihood,
% but we compute the two-hop neighbours " localneighbours" instead of the
% one-hop "localneighbours"

[ ~, localneighbours,B,P ] = findneighbours( graph,2);
theta=cell(p,1);
JJ=cell(p,1);
parfor v=1:p

[ relaxI,relaxJ] = newij(graph, J,localneighbours{v},P{v},B{v});

[ edges, cliques] = findcliques( relaxJ,P{v},B{v},localneighbours{v});


[ y] = marginal_table( X,relaxI,localneighbours{v});
y=y+1/2^p; 
m = IPF(y,relaxI,cliques,localneighbours{v});

w = thetaIPF( m,relaxI,relaxJ);
[ theta{v},JJ{v} ] = hatethis(w,v,localneighbours{v},relaxJ);

end
[THET4,t4] = combination2(J, theta,JJ,localneighbours );


save('estimation.mat','gTheta','t1','t2','t3','t4')



