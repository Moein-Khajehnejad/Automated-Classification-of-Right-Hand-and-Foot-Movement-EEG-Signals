% function[y1 y2]=crossover(x1,x2)  %arithmetic crossover
% alpha=rand(size(x1));
% y1=alpha .*x1 + (1-alpha).*x2;
% y2=alpha .*x2 + (1-alpha).*x1;
% %y1=min(max(y1,Varmin),Varmax);
% %y2=min(max(y2,Varmin),Varmax);
% end
function[y1 y2]=crossover(x1,x2)
nVar=length(x1);
j=randi([1 nVar-1]);
y1=[x1(1:j) x2(j+1:nVar)];
y2=[x2(1:j) x1(j+1:nVar)];
end
