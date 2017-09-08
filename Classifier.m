clear all; clc; close all; warning off;

Window_Size=200; %Sample
diff = 5;

load (['D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_PSD' ,'\W',int2str(Window_Size), '_OL', int2str(diff),'_Postreward_Multi_Feature.mat']);
load (['D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_PSD' ,'\W',int2str(Window_Size), '_OL', int2str(diff),'_Postreward_Multi_Output.mat']);
load (['D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_PSD' ,'\W',int2str(Window_Size), '_OL', int2str(diff),'_Postreward_Multi_st.mat']);

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

%Finding out the highes accuracy in test:
[a1,a2]=max(accuracyte(:)); [z1,z2]=ind2sub(size(accuracyte),a2);
fprintf(['Highest accuracy on test set is ', num2str(a1*100) ,' percent.\n'...
    'And it is for ', tit{z1}, ' classifier, on the ', int2str(z2), 'th partition.\n']);