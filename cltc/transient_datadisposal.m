clear all;
clc;
%% Read data ###
filename = mfilename('fullpath');  %get the file path of script
model.savePath = fileparts(filename); 
filename=[model.savePath '\cltc_data.csv'];
Transient = ImportTransientV3(filename);
outputs.Time = Transient.TemDataArray{1,2};
sum=0;
Loss=0;
for i=1:4
    index = find(strcmp([Transient.TemFileHeader{:}],strcat('EWdg_F (Average) (C',num2str(i),')')));
    sum=sum+Transient.TemDataArray{1,index+1};
    index = find(strcmp([Transient.TemFileHeader{:}],strcat('EWdg_R (Average) (C',num2str(i),')')));
    sum=sum+Transient.TemDataArray{1,index+1};
    index = find(strcmp([Transient.LossFileHeader{:}],strcat('EWdg_F (Average) (C',num2str(i),')')));
    Loss=Loss+Transient.LossDataArray{1,index+1};
    index = find(strcmp([Transient.LossFileHeader{:}],strcat('EWdg_F (Average) (C',num2str(i),')')));
    Loss=Loss+Transient.LossDataArray{1,index+1};
end
outputs.TEWdg=sum/8;
outputs.LossEWdg=Loss;

index = find(strcmp([Transient.TemFileHeader{:}],'Stator Back Iron'));
outputs.TStatorBack=Transient.TemDataArray{1,index+1};
index = find(strcmp([Transient.LossFileHeader{:}],'Stator Back Iron'));
outputs.LossStatorBack=Transient.LossDataArray{1,index+1};

index = find(strcmp([Transient.TemFileHeader{:}],'Winding (Hotspot)'));
outputs.TWinding=Transient.TemDataArray{1,index+1};
Loss=0;
for i=1:4
    index = find(strcmp([Transient.LossFileHeader{:}],strcat('Wdg (Average) (C',num2str(i),')')));
    Loss=Loss+Transient.LossDataArray{1,index+1};
end
outputs.LossWinding=Loss;


sum=0;
for i=1:4
    index = find(strcmp([Transient.TemFileHeader{:}],strcat('Stator Tooth (C',num2str(i),')')));
    sum=sum+Transient.TemDataArray{1,index+1};
end
outputs.TTooth=sum/4;
Loss=0;
for i=1:4
    index = find(strcmp([Transient.LossFileHeader{:}],strcat('Stator Tooth (C',num2str(i),')')));
    Loss=Loss+Transient.LossDataArray{1,index+1};
end
outputs.LossTooth=Loss;

sum=0;
index = find(strcmp([Transient.TemFileHeader{:}],'End Space [F]'));
sum=sum+Transient.TemDataArray{1,index+1};
index = find(strcmp([Transient.TemFileHeader{:}],'End Space [R]'));
sum=sum+Transient.TemDataArray{1,index+1};
outputs.TEndSpace=sum/2;
Loss=0;
index = find(strcmp([Transient.LossFileHeader{:}],'End Space [F]'));
Loss=Loss+Transient.LossDataArray{1,index+1};
index = find(strcmp([Transient.LossFileHeader{:}],'End Space [R]'));
Loss=Loss+Transient.LossDataArray{1,index+1};
outputs.LossEndSpace=Loss;



index = find(strcmp([Transient.TemFileHeader{:}],'Rotor Back Iron'));
outputs.TRotorPole=Transient.TemDataArray{1,index+1};
Loss=0;
index = find(strcmp([Transient.LossFileHeader{:}],'Rotor Back Iron'));
Loss=Loss+Transient.LossDataArray{1,index+1};
index = find(strcmp([Transient.LossFileHeader{:}],'Embedded Magnet Pole'));
Loss=Loss+Transient.LossDataArray{1,index+1};
outputs.LossRotorPole=Loss;

sum=0;
index = find(strcmp([Transient.TemFileHeader{:}],'Rotor Lam [F]'));
sum=sum+Transient.TemDataArray{1,index+1};
index = find(strcmp([Transient.TemFileHeader{:}],'Rotor Lam [R]'));
sum=sum+Transient.TemDataArray{1,index+1};
outputs.TRotorLam=sum/2;
Loss=0;
index = find(strcmp([Transient.LossFileHeader{:}],'Rotor Lam [F]'));
Loss=Loss+Transient.LossDataArray{1,index+1};
index = find(strcmp([Transient.LossFileHeader{:}],'Rotor Lam [R]'));
Loss=Loss+Transient.LossDataArray{1,index+1};
outputs.LossRotorLam=Loss;

index = find(strcmp([Transient.TemFileHeader{:}],'Magnet'));
outputs.TMagnet=Transient.TemDataArray{1,index+1};
index = find(strcmp([Transient.LossFileHeader{:}],'Magnet'));
outputs.LossMagnet = Transient.LossDataArray{1,index+1};

sum=0;
index = find(strcmp([Transient.TemFileHeader{:}],'Stator Surface'));
sum=sum+Transient.TemDataArray{1,index+1};
index = find(strcmp([Transient.TemFileHeader{:}],'Rotor Surface'));
sum=sum+Transient.TemDataArray{1,index+1};
outputs.TAirgap=sum/2;
Loss=0;
index = find(strcmp([Transient.LossFileHeader{:}],'Stator Surface'));
Loss=Loss+Transient.LossDataArray{1,index+1};
index = find(strcmp([Transient.LossFileHeader{:}],'Rotor Surface'));
Loss=Loss+Transient.LossDataArray{1,index+1};
outputs.LossAirgap=Loss;

data = struct2cell(outputs);
save CLTCTransientData data