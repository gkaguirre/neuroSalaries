%% salaryByYear

% Housekeeping
clear

% The source of the data to be plotted
sourceStr{1} = 'AAMC Faculty Salary Report, FY 2019, table 32';

% Instantiate a plotlab object
plotlabOBJ = plotlab();

% Apply the default plotlab recipe 
% overriding just the figure size
plotlabOBJ.applyRecipe(...
  'figureWidthInches', 10, ...
  'figureHeightInches', 6);

% Create a figure
figHandle = figure();

% Load "table11_rports_valid.xlsx". Silence the typical warnings
warnState = warning();
warning('off','MATLAB:table:ModifiedAndSavedVarnames');
filePathBits = strsplit(fileparts(mfilename('fullpath')),filesep);
tableName = fullfile(filesep,filePathBits{1:end-1},'data','table32_rports_valid.xlsx');
table = readtable(tableName);
warning(warnState);

% Define here lists of specialities. These are the labels on the plot
specialities_labels = {
    'Neurology - Adult',...
    'Neurology - Peds',...
    };

% This is how these are marked in the table
specialities_cats = {...
    'Neurology',...
    'Neurology-Peds.',...
    };   

% Loop through the specialties and get the median salary for each year
yearCols = {'Var9','Var7','Var5'};
yearLabels = {'2016 - 2017','2017 - 2018','2018 - 2019'};
for ii = 1:length(specialities_cats)
    idx = find(strcmp(table.Table32,specialities_cats{ii}));
    for jj = 1:length(yearCols)
        col=table.(yearCols{jj});
        salVal(ii,jj) = str2double(col{idx});
    end
end

% Plot
xPos = 1:length(yearCols);
plot(xPos,salVal(1,:),'o-k');
hold on
plot(xPos,salVal(2,:),'o-r');
box off
xlim([0.5 3.5]);
xlabel('Year');
xticks(xPos);
set(gca,'xticklabel',yearLabels);
xtickangle(45);
ylabel('Salary [$k]');
ylim([0 300]);
g=gca; 
set(g,'TickDir','out');
box off
legend(specialities_labels)

% Add title and labels
% Add title
str = {['\fontsize{16}', 'Median neurology salary across ranks [asst, assoc, full] by year'];...
        ['\fontsize{8}\color{blue} ' sourceStr{1} ]};
title(str);

