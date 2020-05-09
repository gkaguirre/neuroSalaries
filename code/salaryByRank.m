%% salaryByYear

% Housekeeping
clear

% The source of the data to be plotted
sourceStr{1} = 'AAMC Faculty Salary Report, FY 2019, table 20';

% Instantiate a plotlab object
plotlabOBJ = plotlab();

% Apply the default plotlab recipe 
% overriding just the figure size
plotlabOBJ.applyRecipe(...
  'figureWidthInches', 10, ...
  'figureHeightInches', 6);

% Load "table11_rports_valid.xlsx". Silence the typical warnings
warnState = warning();
warning('off','MATLAB:table:ModifiedAndSavedVarnames');
filePathBits = strsplit(fileparts(mfilename('fullpath')),filesep);
tableName = fullfile(filesep,filePathBits{1:end-1},'data','table20_rports_valid.xlsx');
table = readtable(tableName);
warning(warnState);

% Define here lists of specialities. These are the labels on the plot
specialities_labels = {
    'Neurology - Adult',...
    };

% This is how these are marked in the table
specialities_cats = {...
    'Neurology',...
    };   

ranks = {...
    'Instructor',...
    'Assistant Professor',...
    'Associate Professor',...
    'Professor',...
    'Chief',...
    'Chair',...
};

genders = {...
    'Female',...
    'Male',...
    };

people = {...
    'Women',...
    'Men',...
    };

% Loop through the ranks and genders and get the median salary values
for rr = 1:length(ranks)
    for gg = 1:length(genders)
        idx = find((strcmp(table.Department_Specialty,specialities_cats{1}) + ...
            strcmp(table.Rank,ranks{rr}) + ...
            strcmp(table.Gender,genders{gg})==3));
        salVal(rr,gg) = table.Median(idx);
        count(rr,gg) = table.Count(idx);
    end
end

weightedMeanSalVal = sum(salVal.*count,2)./sum(count,2);

% Create a figure
figHandle = figure();

% Plot salary by rank across gender
xPos = 1:length(ranks);
bar(xPos,weightedMeanSalVal);
box off
xlim([0.5 length(ranks)+0.5]);
xlabel('Academic rank');
xticks(xPos);
set(gca,'xticklabel',ranks);
xtickangle(45);
ylabel('Salary [$k]');
ylim([0 600]);
g=gca; 
set(g,'TickDir','out');
box off

% Add title and labels
% Add title
str = {['\fontsize{16}', 'Median neurology salary across ranks'];...
        ['\fontsize{8}\color{blue} ' sourceStr{1} ]};
title(str);



% Create a figure
figHandle = figure();

% Plot salary by rank, reveal gender
xPos = 1:length(ranks);
bar(xPos,salVal);
box off
xlim([0.5 length(ranks)+0.5]);
xlabel('Academic rank');
xticks(xPos);
set(gca,'xticklabel',ranks);
xtickangle(45);
ylabel('Salary [$k]');
ylim([0 600]);
g=gca; 
set(g,'TickDir','out');
box off
legend(people);

% Add title and labels
% Add title
str = {['\fontsize{16}', 'Median neurology salary across ranks'];...
        ['\fontsize{8}\color{blue} ' sourceStr{1} ]};
title(str);

