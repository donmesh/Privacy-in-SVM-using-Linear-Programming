function [table,hit_rate,true_positive,true_negative,precision,recall,...
          F1_score] = ...
performance(s, s_forecast, plot_true_vs_forecast)
% PERFORMANCE Calculates performance measures and plots test and forecast
% labels
% [table,hit_rate,true_positive,true_negative,precision,recall,F1_score] =
% performance(s, s_forecast, plot_true_vs_forecast)
% Inputs:
%   s                       Vector with labels (1 and -1)
%   s_forecast              Vector with predicted labels (1 and -1)
%   plot_true_vs_forecast   Plot true labels vs forecast labels (boolean)
% Outputs:
%   table                   Prediction realization matrix
%   hit_rate                Hit rate = TP+TN
%   true_positive           True positive fraction
%   true_negative           True negative fraction
%   precision               Precision = TP/(TP+TN)
%   recall                  Recall = TP/(TP+FN)
%   F1_score                F1_score = 2*precision*recall/(precision+recall)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = length(s);

% Plotting labels
if plot_true_vs_forecast
    figure()
    hold on
    scatter(1:n, s, '.m','LineWidth',10)
    scatter(1:n, s_forecast, '.g','LineWidth',10)
    for i = 1:n
        plot([i i], [s(i) s_forecast(i)], 'k')
    end
    hold off
    title('Label comparison')
    axis([0 n+1 -1.5 1.5])
    legend('Real labels', 'Estimated labels', 'Error', 'Location','southeast')
end

% Realization table
TP = mean(s_forecast == 1 & s == 1);
FP = mean(s_forecast == 1 & s == -1);
FN = mean(s_forecast == -1 & s == 1);
TN = mean(s_forecast == -1 & s == -1);
                                               % y = 1           y = -1
table = [TP FP;...     %  y_hat =  1   % True_positive   False_positive
         FN TN];       %  y_hat = -1   % False_negative  True_negative
 
% Measurements
hit_rate = TP + TN;
true_positive = TP;
true_negative = TN;
precision = TP /(TP + TN);
recall = TP / (TP + FP);
F1_score = 2*(precision*recall)/(precision+recall);
end