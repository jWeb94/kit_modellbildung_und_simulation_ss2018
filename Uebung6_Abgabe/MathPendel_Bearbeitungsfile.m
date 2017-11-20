%% Bearbeitungsbogen (-zu bearbeiten-)
clear all
close all
clc

%% Parameter
g = 'ausf�llen';   %% Erdbeschleunigung
l = 'ausf�llen';   %% L�nge l
AnzahlSchritte = 'ausf�llen';      %% Anzahl der Zeitschritte
h = 'ausf�llen';                  %% Zeitschrittweite
x_0 = 'ausf�llen';            %% Anfangsbedingungen in Zustandsvektor
t(1)='ausf�llen';                     %% Initialisierung der Zeit


x_Eu_expl(:,1) = 'ausf�llen';       %% Anfangsbedingungen f�r Euler explizit
x_Eu_impl(:,1) = 'ausf�llen';       %% Anfangsbedingungen f�r Euler implizit
x_RuKu(:,1) = 'ausf�llen';          %% Anfangsbedingungen f�r Runge-Kutta-Verfahren

SystMatr='ausf�llen';          %% Systemmatrix
  


for n = 'ausf�llen'
    %% Aufgabe 3: Euler explizit
    x_Eu_expl(:,n+1)='ausf�llen';
       
    %% Aufgabe 4: Euler implizit
    x_Eu_impl(:,n+1) ='ausf�llen';
    
    %% Aufgabe 5: Runge-Kutta-Verfahren    
    k1(:,n)='ausf�llen';
    k2(:,n)='ausf�llen';
    k3(:,n)='ausf�llen';
    k4(:,n)='ausf�llen';
    x_RuKu(:,n+1) = 'ausf�llen';
    
    t(n+1)='ausf�llen';
end

%% Aufgabe 2: exakte L�sung
x_exakt = 'ausf�llen';

%% Aufgabe 6

l_Eu_expl = 'ausf�llen';
l_Eu_impl = 'ausf�llen';
l_RuKu = 'ausf�llen';

e_Eu_expl = 'ausf�llen';
e_Eu_impl = 'ausf�llen';
e_RuKu = 'ausf�llen';

%% Aufgabe 7: Plots
'ausf�llen';

%% Aufgabe 8: Plots
'ausf�llen';