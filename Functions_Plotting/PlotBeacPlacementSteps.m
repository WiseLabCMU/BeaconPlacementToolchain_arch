function [  ] = PlotBeacPlacementSteps( COMPARE_METRIC )

%clc; clear; close all;
load RootPath.mat; load CurrentFloorPlan.mat;
FloorPlanPath = fullfile(RootPath,'FloorPlanPaths',CurrentFloorPlan);


%ResultPath = '/Users/Niranjini/Documents/02_Research/10_Localization/00_Fall15/15_PostIPSN/ION_GNSS_BeacPlace/MATLAB/FinalForPaper/BeacPlacementResult/UL';
%AllFPnames = {'Rect1';'Lroom3';'SpokesRoom';'Multiroom3';'Multiroom1';'Scaife';'CIC2101';'CICLobby'};
legendName = cell(0,0);
F_NewFig=1; F_color =1;

A=[];

%for fp = 1:size(AllFPnames,1)
    %FloorPlanPath = fullfile('FloorPlanPaths',AllFPnames{fp});
    load(fullfile(FloorPlanPath,'Corners.mat'));
    load(fullfile(FloorPlanPath,'Obstacles.mat'));
    load(fullfile(FloorPlanPath,'FloorPlanPtsInfo.mat'));
    load(fullfile(FloorPlanPath,'RayTracingInfo.mat'));
    if COMPARE_METRIC=='D'
        load(fullfile(FloorPlanPath,'BeacPlacement_U','StoreClassDOPAll.mat'));
        %StoreClassDOPAll = StoreClassDOPAll_D;clear StoreClassDOPAll_D;
    else
        load(fullfile(FloorPlanPath,'BeacPlacement_D','StoreClassDOPAll.mat'));
        %StoreClassDOPAll = StoreClassDOPAll_U;clear StoreClassDOPAll_U;
    end
    F_NewFig=0;
    figure;
    for steps = 1:size(StoreClassDOPAll,1)
        BeaconInd = cell2mat(StoreClassDOPAll(1:steps,1))';
        BeaconPos = AllCornerObsPos(BeaconInd,:);
        Class = StoreClassDOPAll{steps,2};
        DOP_UL = StoreClassDOPAll{steps,4};
        %if ~exist(fullfile(ResultPath,AllFPnames{fp},'BeacPlacemSteps_UL'))
        %    mkdir(fullfile(ResultPath,AllFPnames{fp},'BeacPlacemSteps_UL'));
        %end
        %FinalPlotsPath = fullfile(ResultPath,AllFPnames{fp},'BeacPlacemSteps_UL');
        subplot(2,size(StoreClassDOPAll,1),steps);PlotCoverageClass( BeaconPos,Class,FloorPlanPath,F_color,F_NewFig);
        if steps ==1
            ylabel('Coverage');
        end
        title(num2str(steps));
        
        subplot(2,size(StoreClassDOPAll,1),size(StoreClassDOPAll,1)+steps);PlotDOPforBeaconPlacement(BeaconPos,DOP_UL,FloorPlanPath,F_NewFig);
        if steps ==1
            ylabel('GDOP');
        end
        title(num2str(steps));
        
    end
    if COMPARE_METRIC =='U'
    [ax4,h3]=suplabel(['UL mode']  ,'t');
    else
    [ax4,h3]=suplabel(['GDOP mode']  ,'t');
    end   
    set(h3,'FontSize',18)

  
%end

