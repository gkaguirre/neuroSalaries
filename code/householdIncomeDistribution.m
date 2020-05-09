%% householdIncomeDistribution
%
% Data taken from US Census:
%
%   https://www.census.gov/data/tables/time-series/demo/income-poverty/cps-hinc/hinc-06.html
%
%   Income Distribution to $250,000 or More for Households
%

% Housekeeping
clear

% Instantiate a plotlab object
plotlabOBJ = plotlab();

% Create a figure
figHandle = figure();

% Apply the default plotlab recipe 
% overriding just the figure size
plotlabOBJ.applyRecipe(...
  'figureWidthInches', 10, ...
  'figureHeightInches', 6);

% 2018 value, US census
medianHouseholdIncome = 63179;

% Load "hinc06.xls". Silence the typical warnings
warnState = warning();
warning('off','MATLAB:table:ModifiedAndSavedVarnames');
filePathBits = strsplit(fileparts(mfilename('fullpath')),filesep);
tableName = fullfile(filesep,filePathBits{1:end-1},'data','hinc06.xls');
table = readtable(tableName);
warning(warnState);

% Grab the parts of the table we want
incomeLabels = table{10:end-1,1};
nHouseholds = str2double(table{9,2});
percentHouseholds = 100 * str2double(table{10:end-1,2}) / nHouseholds;
sourceStr = table{4,1};
nVals = length(incomeLabels);

% Plot a histogram by hand    
bar(1:nVals,percentHouseholds);
xTickPositions = [1:4:nVals-3,nVals-1,nVals];
xticks(xTickPositions);
set(gca,'xticklabel',incomeLabels(xTickPositions));
xtickangle(45);
ylabel('% Households');
ylim([0 6]);
g=gca; 
set(g,'TickDir','out');
box off
grid off

% Add a labeled line for median household income
hold on
binWidth = 5000;
xPos = medianHouseholdIncome/binWidth;
plot([xPos xPos],[0 5.5],'-b');
text(xPos+0.5,5.5,['<-- median ' cur2str(medianHouseholdIncome)],'FontSize',14)

% Add title
str = {['\fontsize{16}', 'Distribution of annual household income in the United States'];...
        ['\fontsize{8}\color{blue} ' sourceStr{1} ]};
title(str);



function S = cur2str(N)
S = sprintf('$%.0f', N);
S(2,length(S)-3:-3:3) = ','; 
% I.e. only the end index changed in above
S = transpose(S(S ~= char(0)));
end