function usdt=distrjobs_ffrt2018a(alljobs)
tic
cluster1 = parcluster('PBS');
cluster1.SubmitArguments='-l nodes=32:ppn=16,walltime=50:00:00';
S=load('options.mat');
opts=S.opts;
clear S;

lenepochs=48;
totalNsamp=1E9;
Nblocks=1000;
for i=1:length(alljobs)
    num=alljobs(i);
    filename=opts(num).filename;
    loadfile=strcat('./simumat/',filename,'.mat');
    if ~exist(loadfile,'file')
        display(strcat('File doesnt exist: ',loadfile));
        usdt=0;
        return;
    end
    S=load(loadfile);
    res=S.res; clear S;
    %change the dir name, and the filenamepre
    filenamepre=strcat('./resFFRTE9/','FFRTModel',num2str(num));
    
    for ep=1:lenepochs
        filenameepc=strcat(filenamepre,'Epoch',num2str(ep),'.txt');
        if ~exist(filenameepc,'file')           
%             [epcusdt]=ffrt_falsealarm_OneEp(filenameepc,ep,res(ep).Qa,totalNsamp);
          job = batch(cluster1,@ffrt_parfor_OneEp,1,{filenameepc,ep,res(ep).Qa,totalNsamp,Nblocks},'Pool',511);
        end
    end
end
toc
usdt=toc;
