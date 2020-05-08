clear


totalHouseholdIncome = [0.033310261	0.025952916	0.042853032	0.04489069	0.044112958	0.042534162	0.045279556	0.042028636	0.040403176	0.03763445	0.041219795	0.034352421	0.03580678	0.031101502	0.029514929	0.030720413	0.026046244	0.023829708	0.024125246	0.020073262	0.022289798	0.019046656	0.018027827	0.015329097	0.015585749	0.013843629	0.013050343	0.011090458	0.01099713	0.010234953	0.011603761	0.007606219	0.009029468	0.007544	0.007038474	0.006494062	0.006004091	0.005335241	0.004541955	0.004394186	0.035557906	0.049580414];

% Create the currency support labels
for ii=1:length(totalHouseholdIncome)
    totalHouseholdIncomelabels{ii} = [cur2str(5000*(ii-1)) ' - ' cur2str(5000*(ii))];
end

% Special case the end values
totalHouseholdIncomelabels{1} = 'Less than $5000';
totalHouseholdIncomelabels{end-1} = '$200,000 - $250,000';
totalHouseholdIncomelabels{end} = '> $250,000';
    
histogram('Categories',totalHouseholdIncomelabels,'BinCounts',totalHouseholdIncome)

salTable=readtable('table11_rports_valid.xlsx');

specialities_labels = {...
    'Orthopaedics',...
    'Cardiology',...
    'Urology',...
    'GI',...
    'Anesthesiology',...
    'Dermatology',...
    'Family Medicine',...
    'Medicine',...
    'OB/GYN',...
    'Pathology',...
    'Pediatrics',...
    'Psychiatry',...
    'Radiology',...
    'Plastic Surgery',...
    'Neurology',...
    'Intensive Care',...
    'Hospitalist',...
    'Emergency Medicine',...
    'General Surgery',...
    'ENT',...
    'Vascular Surgery',...
    'Radiation Oncology',...
    'Rheumatology',...
    'Ophthalmology',...
    'Rehab',...
    };

specialities_cats = {'Orthopedic Surgery: Total',...
    'Cardiology: Total',...
    'Urology',...
    'Gastroenterology-Med.',...
    'Total Anesthesiology',...
    'Total Dermatology',...
    'Total Family Medicine',...
    'Total Medicine',...
    'Total OB/GYN',...
    'Total Pathology',...
    'Total Pediatrics',...
    'Total Psychiatry',...
    'Total Radiology',...
    'Plastic Surgery',...
    'Neurology',...
    'Critical/Intensive Care-Med.',...
    'Hospital Medicine',...
    'Emergency Medicine',...
    'General Surgery',...
    'Otolaryngology',...
    'Vascular Surgery',...
    'Radiation Oncology',...
    'Rheumatology-Med.',...
    'Ophthalmology',...
    'Physical Medicine & Rehabilitation',...
    };   

for ii = 1:length(specialities_cats)
    idx = find(strcmp(salTable.Department_Specialty,specialities_cats{ii}));
    salVal(ii) = mean(salTable.Median(idx(1:4)));
end

[salVal,sortOrder] = sort(salVal);
%labels = categorical(specialities_labels);
labels = reordercats(categorical(specialities_labels(sortOrder)),specialities_labels(sortOrder));
barh(labels,salVal,0.25);
box off



function S = cur2str(N)
S = sprintf('$%.0f', N);
S(2,length(S)-6:-3:3) = ','; 
% I.e. only the end index changed in above
S = transpose(S(S ~= char(0)));
end