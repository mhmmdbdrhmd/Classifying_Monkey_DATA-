function [Feature2]=frequency_extracter_from_PSD(Feature, f, IF)

if IF=='D'
    tmp=find(f>=1 & f<=4);
    Feature2=Feature(:,tmp);
end

if IF=='T'
    tmp=find(f>=4 & f <=10);
    Feature2=Feature(:,tmp);
end

if IF=='A'
    tmp=find(f>=10 & f <=20);
    Feature2=Feature(:,tmp);
end

if IF=='B'
    tmp=find(f>=20 & f <=30);
    Feature2=Feature(:,tmp);
end

if IF=='G'
    tmp=find(f>=30 & f <=100);
    Feature2=Feature(:,tmp);
end
    

