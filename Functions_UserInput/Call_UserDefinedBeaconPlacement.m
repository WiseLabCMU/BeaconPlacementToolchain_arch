function [] = Call_UserDefinedBeaconPlacement(Output_BeaconPlacement_Path)
% User defines a floor plan by placing cursor on corners

%clc; clear; close all;
load RootPath.mat; load CurrentFloorPlan.mat;
FloorPlan_Path = fullfile(RootPath,'FloorPlanPaths',CurrentFloorPlan);

%Output_DesignFloorPlan_Path = fullfile(RootPath,'Output_DesignFloorPlan',CurrentFloorPlan);

load(fullfile(FloorPlan_Path,'Corners.mat'));
load(fullfile(FloorPlan_Path,'Obstacles.mat'));
load(fullfile(FloorPlan_Path,'FloorPlanPtsInfo.mat'));

F_NewFig=1;
PlotFloorPlan(FloorPlan_Path,F_NewFig);
%PlotCorners(Corners);
%for m = 1:size(Obstacles,2)
%    obs = Obstacles{m};
%    if(~isempty(obs))
%    fill(obs(:,1),obs(:,2),[0.8 0.8 0.8]);
%    end
    hold on;scatter(AllCornerObsPos(:,1),AllCornerObsPos(:,2),50,'MarkerEdgeColor','b','MarkerFaceColor',[0 0 0.2],'LineWidth',2);
%
%end

xlim([min(Corners(:,1))-0.5 max(Corners(:,1))+0.5]);
ylim([min(Corners(:,2))-0.5 max(Corners(:,2))+0.5]);
%ylim([0 10]);
title('Beacon Placement: Click on corners. Press space when done.');
set(gca,'FontSize',14);

[x,y,button] = ginput(1);
scatter(x,y,100,'rx');hold on;
DistToCorners = pdist2([x y],AllCornerObsPos);
[minval,minindx]=min(DistToCorners);
ClosestCorner = AllCornerObsPos(minindx,:);
scatter(ClosestCorner(1),ClosestCorner(2),200,'MarkerEdgeColor',[0.5 0 0],'MarkerFaceColor','r','LineWidth',2);hold on;

set(gca,'FontSize',14);

CursorPts = ClosestCorner;
NumPts = 1;

while button ~=32 % until space key is pressed
    [x,y,button] = ginput(1);
    scatter(x,y,100,'rx');hold on;
    DistToCorners = pdist2([x y],AllCornerObsPos);
    [minval,minindx]=min(DistToCorners);
    ClosestCorner = AllCornerObsPos(minindx,:);
    scatter(ClosestCorner(1),ClosestCorner(2),200,'MarkerEdgeColor',[0.5 0 0],'MarkerFaceColor','r','LineWidth',2);hold on;
    CursorPts = [CursorPts; ClosestCorner];
end

% Last point is the Space from keyboard - remove it
CursorPts = CursorPts(1:end-1,:);
NumPts = NumPts-1;

BeaconPos = CursorPts;
[~,BeaconInd]=ismember(BeaconPos,AllCornerObsPos,'rows');
save(fullfile(FloorPlan_Path,'BeacPlacement_Custom','BeaconInd.mat'),'BeaconInd');
%save([Output_BeaconPlacement_Path,'Corners.mat'],'Corners');

