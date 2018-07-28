function [ ] = ComputeAndPlotCoverageClassAndDOP(BeacPlacementDir,LengendText)
% BeacPlacementDir can be 'BeacPlacement_D', 'BeacPlacement_U' or
% 'BeacPlacement_Custom'

load RootPath.mat; load CurrentFloorPlan.mat;
FloorPlan_Path = fullfile(RootPath,'FloorPlanPaths',CurrentFloorPlan);

load(fullfile(FloorPlan_Path,'Corners.mat'));
load(fullfile(FloorPlan_Path,'Obstacles.mat'));
load(fullfile(FloorPlan_Path,'FloorPlanPtsInfo.mat'));
load(fullfile(FloorPlan_Path,'RayTracingInfo.mat'));

load(fullfile(BeacPlacementDir,'BeaconInd.mat'),'BeaconInd');

BeaconPos = AllCornerObsPos(BeaconInd,:);
BeaconCoverage = RayTracingInfoCornerObs(BeaconInd);
PtsInFp_LosBeac = cell(size(PtsInFp,1),2);
for nB = 1:length(BeaconInd)
    PtsInLos = PtsInFp(BeaconCoverage{nB},:);
    IndexPtsInLos = find(ismember(PtsInFp,PtsInLos,'rows'));
    for k = 1:length(IndexPtsInLos)
        PtsInFp_LosBeac{IndexPtsInLos(k),2}=[PtsInFp_LosBeac{IndexPtsInLos(k),2} BeaconInd(nB)];
    end
end

for k = 1:size(PtsInFp,1)
    PtsInFp_LosBeac{k,1}=size(PtsInFp_LosBeac{k,2},2);
end
                
Class=GetClassOfPoints(PtsInFp_LosBeac,BeaconPos,FloorPlan_Path);
[DOP,DOP_UL]=GetDopOfPoints(PtsInFp_LosBeac,Class,FloorPlan_Path);

figure;subplot(1,2,1);
F_color=1;
PlotCoverageClass( BeaconPos,Class,FloorPlan_Path,1,0 );
title('Coverage class');
subplot(1,2,2);PlotDOPforBeaconPlacement(BeaconPos,DOP_UL,FloorPlan_Path,0);
%hsp1 = get(gca, 'Position') 
title('DOP');
FinalPlacementAndQuality = {BeaconInd Class DOP DOP_UL};
%FinalPlacementAndQuality(1) = {cell2mat(StoreClassDOPAll(:,1))}; %Store the ind of all beacons
%save(fullfile(ResultPath,'FinalPlacementAndQuality.mat'),'FinalPlacementAndQuality');

save(fullfile(BeacPlacementDir,'FinalPlacementAndQuality.mat'),'FinalPlacementAndQuality');



end

