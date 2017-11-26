%% Bearbeitungsbogen (-bearbeitung Jens Weber-)
clear all
close all
clc

%% Parameter
g = 9.81;                   % Erdbeschleunigung (m/s^2)
l = .2;                     % Laenge l (m)
AnzahlSchritte = 10e4;      % Anzahl der Zeitschritte
%h = .00001;                   % eine Periode
h = .0001;                    % stabil; sehr geringer Fehler
%h = .001;                      % instabil!
x_0 = [pi/6;0];             % Anfangsbedingungen in Zustandsvektor; x_0=[phi_0; phiDot_0]
t(1)=0;                     % Initialisierung der Zeit


x_Eu_expl(:,1) = x_0;       % Anfangsbedingungen fuer Euler explizit
x_Eu_impl(:,1) = x_0;       % Anfangsbedingungen fuer Euler implizit
x_RuKu(:,1) = x_0;          % Anfangsbedingungen fuer Runge-Kutta-Verfahren

SystMatr = [0 1 ; -g/l 0];  % Systemmatrix

for n=1:1:AnzahlSchritte % Ich muss bei 1 los laufen, da matlab Arrays ab 1 zaehlt, nicht wie ueblich bei 0!
    %% Aufgabe 3: Euler explizit
    x_Eu_expl(:,n+1) = x_Eu_expl(:,n) + SystMatr * x_Eu_expl(:,n) * h;  % In x_Eu_expl wird dynamisch immer ein Spaltenvektor [phi; phiDot] angefuegt
    %Matlab agiert immer in Zeilen, Spalten --> (:, n): Alle Zeilen, n-te
    %Spalte = Spaltenvektor
    
    %% Aufgabe 4: Euler implizit
    if det(SystMatr) == 0   %Check if euler implicit could find a solution -> SystMatr must be invertable!
        disp('The system matrix cannot be inverted! The Euler-Implicit procedure does not work!')
    else
        %x_Eu_impl(:,n+1) = x_Eu_impl(:, n)*inv((eye(2) - SystMatr * h));
        %--> geht nicht, da 2x1*2x2 
        x_Eu_impl(:,n+1) = inv((eye(2) - SystMatr * h))*x_Eu_impl(:, n);    %2x2*2x1 geht! (vgl Matrix-Rechnung!)
    end
    %% Aufgabe 5: Runge-Kutta-Verfahren
    % Ich Praediziere den Funktionswert in den k1-k4 mittels eines
    % expliziten Verfahrens (setze den "alten" Funktionswert ein, berechne
    % Steigung*Schrittweite), hier in 4 Schritten (Verfahren 4. Ordnung)
    % und setze diesen Praedizierten Funktionswert als impliziten Wert auf
    % der rechten Seite der Gleichung ein, um den "wahren" Fkt-Wert zu
    % bestimme! Dadurch wird das Verfahren genauer!
    k1(:,n) = h*SystMatr*x_RuKu(:,n);                   % SystMatr*x_RuKu --> Das ist der Zustandsuebergang!
    k2(:,n) = h*SystMatr*(x_RuKu(:,n) + k1(:,n)/2);     % Der Zustandsvektor auf 1/2 des Zeitschritts ist der "alte" ZST-Vektor + der halbe, explizit berechnete, praedizierte ZST! Die Zeit t+t/2 steckt da implizit drin! 
    k3(:,n) = h*SystMatr*(x_RuKu(:,n) + k2(:,n)/2);     % 3/4 des Zeitschritts
    k4(:,n) = h*SystMatr*(x_RuKu(:,n) + k3(:,n));       % 4/4 des Zeitschritts
    x_RuKu(:,n+1) = x_RuKu(:,n) + 1/6 * (k1(:,n) + 2*k2(:,n) + 2*k3(:,n) + k4(:,n));
    % Veranschaulichung in Aufschrieb zur Uebung!
    
    %% Allgemein: Zeitschritt in der for-Schleife
    t(n+1)= t(n)+h; %t baut sich auch dynamisch auf!
end

%% Aufgabe 2: exakte L�sung
x_exakt_Variables_1 = dsolve('D2phi + 9.81/0.2*phi = 0', 'phi(0)=pi/6', 'Dphi(0)=0');
x_exakt_sym = dsolve('D2phi + g/l*phi = 0', 'phi(0)=pi/6', 'Dphi(0)=0');
% calculate first derivative:
x_exakt_Variables_2 = diff(x_exakt_Variables_1);
    %convert symbolic function to matlab function: 
x_exakt_simpl_1 = simplify(x_exakt_Variables_1);    % Simplify
x_exakt_fun_1 = matlabFunction(x_exakt_simpl_1);    % Create evaluable function

x_exakt_simpl_2 = simplify(x_exakt_Variables_2);
x_exakt_fun_2 = matlabFunction(x_exakt_simpl_2);
    %create Solution:
x_exakt_sol =  [x_exakt_fun_1(t);x_exakt_fun_2(t)];

%% Aufgabe 6
    %Lokaler Diskredisierungsfehler:
% Differenzenquotient entspricht der (ersten) Ableitung der jeweiligen
% Funktion!
l_Eu_expl   =   x_exakt_sol(2,:) - x_Eu_expl(2,:);
l_Eu_impl   =   x_exakt_sol(2,:) - x_Eu_impl(2,:);
l_RuKu      =   x_exakt_sol(2,:) - x_RuKu(2,:);

    %Globaler Diskredisierungsfehler:
e_Eu_expl = x_exakt_sol(1,:) - x_Eu_expl(1, :); % x_Eu_expl = [phi, phiDot] --> Wir suchen den Funktionswert phi und (Zeile, Spalte), wobei die Spalten den zeitlichen Verlauf angeben (es wurden immer Spaltenvektoren angefuegt!)
e_Eu_impl = x_exakt_sol(1,:) - x_Eu_impl(1, :);
e_RuKu = x_exakt_sol(1,:) - x_RuKu(1, :);

%% Aufgabe 7: Plots - Zeitlicher Verlauf x=[phi, phiDot]
figure                                              % Erstelle neues Fenster
    
subplot(2,1,1)                                      % Erstelle 2 Subplots --> Einer fuer Vergleich des zeitl. Verlaufs des Fkt-Werts, einer fuer die Aenderung!
%Plotte:
plot(t, x_exakt_sol(1,:))
hold all                                            % Bleibe fuer alle weiteren Plots in demm Fenster!
plot(t, x_Eu_expl(1,:), 'LineStyle', '--')
plot(t, x_Eu_impl(1,:), 'LineStyle', '--')
plot(t, x_RuKu(1,:), 'LineStyle', '--')
%Beschrifte:
title('Zeitlicher Verlauf phi(t)')
xlabel('t [s]')
ylabel('Auslenkung [m]')
legend('Exakt', 'explizites Eulerverfahren', 'implizites Eulerverfahren', 'Runga-Kutta-Verfahren')
grid on                                             % Schalter Background-Grid ein

subplot(2,1,2)                                      % Gehe in zweiten Subplot
%Plotte
plot(t, x_exakt_sol(2,:))
hold on                                             % Alternative zu hold all
plot(t, x_Eu_expl(2,:), 'LineStyle', '--')
hold on
plot(t, x_Eu_impl(2,:), 'LineStyle', '--')
hold on
plot(t, x_RuKu(2,:), 'LineStyle', '--')
%Beschrifte
title('Zeitlicher Verlauf phi''(t)')
xlabel('t [s]')
ylabel('Geschwindigkeit [m/s]')
legend('Exakt', 'explizites Eulerverfahren', 'implizites Eulerverfahren', 'Runga-Kutta-Verfahren')
grid on


%% Aufgabe 8: Plots
figure

subplot(3,1,1)
plot(t, l_Eu_expl)
hold all
plot(t, e_Eu_expl)

title('Diskretisierungsfehler explizites Eulerverfahren')
xlabel('t [s]')
legend('lokal', 'global')
grid on

subplot(3,1,2)
plot(t, l_Eu_impl)
hold all
plot(t, e_Eu_impl)

title('Diskretisierungsfehler implizites Eulerverfahren')
xlabel('t [s]')
legend('lokal', 'global')
grid on

subplot(3,1,3)
plot(t, l_RuKu)
hold all
plot(t, e_RuKu)

title('Diskretisierungsfehler Runga-Kutta-Verfahren')
xlabel('t [s]')
legend('lokal', 'global')
grid on
