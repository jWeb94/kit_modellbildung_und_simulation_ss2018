%% Visualisierung der Daten: 

% Separates Skript, damit ich nicht immer neu simulieren muss!

load('simData.mat');

a_max_size = size(a_max);

[X,Y] = meshgrid(1:a_max_size(2),1:a_max_size(1));
surfPlot = surf(X,Y,a_max);

colorbar;

xlabel('Hub [m]');
ylabel('Masse [kg]');
zlabel('Beschleunigung [m/s^2]');
title('Visualisierung der maximalen Beschleunigung a_2 des Systems bei Variation von Masse und Hub - stets die kritischste Zeit')

x_tick = 1:a_max_size(2);
y_tick = 1:a_max_size(1);
x_tick_labels = hub(1) : schrittweiteHub : hub(2);
y_tick_labels = nutzLast(1) : 20 : nutzLast(2);

x_tick_labels = num2cell(x_tick_labels);
y_tick_labels = num2cell(y_tick_labels)

set(gca, 'XTick', x_tick);
set(gca, 'XTickLabel', x_tick_labels);

set(gca, 'YTick', y_tick);
set(gca, 'YTickLabel', y_tick_labels);

[Werte, indices] = max(a_max);
max_a_2 = max(Werte)/9.81


