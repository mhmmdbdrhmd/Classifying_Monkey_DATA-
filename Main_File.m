clc; clear all; close all;

ParentFileSection1="D:/DATA\Monkey/The_Other_Monkey_From_Junmo/Extracted_Spikes_LFPs_SFCs_STAs/Monkey_PG/";
ParentFileSection2="/Spikes_LFPs_PAC_SFC_STA/M1_PG_Manual_Extracted_Spikes_LFP_unit_num_1.mat";

different_sessions={"20170315-1", "20170315-2","20170316-1","20170316-2","20170316-3","20170317-1","20170317-2","20170317-3","20170328" };

for i = 1 : size (different_sessions,2)
   load (strcat(ParentFileSection1, different_sessions{i},ParentFileSection2));
   
    
end