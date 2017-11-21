%% Bearbeitungsbogen (-zu bearbeiten-)
clear all
close all
clc

%% Parameter
g = 9.81;                   % Erdbeschleunigung (m/s^2)
l = .2;                     % Laenge l (m)
AnzahlSchritte = 10e4;      % Anzahl der Zeitschritte
h = .001;                   % Zeitschrittweite
x_0 = [pi/6;0];             % Anfangsbedingungen in Zustandsvektor; x_0=[phi_0; phiDot_0]
t(1)=0;                     % Initialisierung der Zeit


x_Eu_expl(:,1) = x_0;       % Anfangsbedingungen fuer Euler explizit
x_Eu_impl(:,1) = x_0;       % Anfangsbedingungen fuer Euler implizit
x_RuKu(:,1) = x_0;          % Anfangsbedingungen fuer Runge-Kutta-Verfahren

SystMatr = [0 1 ; -g/l 0];  % Systemmatrix
    %% Aufgabe 2: Analytische Loesung der linearisierten DGL:
y=dsolve('D2phi + g/l*phi = 0', 'phi(0)=pi/6', 'Dphi(0)=0')
yValues=dsolve('D2phi + 9.81/0.2*phi = 0', 'phi(0)=pi/6', 'Dphi(0)=0')


for n = AnzahlSchritte
    %% Aufgabe 3: Euler explizit
    x_Eu_expl(:,n+1) = x_Eu_expl(n) + SystMatr*(SystMatr*x_Eu_expl(n)*h)*h;    % In x_Eu_expl wird dynamisch immer ein Spaltenvektor [phi; phiDot] angefuegt
       
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