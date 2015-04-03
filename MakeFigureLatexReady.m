function MakeFigureLatexReady()

grid = 'on';
%figureName = 'ss_result_GREAT3.fig';
figureName = 'baseline_occupancy_vs_collisions.fig';
dir = '';

%%%%%%%%%%%%%%%%%%%
fig = openfig(figureName);
set(fig,'WindowStyle','normal'); %Undock
% Figure Size
defaultSize = [570   422];
fig.Position(3:4) = defaultSize;
% Font Sizes and Types
if length(fig.Children)>1
    index = 2;%has a legend
else
    index = 1;%no legend
end
fig.Children(index).FontSize = 10;
fig.Children(index).XLabel.FontSize = 12;
fig.Children(index).YLabel.FontSize = 12;
fig.Children(index).XLabel.FontName = 'Arial'; 
fig.Children(index).YLabel.FontName = 'Arial'; %'Helvetica'
% Remove Title
fig.Children(index).Title.String = '';
% Grid
fig.Children(index).XGrid = grid;
fig.Children(index).YGrid = grid;
% Save to eps
filename = [figureName(1:end-3),'eps'];

print('-depsc','-painters',[dir,filename]);



