function Cost=costFcn (chromosome,Features_Train,Train_Labels)
%% Normalize Feature Vectors:
Features_Train=Features_Train';
Features_Train=normr(Features_Train);
Features_Train=Features_Train';

%%
Cost=0;
p=1;
q=1;

%% Separating the two classes:
for i=1:length(Train_Labels)
    if (Train_Labels(i)==1)
        Features_ClassOne(p,:)= Features_Train(i,:);
        p=p+1;
    else
        Features_ClassTwo(q,:)= Features_Train(i,:);
        q=q+1; 
    end
end

%% Calculating mean and variance:
mu0 = mean(Features_Train);
mu1 = mean (Features_ClassOne);
mu2 = mean(Features_ClassTwo);
sigma1 = var(Features_ClassOne);
sigma2 = var(Features_ClassOne);

%% Calculating the mean J score:
J_score=0;
for i=1:size(Features_Train,1)
    J=0;
    for j=1:length(chromosome)
        if (chromosome(j)==1)
            J = J+((abs(mu0(j)-mu1(j)))^2 - (abs(mu0(j)-mu2(j)))^2)/(sigma1(j)+sigma2(j));   
        end
    end
    J_score =J_score+J;
end
Cost =J_score/size(Features_Train,1);
end