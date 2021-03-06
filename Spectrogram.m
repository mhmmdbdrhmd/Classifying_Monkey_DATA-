clc; clear all; close all; 


%HP for reading
ParentFileSection1="D:/DATA\Monkey/The_Other_Monkey_From_Junmo/Extracted_Spikes_LFPs_SFCs_STAs/Monkey_PG/";
ParentFileSection2="/Spikes_LFPs_PAC_SFC_STA/M1_PG_Manual_Extracted_Spikes_LFP_unit_num_1.mat";
different_sessions={"20170315-1", "20170315-2","20170316-1","20170316-2","20170316-3","20170317-1","20170317-2","20170317-3","20170328" };

Window_Size=200; %Sample
f=1:0.5:200; %Frequencies for the PSD
fs=1000;

Counter = 1;
TS=[];%Temproray Signal
TSP=[];%Temporary SPectrogram
diff = 5;


Saving_ParentFolder=['D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_Spectrogram\PostReward_W' int2str(Window_Size),'_OL' int2str(diff)];
mkdir(Saving_ParentFolder);


for i = 1 : size (different_sessions,2)  % i : different sessions
   load (strcat(ParentFileSection1, different_sessions{i},ParentFileSection2));
   %R0P0 = 0
   for j = 1 : cnt_R0P0_trials  %j : Different Trials
       TS=[]; TSS=[];
       TS=TrialLFP_R0P0_Postreward(j).LFP;
       TSS=abs(spectrogram(TS,Window_Size,diff,f,fs)); 
       save([Saving_ParentFolder,'\session',int2str(i),'_0_Trial',int2str(j),'.mat'],'TSS'); %0=R0P0
       disp (['R0P0 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done. ']); pause(0.1)
   end
   
   %R3P0 = 1
   for j = 1 : cnt_R3P0_trials  %j : Different Trials
       TS=[]; TSS=[];
       TS=TrialLFP_R3P0_Postreward(j).LFP;
       TSS=abs(spectrogram(TS,Window_Size,diff,f,fs)); 
       save([Saving_ParentFolder,'\session',int2str(i),'_1_Trial',int2str(j),'.mat'],'TSS'); %1=R3P0
       disp (['R3P0 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done. ']); pause(0.1)
   end
   
   %R0P3 = 2
   for j = 1 : cnt_R0P3_trials  %j : Different Trials
       TS=[]; TSS=[];
       TS=TrialLFP_R0P3_Postreward(j).LFP;
       TSS=abs(spectrogram(TS,Window_Size,diff,f,fs)); 
       save([Saving_ParentFolder,'\session',int2str(i),'_2_Trial',int2str(j),'.mat'],'TSS'); %2=R0P3
       disp (['R0P3 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done. ']); pause(0.1)
   end
   
   %R3P3 = 3
   for j = 1 : cnt_R3P3_trials  %j : Different Trials
       TS=[]; TSS=[];
       TS=TrialLFP_R3P3_Postreward(j).LFP;
       TSS=abs(spectrogram(TS,Window_Size,diff,f,fs)); 
       save([Saving_ParentFolder,'\session',int2str(i),'_3_Trial',int2str(j),'.mat'],'TSS'); %3=R3P3
       disp (['R3P3 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done. ']); pause(0.1)
   end
       
end