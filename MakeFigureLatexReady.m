function MakeFigureLatexReady(figureName,varargin)
% The purpose of this function is standardize MATLAB figures
% so they look neat and uniform for latex documents
%
% Operation: provide a .fig file in the local folder.
% If it is in a different directory edit the dir value below.
% The function will produce a .eps file with the same name as
% the original .fig file in the same directory.  You can also
% change grid to 'off' to disable grids on figures
%
% Options:
%   - grid 'on' or 'off': enable grid
%   - dir : String of output directory for figure file
%   - border [Top,Right;Bottom,Left] : 2x2 matrix of border widths of figure from axes
%
% example: MakeFigureLatexReady('myfigure.fig','grid','on')

%%%%%%%%%%%%%%%%%%%
% Defaults
grid = 'on';
dir = '';
border = [0.01,0.01;0.01,0.01];
fontname = 'Arial';
fontsize = 10;
odir = dir;
defaultFigureDimensions = [570   422];
%%%%%%%%%%%%%%%%%%%
% Checks
if ~strcmp(figureName(end-3:end),'.fig') % Add extension if not there
    figureName = [figureName,'.fig'];
end
if exist(figureName, 'file')~=2
    error('Figure file does not exist');
end
if verLessThan('matlab','8.5')
    warning('We recommend >=R2015a due to ps/eps file generation issues.');
end
% Process PV pairs
vargs = varargin;
nargs = length(vargs);
names = vargs(1:2:nargs);
values = vargs(2:2:nargs);

validnames = {'grid','border','dir','fontsize','fontname','outputdir','figdim'};

for ind = 1:length(names)
    n = names{ind};
    v = values{ind};
    validatestring(n, validnames);
    switch n
        case {'grid'}
            grid = v; % Set grid | 'on','off'
        case {'border'}
            border = v; % Set border widths | [4x4 matrix]
        case {'fontsize'}
            fontsize = v; % Set font size | integer
        case {'fontname'}
            fontname = v; % Set font | use listfonts function to get available
        case {'outputdir'}
            odir = v; % Set output directory | String with trailing '/' (unix) or '\' (win)
        case {'figdim'}
            defaultFigureDimensions = v; % Set output dimension of figure | [1x2 matrix]
        otherwise
            warning(['Invalid argument ignored: ',num2str(num)]);
    end
end


%%%%%%%%%%%%%%%%%%%
fig = openfig(figureName);
set(fig,'WindowStyle','normal'); %Undock
% Figure Size
fig.Position(3:4) = defaultFigureDimensions;
% Font Sizes and Types
if length(fig.Children)>1
    index = 2;%has a legend
else
    index = 1;%no legend
end
fig.Children(index).FontSize = fontsize;
fig.Children(index).XLabel.FontSize = fontsize+2;
fig.Children(index).YLabel.FontSize = fontsize+2;
fig.Children(index).XLabel.FontName = fontname;
fig.Children(index).YLabel.FontName = fontname; %'Helvetica'
% Remove Title
fig.Children(index).Title.String = '';
% Grid
fig.Children(index).XGrid = grid;
fig.Children(index).YGrid = grid;
% Remove white borders
%x = fig.CurrentAxes.TightInset.*1; % Default tight widths
x(3:4) = border(1,:); % Top and right border widths
x(1:2) = border(2,:); % Bottom and left border widths
fig.CurrentAxes.LooseInset = x;
fig.PaperPositionMode = 'auto';% Ensure that the size of the saved figure is equal to the size of the figure on the display.
fig_pos = fig.PaperPosition;
fig.PaperSize = [fig_pos(3) fig_pos(4)]; % Set the page size equal to the figure size to ensure that there is no extra whitespace.
% Save to eps
filename = [figureName(1:end-3),'eps'];
print(fig,[odir,filename],'-depsc','-tiff');
% Cleanup
close(fig);
