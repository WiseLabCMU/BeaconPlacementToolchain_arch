function [ RayTracingInfoCornerObs ] = RayTracingAllCornerObs(FloorPlan_Path,F_SaveResToPath)

load(fullfile(FloorPlan_Path,'Corners.mat'));
load(fullfile(FloorPlan_Path,'Obstacles.mat'));
load(fullfile(FloorPlan_Path,'FloorPlanPtsInfo.mat'));

RangeMax = 100;
thetha = 0:pi/50:2*pi;
RayTracingInfoPtsInFp = cell(size(PtsInFp,1),1);
for i = 1:size(AllCornerObsPos,1)
    CircleInRangeX = RangeMax * cos(thetha) + AllCornerObsPos(i,1);
    CircleInRangeY = RangeMax * sin(thetha) + AllCornerObsPos(i,2);
    
    [inRange,onRange]=inpolygon(PtsInFp(:,1),PtsInFp(:,2),CircleInRangeX,CircleInRangeY);
    PtsInRangeInd = find(inRange);
    PtsInRange = PtsInFp(PtsInRangeInd,:);
    LosStatus = [];
    for j = 1:size(PtsInRange,1)
        [x_intersectCorners,y_intersectCorners]=polyxpoly([PtsInRange(j,1) AllCornerObsPos(i,1)],...
            [PtsInRange(j,2) AllCornerObsPos(i,2)],FloorPlanPoly(:,1),FloorPlanPoly(:,2));
        indMatch = find(all([abs(x_intersectCorners-AllCornerObsPos(i,1))<10e-3,...
            abs(y_intersectCorners-AllCornerObsPos(i,2))<10e-3],2));
        x_intersectCorners(indMatch) = [];
        %y_intersectCorners(indMatch) = [];
        LosStatus(j) = isempty(x_intersectCorners);
    end
    LosStatusTrueInd = find(LosStatus);
    %PlotFloorPlan(FloorPlan_Path);hold on;
    %scatter(PtsInRange(LosStatusTrueInd,1),PtsInRange(LosStatusTrueInd,2));
    %scatter(PotentialBeaconPos(i,1),PotentialBeaconPos(i,2),150,'filled');
    
    PtsInRangeAndLosInd=PtsInRangeInd(LosStatusTrueInd);

    RayTracingInfoCornerObs{i,1} = PtsInRangeAndLosInd;
    %RayTracingInfoCornerObs{i,2} = PtsInRange(LosStatusTrueInd,:);
    
  %  for n = 1:size(AllCornerObsPos,1)
  %  PtsInLos = PtsInFp(RayTracingInfoCornerObs{n},:);
  %  IndexPtsInLos = find(ismember(PtsInFp,PtsInLos,'rows'));
    %PlotFloorPlan(FloorPlanPath);
    %scatter(PtsInFp(IndexPtsInLos,1),PtsInFp(IndexPtsInLos,2));
    %scatter(BeaconPos(n,1),BeaconPos(n,2),150,'filled');
    
        for k = 1:length(PtsInRangeAndLosInd)
            RayTracingInfoPtsInFp{PtsInRangeAndLosInd(k)}=[RayTracingInfoPtsInFp{PtsInRangeAndLosInd(k)} i];
        end
    
%    end
    disp(['Done ',num2str(i),'/',num2str(size(AllCornerObsPos,1))]);

    
end

save(fullfile(FloorPlan_Path,'RayTracingInfo.mat'),'RayTracingInfoCornerObs','RayTracingInfoPtsInFp');

end

