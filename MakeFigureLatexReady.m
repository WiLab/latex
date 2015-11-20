function MakeFigureLatexReady(figureName)
% The purpose of this function is standardize MATLAB figures
% so they look neat and uniform for latex documents

% Operation: provide a .fig file in the local folder.
% If it is in a different directory edit the dir value below.
% The function will produce a .eps file with the same name as
% the original .fig file in the same directory.  You can also
% change grid to 'off' to disable grids on figures

% example input: 'baseline_occupancy_vs_collisions.fig';
grid = 'on';
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
% Remove white borders
set(gca,'LooseInset',get(gca,'TightInset'));
% Save to eps
filename = [figureName(1:end-3),'eps'];
print([dir,filename],'-depsc','-tiff');

