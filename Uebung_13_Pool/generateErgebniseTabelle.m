%% Bestimmung der Ergebnisse der Teilfaktoriellen Zweipunkt Untersuchung:
clear; 
clc;
% einzusetzende Parameter:
nutzLast    =   [0, 560];   % kg
hub         =   [1, 22];    % m
fahrZeit    =   [2, 30];    % sek

schrittweiteHub     = 1.4;   % m 
schrittweiteZeit    = 2;    % sek


% sichere maximale Beschleunigung
a_2_zweipunkt = [];

% 1: - - - 
lastMatlab = nutzLast(1);
hubMatlab  = hub(1);
zeitMatlab = fahrZeit(1);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

% 2: - - + 
lastMatlab = nutzLast(1);
hubMatlab  = hub(1);
zeitMatlab = fahrZeit(2);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

% 3: - + +  
lastMatlab = nutzLast(1);
hubMatlab  = hub(2);
zeitMatlab = fahrZeit(2);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

% 4:  + + + 
lastMatlab = nutzLast(2);
hubMatlab  = hub(2);
zeitMatlab = fahrZeit(2);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

% 5: + - - 
lastMatlab = nutzLast(2);
hubMatlab  = hub(1);
zeitMatlab = fahrZeit(1);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

% 6: + - + 
lastMatlab = nutzLast(2);
hubMatlab  = hub(1);
zeitMatlab = fahrZeit(2);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

% 7: + + - 
lastMatlab = nutzLast(2);
hubMatlab  = hub(2);
zeitMatlab = fahrZeit(1);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

% 8: - + - 
lastMatlab = nutzLast(1);
hubMatlab  = hub(2);
zeitMatlab = fahrZeit(1);
sim('RBG_einMassenmodell_Versuchsplanung');
a_2_zweipunkt = [a_2_zweipunkt, max(a_2)];

disp(a_2_zweipunkt);


%% Aufgabe 2: 

% Vollfaktorielle Untersuchung a_2! (Nur ein Parameter)

masseTest = nutzLast(1) : 20 : nutzLast(2);
hubTest = hub(1) : schrittweiteHub : hub(2);
zeitTest = fahrZeit(1) : schrittweiteZeit : fahrZeit(2);

% Sicherung der maximalen Beschleunigung:
a_max = [];
schrittNr = 0;

for j = 1:length(masseTest)                                 % Masse
    a_max_temp = [];
    for k = 1:length(hubTest)                               % Hub
        a_max_temp_temp = [];
        for l = 1:length(zeitTest)                          % Zeit            
            % Variiere Parameter
            lastMatlab = masseTest(j);
            hubMatlab  = hubTest(k);
            zeitMatlab = zeitTest(l);
            % Simulation
            sim('RBG_einMassenmodell_Versuchsplanung');
            a_max_temp_temp = [a_max_temp, max(abs(a_2))]; % Betrag, damit ich die negativen Beschleunigungen auch beruecksichtige!
            schrittNr = schrittNr + 1
        end
        a_max_temp = [a_max_temp, max(a_max_temp_temp)];
        %disp('Iteration Zeit');
    end
    a_max = [a_max; a_max_temp]; % Matrix mit Zeile = Variation Hub und Spalte = Variation Masse
    %disp('Iteration Hub');
end


% Visualisierung



% Visualisierung der maximalen Beschleunigung a_2 des Systems bei Variation
% von Masse und Hub - die kritischste Zeit ist immer genommen (wurde auch itertiert)

% Theoretisch sollte man immer die geringste Zeit einsetzen!


