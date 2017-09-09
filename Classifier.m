clear all; clc; close all; warning off;

Window_Size=1000; %Sample
diff = 50;

load(['D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_Multi_PSD' ,'\W',int2str(Window_Size), '_OL', int2str(diff),'_whole_Feature.mat']);
load(['D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_Multi_PSD' ,'\W',int2str(Window_Size), '_OL', int2str(diff),'_whole_Output.mat']);
load(['D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_Multi_PSD' ,'\W',int2str(Window_Size), '_OL', int2str(diff),'_whole_st.mat']);

data= [Feature,Output];

clear Feature Output

totaltrial=max(st(:,2)); trial=1:totaltrial; 
partn = cvpartition(trial,'k',4);

for iipart = 1:partn.NumTestSets
    traintrialIndx = find(partn.training(iipart)==1);
    trainIndx=ismember(st(:,2),traintrialIndx);
    TESTtrialIndx = find(partn.test(iipart)==1);
    TESTIndx=ismember(st(:,2),TESTtrialIndx);
    datatr=data(trainIndx,:);
    datatr=datatr(randperm(size(datatr,1)),:);
    datate=data(TESTIndx,:);
    datate=datate(randperm(size(datate,1)),:);
    [cl,computational_time]=multi_classifier_all(datatr);
    
    
    
    accuracyte(:,iipart)=accuracy_multi_classifier_all(datate,cl);
    disp([int2str(iipart), ' th part finished']); pause(0.1)
end

%TITLE of each 22 classifier in cl, accuracytr, and accuracyte.
tit=title_multi_classifier_all();

% Finding Highest Chance 
chance1=st(:,3)==1; chance2=st(:,3)==2;
chance3=st(:,3)==0; chance4=st(:,3)==3;
hchance=max([sum(chance1),sum(chance2),sum(chance3),sum(chance4)])/size(st,1)*100;

%Finding out the highes accuracy in test:
[a1,a2]=max(accuracyte(:)); [z1,z2]=ind2sub(size(accuracyte),a2);
fprintf(['Highest accuracy on test set is ', num2str(a1*100) ,' percent.\n'...
    'And it is for ', tit{z1}, ' classifier, on the ', int2str(z2), 'th partition.\n'...
    'The chance is = ', num2str(hchance),'\n\n']);

%Finding out the highes cross validated accuracy in test
meanacc=mean(accuracyte,2);
a3=max(meanacc); a4=find(meanacc==a3);
fprintf(['Highest real accuracy on test is ', num2str(a3*100),' percent.\n'...
    'And it is for',tit{a4},' classifier.\n'...
    'The chance is = ', num2str(hchance),'\n']);