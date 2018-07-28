function [  ] = PlotComparisonOfMultiplePlacements(PlacementTypes)

load RootPath.mat; load CurrentFloorPlan.mat;
FloorPlan_Path = fullfile(RootPath,'FloorPlanPaths',CurrentFloorPlan);

load(fullfile(FloorPlan_Path,'Corners.mat'));
load(fullfile(FloorPlan_Path,'Obstacles.mat'));
load(fullfile(FloorPlan_Path,'FloorPlanPtsInfo.mat'));

PlacementTypes=[];
if exist(fullfile(FloorPlan_Path,'BeacPlacement_U','FinalPlacementAndQuality.mat'))
    PlacementTypes=[PlacementTypes,'U'];
end
if exist(fullfile(FloorPlan_Path,'BeacPlacement_D','FinalPlacementAndQuality.mat'))
    PlacementTypes=[PlacementTypes,'D'];
end
if exist(fullfile(FloorPlan_Path,'BeacPlacement_Custom','FinalPlacementAndQuality.mat'))
    PlacementTypes=[PlacementTypes,'C'];
end

figure;

legendName = cell(0,0);
DOP_UL_DataAll = [];
NumTypes = size(PlacementTypes,2);
for i = 1:NumTypes
    switch PlacementTypes(i)
        case 'U'
            load(fullfile(FloorPlan_Path,'BeacPlacement_U','FinalPlacementAndQuality.mat'));
            PlacementLegend = ['UL mode (',num2str(length(FinalPlacementAndQuality{1})),' beacons)'];
            PlacementTitle = ['UL mode'];
        case 'D'
            load(fullfile(FloorPlan_Path,'BeacPlacement_D','FinalPlacementAndQuality.mat'));
            PlacementLegend = ['GDOP mode (',num2str(length(FinalPlacementAndQuality{1})),' beacons)'];
            PlacementTitle = ['GDOP mode'];

        case 'C' % custom
            load(fullfile(FloorPlan_Path,'BeacPlacement_Custom','FinalPlacementAndQuality.mat'));
            PlacementLegend = ['Custom (',num2str(length(FinalPlacementAndQuality{1})),' beacons)'];
            PlacementTitle = ['Custom'];

    end    

    BeaconInd = FinalPlacementAndQuality{1};
    Class = FinalPlacementAndQuality{2};
    DOP_UL = FinalPlacementAndQuality{4};
    BeaconPos = AllCornerObsPos(BeaconInd,:);
    legendName = [legendName; PlacementLegend];
    DOP_UL_DataAll = [DOP_UL_DataAll DOP_UL];

    subplot(2,NumTypes,i),PlotCoverageClass( BeaconPos,Class,FloorPlan_Path,1,0 );
    title(PlacementTitle);
    if i==1 ylabel('Coverage'); end
    subplot(2,NumTypes,i+NumTypes),PlotDOPforBeaconPlacement( BeaconPos,DOP_UL,FloorPlan_Path,0 );
    if i==1 ylabel('GDOP'); end
end

     %       [ax1,h1]=suplabel('super X label');
     %       [ax2,h2]=suplabel('super Y label','y');
     %       [ax3,h2]=suplabel('super Y label (right)','yy');
            [ax4,h3]=suplabel('Comparison of different placements'  ,'t');

PlotMultipleCdfDop(DOP_UL_DataAll,legendName);






