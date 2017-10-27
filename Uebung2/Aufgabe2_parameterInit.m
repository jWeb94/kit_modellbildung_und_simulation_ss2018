clear 
clc
%Aufgabe 2: Parameterinit fuer Simulinkmodell des Einmassenschwingers
%
%Parameter
m = 1;      %kg
c = 10;     %N/m
d = .5;     %N*s/m
F_t = 20;   %N
t_max = 10; %s
%
%Anfangsbedingungen
y0 = 0;     %m
yDot0 = 0;  %m/s
%
%rufe Simulink-Modell auf:
sim('einMassenSchwinger');
