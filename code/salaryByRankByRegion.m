%% salaryByYear

% Housekeeping
clear

% The source of the data to be plotted
sourceStr{1} = 'AAMC Faculty Salary Report, FY 2019, tables 28-31';

% Instantiate a plotlab object
plotlabOBJ = plotlab();

% Apply the default plotlab recipe
% overriding just the figure size
plotlabOBJ.applyRecipe(...
    'figureWidthInches', 10, ...
    'figureHeightInches', 6);


% Define here lists of specialities. These are the labels on the plot
specialities_labels = {
    'Neurology - Adult',...
    };

% This is how these are marked in the table
specialities_cats = {...
    'Neurology',...
    };

rankLabels = {...
    'Instructor',...
    'Assistant Professor',...
    'Associate Professor',...
    'Professor',...
    };

regionLabels = {...
    'Western',...
    'Southern',...
    'Northeastern',...
    'Midwestern',...
    };

fileNames = {...
    'table17_rports_valid.xlsx',...
    'table15_rports_valid.xlsx',...
    'table14_rports_valid.xlsx',...
    'table16_rports_valid.xlsx',...
    };


% Loop through regions
for ff = 1:length(regionLabels)
    
    % Load the table for this region. Silence the typical warnings
    warnState = warning();
    warning('off','MATLAB:table:ModifiedAndSavedVarnames');
    filePathBits = strsplit(fileparts(mfilename('fullpath')),filesep);
    tableName = fullfile(filesep,filePathBits{1:end-1},'data',fileNames{ff});
    table = readtable(tableName);
    warning(warnState);
    
    
    % Loop through the ranks  and get the median salary values
    for rr = 1:length(rankLabels)
        idx = find((strcmp(table.Department_Specialty,specialities_cats{1}) + ...
            strcmp(table.Rank,rankLabels{rr}) ==2));
        salVal(rr,ff) = table.Median(idx);
    end
    
end

% Create a figure
figHandle = figure();

% Plot salary by rank across region
xPos = 1:length(rankLabels);
bar(xPos,salVal);
box off
xlim([0.5 length(rankLabels)+0.5]);
xticks(xPos);
set(gca,'xticklabel',rankLabels);
xtickangle(45);
ylabel('Salary [$k]');
ylim([0 300]);
g=gca;
set(g,'TickDir','out');
box off
legend(regionLabels)

% Add title and labels
% Add title
str = {['\fontsize{16}', 'Median neurology salary by region and rank'];...
    ['\fontsize{8}\color{blue} ' sourceStr{1} ]};
title(str);

