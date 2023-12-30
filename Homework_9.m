%  Imports the data file 'fakeScores.csv' to analyze and visualize (graph) the data. 
%  The data contains simulated scores from 100 subjects on three types of tests: verbal, math, and memory.

% Creates and saves a cvs file called 'psych20bhw9table.csv' and a svg file called 'psych20bhw9fig.svg'

% Author: Brianna Villalobos (2023)

clear     % clear variables from workspace
clc       % clear command window
close all % close any previously opened figure windows

dataTable = readtable('/Users/briannavillalobos/Downloads/fakeScores2023.csv') ; % imports data into a table

%% MEANS AND STANDARD DEVIATIONS

verbalScores = dataTable{:,2} ; % puts the verbal scores into a vector
mathScores = dataTable{:,3} ;   % puts the math scores into a vector
memoryScores = dataTable{:,4} ; % puts the memory scores into a vector
logicScores = dataTable{:,5} ;  % puts the logic scores into a vector

meanVerbal = mean(verbalScores) ; % gets the mean verbal score
meanMath = mean(mathScores) ;     % gets the mean math score
meanMemory = mean(memoryScores) ; % gets the mean memory score
meanLogic = mean(logicScores) ;   % gets the mean logic score

sdVerbal = std(verbalScores) ; % gets the std of the verbal scores
sdMath = std(mathScores) ;     % gets the std of the math scores
sdMemory = std(memoryScores) ; % gets the std of the memory scores
sdLogic = std(logicScores) ; % gets the std of the logic scores

semVerbal = sdVerbal / sqrt(numel(verbalScores)) ; % gets standard error of the mean of the verbal scores
semMath = sdMath / sqrt(numel(mathScores)) ;       % gets standard error of the mean of the math scores
semMemory = sdMemory / sqrt(numel(memoryScores)) ; % gets standard error of the mean of the memory scores
semLogic = sdLogic / sqrt(numel(logicScores)) ; % gets standard error of the mean of the logic scores

[~, ~, ciVerbal] = ttest(verbalScores) ; % computes 95% confidence interval for mean of the verbal scores
[~, ~, ciMath] = ttest(mathScores) ;     % computes 95% confidence interval for mean of the math scores
[~, ~, ciMemory] = ttest(memoryScores) ; % computes 95% confidence interval for mean of the memory scores
[~, ~, ciLogic] = ttest(logicScores) ; % computes 95% confidence interval for mean of the logic scores

%% CORRELATIONS

scoresMatrix = [verbalScores mathScores memoryScores logicScores] ; % creates matrix where each column has a score type

% gets the r values, p-values, and confidence-interval bounds for the scores
[corMatScoresComp, pcorScoresComp, cicorScoresCompLower, cicorScoresCompUpper] = corrcoef(scoresMatrix) ;

% converts correlation matrix of scores to a table
correlationTable = array2table(corMatScoresComp, 'VariableNames', ["Verbal Scores" "Math Scores" "Memory Scores" "Logic Scores"], ...
    'RowNames', ["Verbal Scores" "Math Scores" "Memory Scores" "Logic Scores"]) ;

disp(correlationTable) ; % displays table in command window

writetable(correlationTable, 'psych20bhw9table.csv', 'WriteRowNames', true) % saves table into a cvs file

%% SCATTER PLOTS

figure(1) % opens a figure window
set(gcf, 'Position', [100, 100, 1200, 800]) % Optional: Adjust the size of the figure window

% Verbal VS Math ScatterPlot
subplot(3, 3, 1) % select position 1 in 3x3 grid of plots
scatter(mathScores, verbalScores, 10, 'o', 'MarkerEdgeColor', 'black', 'MarkerFaceColor', [1, 0.5, 0])

title({'Verbal Score vs.', 'Math Score'}) % title
xlabel('Math Score')              % x-axis label
ylabel('Verbal Score')            % y-axis label
axis square                       % force graph to be square 
regLine1 = lsline          ;      % show least-squares regression line and store its properties in an objet called "regLine"
regLine1.Color = [0 0 1] ;        % set color of least-squares regression line
regLine1.LineWidth = 0.5     ;    % set width of least-squares regression line
box on         % complete the box outlining the graph
xlim([40 100]) % sets the x-axis limits to 40 and 100 
ylim([40 100]) % sets the y-axis limits to 40 and 100
set(gca, 'Xtick', 40:20:100)      % customizes the locations of the tick marks on the x axis 
set(gca, 'Ytick', 40:10:100)      % customizes the locations of the tick marks on the y axis
set(gca, 'FontSize', 12)          % set overall font-size for figure


% writes text for r value and confidence intervals
text(68, 50, {['r = ' num2str(round(corMatScoresComp(2), 2))] ['95% CI = ' char(91) ...
    num2str(round(cicorScoresCompLower(2), 2)) ', ' num2str(round(cicorScoresCompUpper(2), 2)) char(93)]}, 'FontSize', 8)

% Verbal VS Memory ScatterPlot
subplot(3, 3, 2) % select position 2 in 3x3 grid of plots
scatter(memoryScores, verbalScores, 10, 'oblack', 'MarkerFaceColor',  [1, 0.5, 0])  % creates scatterplot for verbal and memory scores

title({'Verbal Score vs.', 'Memory Score'}) % title
xlabel('Memory Score')            % x-axis label
ylabel('Verbal Score')            % y-axis label
axis square                       % force graph to be square 
regLine2 = lsline          ;      % show least-squares regression line and store its properties in an objet called "regLine"
regLine2.Color = [0 0 1] ;        % set color of least-squares regression line
regLine2.LineWidth = 0.5    ;     % set width of least-squares regression line
box on         % complete the box outlining the graph
xlim([40 100]) % sets the x-axis limits to 40 and 100 
ylim([40 100]) % sets the y-axis limits to 40 and 100
set(gca, 'Xtick', 40:20:100)  % customizes the locations of the tick marks on the x axis 
set(gca, 'Ytick', 40:10:100)      % customizes the locations of the tick marks on the y axis
set(gca, 'FontSize', 12)      % set overall font-size for figure

% writes text for r value and confidence intervals
text(67, 50, {['r = ' num2str(round(corMatScoresComp(3), 2))] ['95% CI = ' char(91) ...
    num2str(round(cicorScoresCompLower(3), 2)) ', ' num2str(round(cicorScoresCompUpper(3), 2)) char(93)]}, 'FontSize', 8)

% Verbal VS Logic ScatterPlot
subplot(3, 3, 3) % select position 1 in 3x3 grid of plots
scatter(logicScores, verbalScores, 10, 'o', 'MarkerEdgeColor', 'black', 'MarkerFaceColor', [1, 0.5, 0])

title({'Verbal Score vs.', 'Logic Score'}) % title
xlabel('Logic Score')              % x-axis label
ylabel('Verbal Score')            % y-axis label
axis square                       % force graph to be square 
regLine1 = lsline          ;      % show least-squares regression line and store its properties in an objet called "regLine"
regLine1.Color = [0 0 1] ;        % set color of least-squares regression line
regLine1.LineWidth = 0.5     ;    % set width of least-squares regression line
box on         % complete the box outlining the graph
xlim([40 100]) % sets the x-axis limits to 40 and 100 
ylim([40 100]) % sets the y-axis limits to 40 and 100
set(gca, 'Xtick', 40:20:100)      % customizes the locations of the tick marks on the x axis 
set(gca, 'Ytick', 40:10:100)      % customizes the locations of the tick marks on the y axis
set(gca, 'FontSize', 12)          % set overall font-size for figure


% writes text for r value and confidence intervals for Verbal vs Logic
text(68, 50, {['r = ' num2str(round(corMatScoresComp(1, 4), 2))] ['95% CI = ' char(91) ...
    num2str(round(cicorScoresCompLower(1, 4), 2)) ', ' num2str(round(cicorScoresCompUpper(1, 4), 2)) char(93)]}, 'FontSize', 8)

% Math VS Memory ScatterPlot
subplot(3, 3, 4) % select position 4 in 3x3 grid of plots
scatter(memoryScores, mathScores, 10, 'o', 'MarkerEdgeColor', 'black', 'MarkerFaceColor', [1, 0.5, 0])

title({'Math Score vs.', 'Memory Score'}) % title
xlabel('Memory Score')            % x-axis label
ylabel('Math Score')              % y-axis label
axis square                       % force graph to be square 
regLine3 = lsline          ;      % show least-squares regression line and store its properties in an objet called "regLine"
regLine3.Color = [0 0 1] ;        % set color of least-squares regression line
regLine3.LineWidth = 0.5     ;    % set width of least-squares regression line
box on         % complete the box outlining the graph
xlim([40 100]) % sets the x-axis limits to 40 and 100 
ylim([40 100]) % sets the y-axis limits to 40 and 100
set(gca, 'Xtick', 40:20:100)  % customizes the locations of the tick marks on the x axis 
set(gca, 'Ytick', 40:10:100)  % customizes the locations of the tick marks on the y axis
set(gca, 'FontSize', 12)      % set overall font-size for figure

% writes text for r value and confidence intervals for Math vs Memory, positioned on the right side
text(68, 50, {['r = ' num2str(round(corMatScoresComp(2, 3), 2))] ['95% CI = ' char(91) ...
    num2str(round(cicorScoresCompLower(2, 3), 2)) ', ' num2str(round(cicorScoresCompUpper(2, 3), 2)) char(93)]}, 'FontSize', 8)

% Math VS Logic ScatterPlot
subplot(3, 3, 5) % select position 4 in 3x3 grid of plots
scatter(logicScores, mathScores, 10, 'o', 'MarkerEdgeColor', 'black', 'MarkerFaceColor', [1, 0.5, 0])

title({'Math Score vs.', 'Logic Score'}) % title
xlabel('Logic Score')            % x-axis label
ylabel('Math Score')              % y-axis label
axis square                       % force graph to be square 
regLine3 = lsline          ;      % show least-squares regression line and store its properties in an objet called "regLine"
regLine3.Color = [0 0 1] ;        % set color of least-squares regression line
regLine3.LineWidth = 0.5     ;    % set width of least-squares regression line
box on         % complete the box outlining the graph
xlim([40 100]) % sets the x-axis limits to 40 and 100 
ylim([40 100]) % sets the y-axis limits to 40 and 100
set(gca, 'Xtick', 40:20:100)  % customizes the locations of the tick marks on the x axis 
set(gca, 'Ytick', 40:10:100)  % customizes the locations of the tick marks on the y axis
set(gca, 'FontSize', 12)      % set overall font-size for figure

% Writes text for r value and confidence intervals for Math vs Logic, positioned on the right side
text(68, 50, {['r = ' num2str(round(corMatScoresComp(2, 4), 2))] ['95% CI = ' char(91) ...
    num2str(round(cicorScoresCompLower(2, 4), 2)) ', ' num2str(round(cicorScoresCompUpper(2, 4), 2)) char(93)]}, 'FontSize', 8)

% Memory VS Logic ScatterPlot
subplot(3, 3, 6) % select position 4 in 3x3 grid of plots
scatter(logicScores, memoryScores, 10, 'o', 'MarkerEdgeColor', 'black', 'MarkerFaceColor', [1, 0.5, 0])

title({'Memory Score vs.', 'Logic Score'}) % title
xlabel('Logic Score')            % x-axis label
ylabel('Memory Score')              % y-axis label
axis square                       % force graph to be square 
regLine3 = lsline          ;      % show least-squares regression line and store its properties in an objet called "regLine"
regLine3.Color = [0 0 1] ;        % set color of least-squares regression line
regLine3.LineWidth = 0.5     ;    % set width of least-squares regression line
box on         % complete the box outlining the graph
xlim([40 100]) % sets the x-axis limits to 40 and 100 
ylim([40 100]) % sets the y-axis limits to 40 and 100
set(gca, 'Xtick', 40:20:100)  % customizes the locations of the tick marks on the x axis 
set(gca, 'Ytick', 40:10:100)  % customizes the locations of the tick marks on the y axis
set(gca, 'FontSize', 12)      % set overall font-size for figure

% Writes text for r value and confidence intervals for Memory vs Logic, positioned on the right side
text(68, 50, {['r = ' num2str(round(corMatScoresComp(3, 4), 2))] ['95% CI = ' char(91) ...
    num2str(round(cicorScoresCompLower(3, 4), 2)) ', ' num2str(round(cicorScoresCompUpper(3, 4), 2)) char(93)]}, 'FontSize', 8)
