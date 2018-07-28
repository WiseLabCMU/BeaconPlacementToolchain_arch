function [ ] = ShowClustersOfFloorPlan( FloorPlan_Path )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

load(fullfile(FloorPlan_Path,'Corners.mat'));
load(fullfile(FloorPlan_Path,'Obstacles.mat'));
load(fullfile(FloorPlan_Path,'FloorPlanPtsInfo.mat'));
load(fullfile(FloorPlan_Path,'RayTracingInfo.mat'));
load(fullfile(FloorPlan_Path,'RayTracingClusters.mat'));

F_NewFig=1;
PlotFloorPlan(FloorPlan_Path,F_NewFig);

for i = 1:size(ClustData,1)
    Pts=PtsInFp(ClustData{i,4},:);
    scatter(Pts(:,1),Pts(:,2));
    text(Pts(1,1),Pts(1,2),num2str(i));
end

title('Partition of floor plan based on ray-tracing');


end

