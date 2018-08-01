clc; clear; close all;
%load('/Users/niranjini/Box Sync/IPINdemoK/IPINDemo/DemoMain/FloorPlanPaths/Template1/Corners.mat')

Corners =[
     0     0;...
     0    11;...
     5    11;...
     5     6;...
    11     6;...
    11    11;...
    16    11;...
    16     0;...
    11     0;...
    11     5;...
     5     5;...
     5     0;...
     0     0];
%rng(20);
BeaconInd = unique(randi(size(Corners,1),ceil(size(Corners,1)),1)); 


[SecurePoly] = GetAndPlotConvexBeacons(Corners,BeaconInd)


% 
% SecurePoly = {};
% for k = 3:numel(BeaconInd)
%     AllPolygons = combnk(BeaconInd,k)
%     isInside=[]; isConvex = [];
%     for i = 1:size(AllPolygons,1)
%         Poly = Corners(AllPolygons(i,:),:);
%         isConvex(i) = checkConvex(Poly(:,1),Poly(:,2));
%         if isConvex(i)==1
%             IntersectPoly = intersect(polyshape(Poly),polyshape(Corners));
%             isInside(i) = numel(IntersectPoly.Vertices)==numel(polyshape(Poly).Vertices) && all(all(IntersectPoly.Vertices==polyshape(Poly).Vertices));
%         else
%             isInside(i) = 0;
%         end
%     end
% 
%     Valid = find(isInside);
%     ValidInd = unique(AllPolygons(Valid,:),'rows');
%     for i = 1:size(ValidInd,1)
%         subplot(4,4,f); plot(Corners(:,1),Corners(:,2)); hold on;
%         f=f+1;
%         scatter(Corners(BeaconInd,1),Corners(BeaconInd,2),60);
%         plot(Corners([ValidInd(i,:) ValidInd(i,1)],1),Corners([ValidInd(i,:) ValidInd(i,1)],2),'linewidth',2);
%         SecurePoly_k = Corners(AllPolygons(Valid(i),:),:);
%         SecurePoly = [SecurePoly; SecurePoly_k];
%     end
% 
%     
% end





