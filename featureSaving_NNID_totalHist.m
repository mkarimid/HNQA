% clc; close all,clear all;
addpath('Utils');
    
%====< feature params >=====%
dataName = 'NNID'; 
patchStep = 16; % 8, 16, 32
patchSize=16;
inputNormalization = 0;
normalizationRange = [0,255];
nBin=20;
%====< sprase params >=====%

if dataName == 'NNID'
    path_imgs = 'D:\NightQA\Data\NNID\'; % path of original night-time images
    load('D:\NightQA\Data\NNID\512.mat');
    load('D:\NightQA\Data\NNID\1024.mat');
    load('D:\NightQA\Data\NNID\2048.mat');
    numImages512 = size(DMOS512,1);
    numImages1024 = size(DMOS1024,1);
    numImages2048 = size(DMOS2048,1);
end

ftrs_512= [];
%-----------------------------------------------------------
ftrs_1024= [];
%-----------------------------------------------------------
ftrs_2048= [];
tm=0;

tic;
num_sets=[numImages512 numImages1024 numImages2048];
name_sets=['512' '1024' '2048'];
for j=1:size(num_sets,2)
    for i=1:num_sets(1,j)
        i
        if (j==1)
            I = imread([path_imgs 'sub512\' name512{i,1}]);
        elseif (j==2)
            I = imread([path_imgs 'sub1024\' name1024{i,1}]);
        else
            I = imread([path_imgs 'sub2048\' name2048{i,1}]);
        end 
%         I=imresize(I,0.5);%******* 
        Io = im2double(I);
        
        %---Calculate Feature Maps---%
        tic

        fmap1 = localDetailMap(Io);
        fmap2 = localShapnessMap(Io);
        fmap3 = localColorSaturationMap2(Io);
        fmap4 = localContrastMap(Io);
        fmap5 = localNaturalnessMap(Io);
        
              
        edges=linspace(-1,1,nBin+1);
        hist1=histcounts(fmap1,edges,'Normalization', 'probability');
        edges=linspace(0,3.4,nBin+1);
        hist2=histcounts(fmap2,edges,'Normalization', 'probability');
        edges=linspace(0,1,nBin+1);
        hist3=histcounts(fmap3,edges,'Normalization', 'probability');
        edges=linspace(0,1,nBin+1);
        hist4=histcounts(fmap4,edges,'Normalization', 'probability');
        edges=linspace(-2.8,2.8,nBin+1);
        hist5=histcounts(fmap5,edges,'Normalization', 'probability');
        tm=tm+toc;
        
        if (j==1)
           ftrs_512=[ftrs_512; hist1 hist2 hist3 hist4 hist5];
        elseif (j==2)
           ftrs_1024=[ftrs_1024; hist1 hist2 hist3 hist4 hist5];
        else
           ftrs_2048=[ftrs_2048; hist1 hist2 hist3 hist4 hist5];
        end
 
    end
     tm/i
end




     
 
