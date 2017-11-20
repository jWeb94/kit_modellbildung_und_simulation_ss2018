clear 
clc
%Aufgabe 2: Parameterinit fuer Simulinkmodell des Einmassenschwingers
%
inputVar = input('enter false to set model 2 to sinwave-input or enter true to select step-input! Please enter: ');
%
%Edit: Error-Handle waere noch ganz cool zu wissen!
%https://de.mathworks.com/help/matlab/ref/try.html
% -> aehnlich wie in Python!
if inputVar == true         %Sprunganregung
    disp('selected step-input')
    switchVar = 0;
elseif inputVar == false    %Sinusanregung
    disp('selected sin-input')
    switchVar = 1;
else
    disp('wrong input! Start script again!');
    return %Skript abbrechen
end
%Solver-Optionen:
relTol = 1e-6;
stepSize = .001; %Um Modelle in einem Plot vergleichbar zu machen notwendig (?)
%Parameter
m = 1;          %kg
c = 10;         %N/m
d = .5;         %N*s/m
F_t = 20;       %N
F_sigma = 10;   %N
t_max = 20;     %s
omega = 2;      %1/s (Hz)
%
%Anfangsbedingungen
y0 = 0;         %m
yDot0 = 0;      %m/s
%
%rufe Simulink-Modell auf:
sim('einMassenSchwinger');
sim('einMassenSchwingerAngeregt');
sim('uebertragungsFunktion');
%
%Vergleich der Plots:
%Anmerkung: 
    %Gleiche Solveroptionen, gleiche Zeitschrittweite
    %Dennoch unterschiedliches Ergebnis-Warum? !!!!!!!!!!!
if  switchVar == 1  %dann ist Vergleich der Ausgaben der Modelle einMassenSchwingerAngeregt & ubertragungsFunktion moeglich!
    fkt = plot(tout,yOut_A2);
    hold on
    g_S = plot(tout, Gs_Out);
    xlabel('time t [s]');
    ylabel('Auslenkung y [m]');
    title('Vergleich DGL-Modell mit Übertragungsfunktion-Modell')
    legend([fkt,g_S],{'DGL-Modell' 'Übertragungsfunktion'});
else
    disp('no comparison possible!');
end
disp('end of the simulation!');
    
