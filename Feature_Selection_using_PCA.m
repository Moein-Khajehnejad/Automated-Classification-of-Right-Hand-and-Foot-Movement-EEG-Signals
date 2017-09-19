clc;
clear all;
load('Features_Train.mat')
load('Features_Test.mat')
A=zeros(280,2714);
A(1:168,:)=Features_Train;
A(169:280,:)=Features_Test;
A=A';
A=normr(A);
A=A';
[coeff,score,latent,tsquared,explained,mu] = princomp(A); %PCA
% %Computing the best dimension
% s_landa=0;
%  s=0;
%  for j=1:length(latent)
%      s=s+latent(j);
%  end 
%  i=1:1:length(latent);
%  for k=1:length(i)
%      s_landa=s_landa+latent(k);
%   error(k) = 1- ( s_landa/ s);
%  end
%  figure;
%  plot(i,error);
F = A *coeff(:,1:160);
Features_Train = F(1:168,:);
Features_Test = F(169:280,:);
%% Modifying Train Labels
load('AllData_project.mat')
for i=1:168
     if (Train_Labels(i)==1)
         Train_Labels_M(i)=0;
     end
end
for i=1:168
     if (Train_Labels(i)==2)
         Train_Labels_M(i)=1;
     end
end
Train_Labels_M = Train_Labels_M';


