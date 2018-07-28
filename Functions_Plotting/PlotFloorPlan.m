function [  ] = PlotFloorPlan(FloorPlanPath,F_NewFig)%,TestPt,LosBeaconIndex,MeasuredRanges)

F_TickOff=1;
%if(~exist(LabelSize))
    LabelSize=18;
%end
load(fullfile(FloorPlanPath,'Corners.mat'));
load(fullfile(FloorPlanPath,'Obstacles.mat'));

if F_NewFig
    figure;
end
plot(Corners(:,1),Corners(:,2),'color',[0.5 0.5 0.5],'linewidth',2);hold on;
for m = 1:size(Obstacles,2)
    obs = Obstacles{m};
    if(~isempty(obs))
    fill(obs(:,1),obs(:,2),[0.8 0.8 0.8]);
    end
end
% = 18;
axis tight;
axis equal;

if F_TickOff==1
    set(gca,'XTickLabel','');
    set(gca,'YTickLabel','');
else
    xlabel('x (m)','FontSize',LabelSize);
    ylabel('y (m)','FontSize',LabelSize);

end

set(gca,'fontsize',LabelSize);
grid on;


end

