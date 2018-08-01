clc; clear; close all;
load RootPath.mat;
NumTemplates = 4;
%GridSize = 0.25;
COMPARE_METRIC='U';
% STEP 1
% Select floor plan
% Show all 4 and ask - select among them or design new?
figure;
Output_DesignFloorPlan_Path = fullfile(RootPath,'FloorPlanPaths');
for n = 1:6
    DisplayFloorPlanPath = fullfile(Output_DesignFloorPlan_Path,['Template',num2str(n)]);
    
    %load(fullfile(Output_DesignFloorPlan_Path,['Template',num2str(n)],'Corners.mat'));
    subplot(2,3,n);F_NewFig=0;
    PlotFloorPlan(DisplayFloorPlanPath,F_NewFig);
    %PlotCorners(Corners);
    title(['Floor Plan ',num2str(n)]);
end
FloorPlanType = -1;
while (FloorPlanType<0 || FloorPlanType>6)
    FloorPlanType = input('Enter 1-6 to select a floor plan. Enter 0 to design new floor plan : ');
end
%FloorPlanType =2;

if(FloorPlanType==0)
    Call_UserDefinedFloorPlan();
    disp('Floor plan saved');
    CurrentFloorPlan = ['UserDefined'];
    ShowClustersOfFloorPlan(fullfile(Output_DesignFloorPlan_Path,CurrentFloorPlan));
else
    CurrentFloorPlan = ['Template',num2str(FloorPlanType)];
    % Show clusters
    ShowClustersOfFloorPlan(fullfile(Output_DesignFloorPlan_Path,CurrentFloorPlan));
end
save(fullfile(RootPath,'CurrentFloorPlan.mat'),'CurrentFloorPlan');

%Output_BeaconPlacement_Path = fullfile(RootPath,'Output_BeaconPlacement',CurrentFloorPlan);

% STEP 2: Beacon Placement
BeaconPlacement_Done = 0;
    
%else % User-defined floor plan
    Exit=0; %SelectBeaconPlacement =-1;
    while Exit ==0
        SelectBeaconPlacement = -1;
        while (SelectBeaconPlacement<0 || SelectBeaconPlacement>2)
            SelectBeaconPlacement = input(['0: Custom placement \n1: Run beacon placement\n2: Exit\nEnter choice: ']);
            %input(['0: Custom placement'; '1: Run beacon placement'; '2: Exit : ';]);
        end
        if(SelectBeaconPlacement==1) % Run placement
            %Call_BeaconPlacement(COMPARE_METRIC); % Beacon placement available   
            Call_BeaconPlacement('D'); % Beacon placement available   
            Call_BeaconPlacement('U');
            PlotComparisonOfMultiplePlacements();

            ShowBeaconPlacement=-1;
            while (ShowBeaconPlacement~=0 && ShowBeaconPlacement~=1)
                ShowBeaconPlacement = input('See beacon placement process (0/1)? : ');
            end
            if(ShowBeaconPlacement==1)
                PlotBeacPlacementSteps('D');
                PlotBeacPlacementSteps('U');
            end
    
        elseif SelectBeaconPlacement==0
                SelectedBeaconPlacement_Path = fullfile(RootPath,'FloorPlanPaths',CurrentFloorPlan,'BeacPlacement_Custom');
                if ~exist(SelectedBeaconPlacement_Path)
                    mkdir(SelectedBeaconPlacement_Path);
                end

                Call_UserDefinedBeaconPlacement(SelectedBeaconPlacement_Path);
                ComputeAndPlotCoverageClassAndDOP(SelectedBeaconPlacement_Path,'CDF');
                PlotComparisonOfMultiplePlacements();                
                [SecurePoly] = GetAndPlotSecureZones(SelectedBeaconPlacement_Path)
 
        else 
            Exit=1;
        end
      
    end