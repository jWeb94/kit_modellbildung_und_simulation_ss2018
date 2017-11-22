%% Bearbeitungsbogen (-freiwillig Jens Weber-)
clear all
close all
clc

%% Parameter

% Systemparameter:
m1 = .5; % kg
m2 = .5; % kg

c1 = 500; % N/m
c2 = 500; % N/m
c3 = 500; % N/m

n_max = 10e4;   % Schritte
h = .0001;      % Schhrittweite

%% Systemmatrix - vgl Aufschrieb
A = [0              1   0               0;
    -(c1+c2)/m1     0   c2/m1           0;
    0               0   0               1;
    c2/m2           0   -(c2+c3)/m2     0];

%% Anfangsbedingungen            

% Zeit:
t = 0;     % s

% Anfangsauslenkung:
x_10        = .01;   % m
x_20        = .01;   % m
% Anfangsgeschwindigkeit:
xDot_10     = 0;     % m/s
xDot_20     = 0;     % m/s

% Anfangswerte fuer Heun: 
x_Heun(:,1) = [x_10; xDot_10; x_20; xDot_20]; 

%% Aufgabe 2: Eigenwerte
[Eigenvektoren, Eigenwerte] = eig(A); % Achtung: Eigenwerte-Matrix hat die tatsaechlichen Eigenwerte auf der Diagonalen!
% Eigenvektoren-Matrix enthaelt die Eigenvektoren spaltenweise, sodass
% gilt: A*Eigenvektoren = Eigenvektoren*Eigenwerte (jeweils die Matrizen!)

% Interpretation bezueglich Eigenschwingungsformen: 
    % ..

%% Aufgabe 3: Verfahren von Heun            
for n = 1:1:n_max
    % explizite Praediktion:
    k1(:,n) = h*(A*x_Heun(:,n));
    k2(:,n) = h*(A*(x_Heun(:,n) + k1(:,n)));
    % approximierter Funktionswert: 
    x_Heun(:,n+1) = x_Heun(:,n) + 1/2*(k1(:,n)+k1(:,n));
    
    %Zeitschritt:
    t(n+1) = t(n) + h;
    lastTime = t(n+1);
end

figure()
subplot(3,1,1)
plot(t,x_Heun(1,:))
title('Zeitlicher Verlauf Auslenkung x1')
xlabel('t [s]')
ylabel('Auslenkung [m]')
grid on   

subplot(3,1,2)
plot(t,x_Heun(3,:))
title('Zeitlicher Verlauf Auslenkung x2')
xlabel('t [s]')
ylabel('Auslenkung [m]')
grid on 

subplot(3,1,3)
plot(t,x_Heun(1,:))
hold all
plot(t,x_Heun(3,:), 'LineStyle', '--')
title('Vergleich x1 und x2')
xlabel('t [s]')
ylabel('Auslenkung [m]')
legend('x1', 'x2')
grid on

%% Aufgabe 5: Berechnung der Eigenfrequenz bei zunehmdener Federsteifigkeit
    % Berechnung:
maxC = 10;
for c_Faktor = 1:1:maxC
    B = A*c_Faktor;                                          % Ich kann einfach die Matrix A mit einem Faktor skallieren, da alle Federn gleichermassen skalliert werden (lt. Aufgabe) und alle Elemente von A in denen kein c im Zaehler steht 0 sind! (Sieht man, wenn man sich A genau anschaut!)
    [Eigenvektoren, Eigenwerte] = eig(B);
    omega = abs(Eigenwerte * ones(4,1));                    % vgl Hinweis bei der Aufgabenstellung; 1-Vektor, um die Elemente aus der Eigenwerts-Diagronalmatrix zu extrahieren!
    omega_short(:,c_Faktor) = [omega(1,1) ; omega(3,1)];    % bestimme die Betraege der Eigenwerte die zur x1 und x2 - Koordinate gehoeren! --> vgl ZST-Vektor!   
    %Die laufenden Eigenfrequenzen werden als Spaltenvektoren in
    %omega_short gespeichert! c_Faktor ist unser Laufindex 
    Factors(c_Faktor) = c_Faktor*c1;   % Sichere die Federsteifigkeiten --> c1, da alle cs gleich sind spielt das keine Rolle!
end
% Warum treten zwei Eigenfrequenzen auf? 

    %..???

    % Visualisierung:
figure()
plot(Factors, omega_short(1,:), '-r');
hold on
plot(Factors, omega_short(2,:), '--b');
grid on
legend({'omega_1', 'omega_2'});
xlabel('Federsteifigkeiten [N/m]');
ylabel('omega');
title('Eigenfrquenzen');

%% Simulink Referenz-Modell:

    % Frage
        %Warum passt es nicht? Und ist mein Steifigkeitsverlauf richtig? 

sim('schwingerkette')

    % Visualisierung des Vergleichs: 
figure()
subplot(2,1,1)
plot(t, x_Heun(1,:))
hold on
plot(tout, x1Simulink, 'LineStyle', '--')
title('Vergleich x1 Simulink und eigene Implementierung')
xlabel('t [s]')
ylabel('Auslenkung x1')
legend('x1','x1-Simulink')

subplot(2,1,2)
plot(t, x_Heun(3,:))
hold on
plot(tout, x2Simulink, 'LineStyle', '--')
title('Vergleich x2 Simulink und eigene Implementierung')
xlabel('t [s]')
ylabel('Auslenkung x2')
legend('x2','x2-Simulink')
