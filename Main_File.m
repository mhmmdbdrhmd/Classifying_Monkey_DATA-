clc; clear all; close all; 


%HP for reading
ParentFileSection1="D:/DATA\Monkey/The_Other_Monkey_From_Junmo/Extracted_Spikes_LFPs_SFCs_STAs/Monkey_PG/";
ParentFileSection2="/Spikes_LFPs_PAC_SFC_STA/M1_PG_Manual_Extracted_Spikes_LFP_unit_num_1.mat";
different_sessions={"20170315-1", "20170315-2","20170316-1","20170316-2","20170316-3","20170317-1","20170317-2","20170317-3","20170328" };

%HP for PSD 
Window_Size=1000; %Sample
nw=3.5; %Should check later
f=1:0.5:200; %Frequencies for the PSD
fs=1000; %Sampling rate

Counter = 1;
TS=[];%Temproray Signal
Feature=[];
Output=[];
diff = 5;
 
for i = 1 : size (different_sessions,2)  % i : different sessions
   load (strcat(ParentFileSection1, different_sessions{i},ParentFileSection2));
   
   %R0P0 = 0
   for j = 1 : cnt_R0P0_trials  %j : Different Trials
       TS=[];
       TS=TrialLFP_R0P0_whole(j).LFP;
       for k = 1 : diff : size(TS,2) - (Window_Size -1) %k : Different time points
           Feature(Counter,:)=pmtm(TS(k : k + (Window_Size -1)), nw, f, fs);
           Output(Counter,1)=0;
           Counter=Counter+1;
       end
       disp (['R0P0 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done. ']); pause(0.1)
   end
   
   
   %R3P0 = 1
   for j = 1 : cnt_R3P0_trials  %j : Different Trials
       TS=[];
       TS=TrialLFP_R3P0_whole(j).LFP;
       for k = 1 : diff : size(TS,2) - (Window_Size -1) %k : Different time points
           Feature(Counter,:)=pmtm(TS(k : k + (Window_Size -1)), nw, f, fs);
           Output(Counter,1)=1;
           Counter=Counter+1;
       end
       disp(['R3P0 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done.']); pause(0.1)
   end
   
   
   %R0P3 = 2
   for j = 1 : cnt_R0P3_trials  %j : Different Trials
       TS=[];
       TS=TrialLFP_R0P3_whole(j).LFP;
       for k = 1 : diff : size(TS,2) - (Window_Size -1) %k : Different time points
           Feature(Counter,:)=pmtm(TS(k : k + (Window_Size -1)), nw, f, fs);
           Output(Counter,1)=2;
           Counter=Counter+1;
       end
       disp(['R0P3 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done.']); pause(0.1)
   end
   
   
   %R3P3 = 3
   for j = 1 : cnt_R3P3_trials  %j : Different Trials
       TS=[];
       TS=TrialLFP_R3P3_whole(j).LFP;
       for k = 1 : diff : size(TS,2) - (Window_Size -1) %k : Different time points
           Feature(Counter,:)=pmtm(TS(k : k + (Window_Size -1)), nw, f, fs);
           Output(Counter,1)=3;
           Counter=Counter+1;
       end
       disp(['R3P3 for the ', int2str(i),' th session and ', int2str(j), 'th trial is done.']); pause(0.1)
   end
   
   
   
    
end

save('D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_PSD_Time_Moving_Using_W_equal_to_1000\Feature.mat','Feature');
save('D:\DATA\Monkey\The_Other_Monkey_From_Junmo\Extracted_PSD_Time_Moving_Using_W_equal_to_1000\Output.mat','Output');