function [] = MainRayTracing(Output_FloorPlan_Path )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

F_SaveResToPath = 1;
F_Plot = 0;

%FloorPlanPath = fullfile('FloorPlanPaths',FloorPlanName);
GridSize = 0.2;

PlotFloorPlan(Output_FloorPlan_Path,F_Plot);
GetAllPointsInFloorPlan(Output_FloorPlan_Path,GridSize,F_SaveResToPath,[]);
RayTracingAllCornerObs(Output_FloorPlan_Path,F_SaveResToPath);
%PlotRayTracingAllCorners(Output_FloorPlan_Path); %PlotRayTracingRandomPts(FloorPlanPath)
GetAllAmbigPtsInFloorPlan(Output_FloorPlan_Path);
[ClustData, ClustCnt]=ClusterPointsInFloorPlan(Output_FloorPlan_Path,0);


end

