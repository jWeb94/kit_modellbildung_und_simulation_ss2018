%% Bearbeitungsbogen (-zu bearbeiten-)
clear all
close all
clc

%% Parameter
g = 'ausfüllen';   %% Erdbeschleunigung
l = 'ausfüllen';   %% Länge l
AnzahlSchritte = 'ausfüllen';      %% Anzahl der Zeitschritte
h = 'ausfüllen';                  %% Zeitschrittweite
x_0 = 'ausfüllen';            %% Anfangsbedingungen in Zustandsvektor
t(1)='ausfüllen';                     %% Initialisierung der Zeit


x_Eu_expl(:,1) = 'ausfüllen';       %% Anfangsbedingungen für Euler explizit
x_Eu_impl(:,1) = 'ausfüllen';       %% Anfangsbedingungen für Euler implizit
x_RuKu(:,1) = 'ausfüllen';          %% Anfangsbedingungen für Runge-Kutta-Verfahren

SystMatr='ausfüllen';          %% Systemmatrix
  


for n = 'ausfüllen'
    %% Aufgabe 3: Euler explizit
    x_Eu_expl(:,n+1)='ausfüllen';
       
    %% Aufgabe 4: Euler implizit
    x_Eu_impl(:,n+1) ='ausfüllen';
    
    %% Aufgabe 5: Runge-Kutta-Verfahren    
    k1(:,n)='ausfüllen';
    k2(:,n)='ausfüllen';
    k3(:,n)='ausfüllen';
    k4(:,n)='ausfüllen';
    x_RuKu(:,n+1) = 'ausfüllen';
    
    t(n+1)='ausfüllen';
end

%% Aufgabe 2: exakte Lösung
x_exakt = 'ausfüllen';

%% Aufgabe 6

l_Eu_expl = 'ausfüllen';
l_Eu_impl = 'ausfüllen';
l_RuKu = 'ausfüllen';

e_Eu_expl = 'ausfüllen';
e_Eu_impl = 'ausfüllen';
e_RuKu = 'ausfüllen';

%% Aufgabe 7: Plots
'ausfüllen';

%% Aufgabe 8: Plots
'ausfüllen';