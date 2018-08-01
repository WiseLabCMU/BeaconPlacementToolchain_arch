function [SecurePoly] = GetAndPlotSecureZones(BeacPlacementDir)

load RootPath.mat; load CurrentFloorPlan.mat;
FloorPlan_Path = fullfile(RootPath,'FloorPlanPaths',CurrentFloorPlan);

load(fullfile(FloorPlan_Path,'AllCornerObsPos.mat'));
%load(fullfile(FloorPlan_Path,'Obstacles.mat'));
load(fullfile(FloorPlan_Path,'FloorPlanPtsInfo.mat'));

load(fullfile(BeacPlacementDir,'BeaconInd.mat'),'BeaconInd');

[SecurePoly] = GetAndPlotConvexBeacons(AllCornerObsPos,FloorPlanPoly,BeaconInd,FloorPlan_Path)









