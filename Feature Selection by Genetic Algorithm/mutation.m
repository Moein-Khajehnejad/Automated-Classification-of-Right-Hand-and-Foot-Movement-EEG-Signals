% function y = mutation(x,VarRange) %Gaussian mutation
% nVar=numel(x);
% j=randi([1 nVar]);
% Varmin=min(VarRange);
% Varmax=max(VarRange);
% sigma= (Varmax-Varmin)/10;
% y=x;
% y(j)=x(j)+sigma  * randn;
% y=min(max(y, Varmin), Varmax));
% end
function y = mutation(x)
nVar=length(x);
j1=randi([1 nVar-1]);
j2=randi([j1+1 nVar]);
nj1=x(j1);
nj2=x(j2);
x(j1)=nj2;
x(j2)=nj1;
y=x;
end