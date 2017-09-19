clear all;
load('AllData_project.mat')

%% Feature Extraction For Training Data:
for i=1:168
    vec_train = double(Train_EEG_data(:,:,i)); 
    vec_train_f = 2*abs(fft(vec_train',350))/350;
    vec_train_f =vec_train_f';
    %MRCP_related_Channels = [vec_train(34,:);vec_train(36,:);vec_train(38,:);...
        %vec_train(52,:);vec_train(53,:);vec_train(54,:);vec_train(55,:);vec_train(56,:)];
    
    for j=1:118
        %Statistical Features:
        Mean = mean(vec_train(j,:));
        Std = std(vec_train(j,:));
        Skew = skewness(vec_train(j,:));
        Kurt = kurtosis(vec_train(j,:));
        [m,ARcoef]=ar(vec_train(j,:),10,'burg');
        Arcoef= ARcoef(1,2:end);
        Features1= [Mean,Std,Skew,Kurt,Arcoef];
        %Frequency domain Features:
        MaxA = max(vec_train_f(j,:));
        [PSD,f] = periodogram(vec_train(j,:));
        Fmean = sum(PSD.*f)/sum(PSD);
        [PSD2,f2] = periodogram(vec_train(j,:),rectwin(length(vec_train(j,:))),length(vec_train(j,:)),100);
        S1=0;S2=0;S3=0;S4=0;S5=0;S6=0;S7=0;
        for k=1:length(f2)
            if (2<=f2(k) && f(k)<=8)
                S1= S1 + PSD(k)^2;
            end
            if (9<=f2(k) && f(k)<=15)
                S2= S2 + PSD(k)^2;
            end
            if (16<=f2(k) && f(k)<=22)
                S3= S3 + PSD(k)^2;
            end
            if (23<=f2(k) && f(k)<=29)
                S4= S4 + PSD(k)^2;
            end
            if (30<=f2(k) && f(k)<=36)
                S5= S5 + PSD(k)^2;
            end
            if (37<=f2(k) && f(k)<=43)
                S6= S6 + PSD(k)^2;
            end
            if (44<=f2(k) && f(k)<=50)
                S7= S7 + PSD(k)^2;
            end
        end
        Sum=S1+S2+S3+S4+S5+S6+S7;
        PSR= [S1/Sum,S2/Sum,S3/Sum,S4/Sum,S5/Sum,S6/Sum,S7/Sum];
        Features2 = [MaxA,Fmean,PSR];
        %All Features of the channel : 
        Features_ch((j-1)*23+1:j*23) = [Features1,Features2];
        
    end
   Features_Train(i,:)= Features_ch; 
   
end
%% 
%% Featute Extraction For Test Data:
for i=1:112
    vec_train = double(Test_EEG_data(:,:,i)); 
    vec_train_f = 2*abs(fft(vec_train',350))/350;
    vec_train_f =vec_train_f';
    %MRCP_related_Channels = [vec_train(34,:);vec_train(36,:);vec_train(38,:);...
        %vec_train(52,:);vec_train(53,:);vec_train(54,:);vec_train(55,:);vec_train(56,:)];
    
    for j=1:118
        %Statistical Features:
        Mean = mean(vec_train(j,:));
        Std = std(vec_train(j,:));
        Skew = skewness(vec_train(j,:));
        Kurt = kurtosis(vec_train(j,:));
        [m,ARcoef]=ar(vec_train(j,:),10,'burg');
        Arcoef= ARcoef(1,2:end);
        Features1= [Mean,Std,Skew,Kurt,Arcoef];
        %Frequency domain Features:
        MaxA = max(vec_train_f(j,:));
        [PSD,f] = periodogram(vec_train(j,:));
        Fmean = sum(PSD.*f)/sum(PSD);
        [PSD2,f2] = periodogram(vec_train(j,:),rectwin(length(vec_train(j,:))),length(vec_train(j,:)),100);
        S1=0;S2=0;S3=0;S4=0;S5=0;S6=0;S7=0;
        for k=1:length(f2)
            if (2<=f2(k) && f(k)<=8)
                S1= S1 + PSD(k)^2;
            end
            if (9<=f2(k) && f(k)<=15)
                S2= S2 + PSD(k)^2;
            end
            if (16<=f2(k) && f(k)<=22)
                S3= S3 + PSD(k)^2;
            end
            if (23<=f2(k) && f(k)<=29)
                S4= S4 + PSD(k)^2;
            end
            if (30<=f2(k) && f(k)<=36)
                S5= S5 + PSD(k)^2;
            end
            if (37<=f2(k) && f(k)<=43)
                S6= S6 + PSD(k)^2;
            end
            if (44<=f2(k) && f(k)<=50)
                S7= S7 + PSD(k)^2;
            end
        end
        Sum=S1+S2+S3+S4+S5+S6+S7;
        PSR= [S1/Sum,S2/Sum,S3/Sum,S4/Sum,S5/Sum,S6/Sum,S7/Sum];
        Features2 = [MaxA,Fmean,PSR];
        %All Features of the channel : 
        Features_ch((j-1)*23+1:j*23) = [Features1,Features2];
        
    end
   Features_Test(i,:)= Features_ch; 
   
end

