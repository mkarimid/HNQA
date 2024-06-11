clc; close all,clear all;
addpath('Utils');

%====<Params>=====%
numEpoch = 500;
FeatData1 = 'ftrs\ftrs_512.mat';
FeatData2 = 'ftrs\ftrs_1024.mat';
FeatData3 = 'ftrs\ftrs_2048.mat';

mosName1='Data\512.mat';
mosName2='Data\1024.mat';
mosName3='Data\2048.mat';
FeatNormalize = 'none'; % unitL2  none
FeatPowerTrans = 1;
mosNormalization = 0;

%====<Loading>=====%
load(FeatData1);
load(FeatData2);
load(FeatData3);

load(mosName1);
load(mosName2);
load(mosName3);
DMOS=[DMOS512;DMOS1024;DMOS2048];
numData1= size(DMOS512,1);
numData2= size(DMOS1024,1);
numData3= size(DMOS2048,1);
numData=numData1+numData2+numData3;
if (mosNormalization==1)
   DMOS = rangeNormalize(DMOS,[-1,1]);
end

%=========Feature Concatnation=========
ftrs=[ftrs_512;ftrs_1024;ftrs_2048];

%==== init ====%

plccs=zeros(1,numEpoch);
srccs=zeros(1,numEpoch);
krccs=zeros(1,numEpoch);
rmses=zeros(1,numEpoch);



for itr = 1:numEpoch
    itr
   
  [trnIndx,tstIndx] =dividerand(numData,0.8,0.2,0);
  
    trn = ftrs(trnIndx,:);  
    tst = ftrs(tstIndx,:);
    
    DMOS_train = DMOS(trnIndx,1);%---train scores
    DMOS_test = DMOS(tstIndx,1);%---test  scores

% %---------------training/testing--------------------------------
model = fitrgp(trn,DMOS_train,'KernelFunction','exponential');%,'squaredexponential','matern32','rationalquadratic'
 predicted = predict(model,tst);

%----------correlation of objective and subjective scores----- 
plcc=corr(predicted,DMOS_test)
srcc=corr(predicted,DMOS_test,'type','spearman')
krcc=corr(predicted,DMOS_test,'type','kendall')
rm=rmse(predicted,DMOS_test)
plccs(itr) = plcc;
srccs(itr) = srcc;
krccs(itr) = krcc;
rmses(itr) = rm;

end
 %---------------------------------------------------------
result=[
median(plccs);
median(srccs);
median(krccs);
median(rmses);
]


