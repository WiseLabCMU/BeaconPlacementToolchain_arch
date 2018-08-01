function [SecurePoly] = GetAndPlotConvexBeacons(Corners,FloorPlanPoly,BeaconInd,FloorPlanPath)

figure;
f=1; 
subplot(4,4,f);f=f+1;
PlotFloorPlan(FloorPlanPath,0);
%plot(Corners(:,1),Corners(:,2)); hold on;
scatter(Corners(BeaconInd,1),Corners(BeaconInd,2));

SecurePoly = {};
for k = 3 % only secure triangles %:numel(BeaconInd)
    AllPolygons = combnk(BeaconInd,k)
    isInside=[]; isConvex = [];
    for i = 1:size(AllPolygons,1)
        BeaconsPoly = Corners(AllPolygons(i,:),:);
        isConvex(i) = checkConvex(BeaconsPoly(:,1),BeaconsPoly(:,2));
        if isConvex(i)==1
            IntersectPoly = intersect(polyshape(BeaconsPoly),polyshape(FloorPlanPoly));
            if size(IntersectPoly.Vertices,1)<3
                isInside(i) = 0;
                %return;
            else
                AreaIntersectAndPoly = area(subtract(polyshape(BeaconsPoly),IntersectPoly));
                isInside(i) = numel(IntersectPoly.Vertices)==numel(polyshape(BeaconsPoly).Vertices) && AreaIntersectAndPoly<1e-3;
                % check if two polygons are the same - after circular shift 
            end
        else
            isInside(i) = 0;
        end
    end

    Valid = find(isInside);
    
    ValidInd = unique(AllPolygons(Valid,:),'rows');
    %[v,ValidInd] = unique(sort(AllPolygons(Valid,:),2),'rows')
    for i = 1:size(ValidInd,1)
        subplot(4,4,f); PlotFloorPlan(FloorPlanPath,0);
        %plot(Corners(:,1),Corners(:,2)); hold on;        
        scatter(Corners(BeaconInd,1),Corners(BeaconInd,2),60);
        plot(Corners([ValidInd(i,:) ValidInd(i,1)],1),Corners([ValidInd(i,:) ValidInd(i,1)],2),'linewidth',2);
        SecurePoly_k = Corners(AllPolygons(Valid(i),:),:);
        SecurePoly = [SecurePoly; SecurePoly_k];
        f=f+1;
        if f==16
            figure; f=1;
        end
        
    end

    
end


end

