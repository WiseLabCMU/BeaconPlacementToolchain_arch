function Call_UserDefinedFloorPlan()
% User defines a floor plan by placing cursor on corners

%clc; clear; close all;
load RootPath.mat;
figure;
Output_UserDefinedFloorPlan_Path = fullfile(RootPath,'FloorPlanPaths','UserDefined');
xlim([0 10]); ylim([0 10]);
title('Floor plan design: Place cursor on corners. Press space when done.');
set(gca,'FontSize',14);

[x,y,button] = ginput(1);
scatter(x,y,80,'filled');hold on;
text(x+0.3,y+0.3,['(',num2str(x,2),',',num2str(y,2),')'],'FontSize',14);
xlim([0 10]); ylim([0 10]);
title('Floor plan design: Place cursor on corners. Press space when done.');
set(gca,'FontSize',14);

CursorPts = [x y];
NumPts = 1;

while button ~=32 % until space key is pressed
    [x,y,button] = ginput(1);
    button;
    CursorPts = [CursorPts; [x y]];
    NumPts = NumPts+1;
    scatter(x,y,80,'filled');hold on;
    text(x+0.3,y+0.3,['(',num2str(x,2),',',num2str(y,2),')'],'FontSize',14);

    hold on;plot([CursorPts(NumPts,1) CursorPts(NumPts-1,1)],...
        [CursorPts(NumPts,2) CursorPts(NumPts-1,2)],'linewidth',2);
end

% Last point is the Space from keyboard - remove it
CursorPts = CursorPts(1:end-1,:);
CursorPts = [CursorPts; CursorPts(1,:)]; % Close the polygon by adding the first poit in the end
%NumPts = NumPts-1;
    hold on;plot([CursorPts(NumPts-1,1) CursorPts(NumPts,1)],...
        [CursorPts(NumPts-1,2) CursorPts(NumPts,2)],'linewidth',2);
    
Corners = CursorPts;
Obstacles = [];
AllCornerObsPos = Corners;
save(fullfile(Output_UserDefinedFloorPlan_Path,'AllCornerObsPos.mat'),'AllCornerObsPos');
save(fullfile(Output_UserDefinedFloorPlan_Path,'Corners.mat'),'Corners');

save(fullfile(Output_UserDefinedFloorPlan_Path,'Obstacles.mat'),'Obstacles');

disp('Generating visibility information for corners');
MainRayTracing(Output_UserDefinedFloorPlan_Path );

if exist(fullfile(Output_UserDefinedFloorPlan_Path,'BeacPlacement_U'))
    rmdir(fullfile(Output_UserDefinedFloorPlan_Path,'BeacPlacement_U'),'s');
end
if exist(fullfile(Output_UserDefinedFloorPlan_Path,'BeacPlacement_D'))
    rmdir(fullfile(Output_UserDefinedFloorPlan_Path,'BeacPlacement_D'),'s');
end
if exist(fullfile(Output_UserDefinedFloorPlan_Path,'BeacPlacement_Custom'))
    rmdir(fullfile(Output_UserDefinedFloorPlan_Path,'BeacPlacement_Custom'),'s');
end






%disp('Floor plan saved');
