function S = cur2str(N)
% Return a string formatted for currency values
%
S = sprintf('$%.0f', N);
S(2,length(S)-3:-3:3) = ','; 
% I.e. only the end index changed in above
S = transpose(S(S ~= char(0)));
end