clc;
clear;
close all;
load('Features_Train.mat');
load('AllData_project.mat')
%% problem definition
CostFunction = @costFcn; %cost function
nVar= 2714;  %number of decision variables

%% GA parameters
MaxIt=100; % maximum number of iterations
nPop=40;  % population size

pc=0.8; %crossover percentage
nc=2*round(pc*nPop/2); %number of parents

pm=0.2; %mutation percentage
nm=round(pm*nPop); %number of mutants

%% Initialization
empty_individual.position=[];
empty_individual.cost=[];
pop=repmat(empty_individual,nPop,1);

%initialize position
for i=1:nPop
    pop(i).position = zeros(1, 2714);
    pop(i).position(randperm(numel(pop(i).position), 160)) = 1;
    pop(i).cost=CostFunction(pop(i).position,Features_Train,Train_Labels);
end  
%sort population
costs=[pop.cost];
[costs Sortorder]=sort(costs);
pop=pop(Sortorder);

%store best solution
Bestsol=pop(1); %the best individual till now
Bestcost=zeros(MaxIt,1);
Meancost=zeros(MaxIt,1);

%% GA main loop
for it=1:MaxIt
    %crossover
    %next three lines are for rullete wheel
    %f=max(costs)-costs+eps; 
    %f=f./sum(f);
    %f=cumsum(f);
    popc=repmat(empty_individual,nc/2,2);
    for k=1:nc/2
        %i1=find(rand<=f,1,'first'); %  for rullete wheel
        %i2=find(rand<=f,1,'first');
        i1=randi([1 nPop]);
        i2=randi([1 nPop]);
        p1=pop(i1);
        p2=pop(i2);
        [popc(k,1).position, popc(k,2).position] =crossover(p1.position,p2.position);
        popc(k,1).cost=CostFunction(popc(k,1).position,Features_Train,Train_Labels);
        popc(k,2).cost=CostFunction(popc(k,2).position,Features_Train,Train_Labels);
    end
    popc=popc(:);
    
    %mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        i=randi([1 nPop]);
        p=pop(i);
        popm(k).position=mutation(p.position);
        popm(k).cost=CostFunction(popm(k).position,Features_Train,Train_Labels);
        
    end
    %Merge population
    pop= [pop 
        popc
        popm];
    %sort population
    costs=[pop.cost];
    [costs Sortorder]=sort(costs);
    pop=pop(Sortorder);
    pop=pop(1:nPop); % delete extra individuals
    Bestsol=pop(nPop);
    Bestcost(it)=Bestsol.cost;
   
end
Fetures_Selected = find(pop(nPop).position);





