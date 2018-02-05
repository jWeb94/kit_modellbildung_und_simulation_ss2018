%% Visualisierung der Daten: 

% Separates Skript, damit ich nicht immer neu simulieren muss!

load('simData.mat');

a_max_size = size(a_max);

[X,Y] = meshgrid(1:a_max_size(1),1:a_max_size(2));
surfPlot = surf(X,Y,a_max);

colorbar;

xlabel('Masse');
ylabel('Hub');
zlabel('Beschleunigung');
title('Visualisierung der maximalen Beschleunigung a_2 des Systems bei Variation von Masse und Hub - stets die kritischste Zeit')
