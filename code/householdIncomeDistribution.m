% householdIncomeDistribution
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
%    
% Apply the default plotlab recipe 
% overriding just the figure size
plotlabOBJ.applyRecipe(...
  'figureWidthInches', 10, ...
  'figureHeightInches', 4);

% 2018 value, US census
medianHouseholdIncome = 63179;

% 2018 data, "all races"
proportionHouseholds = [0.033310261	0.025952916	0.042853032	0.04489069	0.044112958	0.042534162	0.045279556	0.042028636	0.040403176	0.03763445	0.041219795	0.034352421	0.03580678	0.031101502	0.029514929	0.030720413	0.026046244	0.023829708	0.024125246	0.020073262	0.022289798	0.019046656	0.018027827	0.015329097	0.015585749	0.013843629	0.013050343	0.011090458	0.01099713	0.010234953	0.011603761	0.007606219	0.009029468	0.007544	0.007038474	0.006494062	0.006004091	0.005335241	0.004541955	0.004394186	0.035557906	0.049580414];
nVals = length(proportionHouseholds);

% Create a blank cell array
totalHouseholdIncomelabels = cell(1,nVals);
totalHouseholdIncomelabels(:)={''};

% Create the currency support labels
for ii=1:nVals
    totalHouseholdIncomelabels{ii} = [cur2str(5000*(ii-1)) ' - ' cur2str(5000*(ii))];
end

% Special case the end values
totalHouseholdIncomelabels{1} = 'Less than $5000';
totalHouseholdIncomelabels{end-1} = '$200,000 - $250,000';
totalHouseholdIncomelabels{end} = '> $250,000';


% Plot a histogram by hand    
bar(1:nVals,100*proportionHouseholds);
xTickPositions = [1:4:nVals-3,nVals-1,nVals];
xticks(xTickPositions);
set(gca,'xticklabel',totalHouseholdIncomelabels(xTickPositions));
xtickangle(45);
ylabel('% households');

g=gca; 
set(g,'TickDir','out');
box off


foo=1;

function S = cur2str(N)
S = sprintf('$%.0f', N);
S(2,length(S)-3:-3:3) = ','; 
% I.e. only the end index changed in above
S = transpose(S(S ~= char(0)));
end