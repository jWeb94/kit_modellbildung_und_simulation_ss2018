%Aufgabe 2: Einmassenschwinger-Massenanalyse
%
%Parameter:
c = 100;        %N/m
d = 1;          %N*s/mM
tBegin = 0;     %s
tEnd = 10;      %s
%Anfangswerte:
y0 = .01;       %m
yDot0 = 0;      %m/s
%Anregung:
F_t0 = 0;       %N
%DGL loesen:
M = [];         %Erstelle leere Matrix zum Abspeichern der Werte!
solverOptionen=odeset('RelTol',1e-3,'AbsTol',1e-6);
for m = 1 : 1 :10       %Iteriere ueber die Masse mit (aktuell) dem Stufensprung 1 kg
    [t,x] = ode45(@Zustandsform,[tBegin:0.1:tEnd],[y0,yDot0],solverOptionen,m,d,c,F_t0); %Setze die konstante Schrittweite im Zeitvektor fuer den ODE45, dann macht dieser eine konstante Schrittweite!
    M = [M ; m , x(:,2)'];
    plot(t,x)
    hold on
end

%plot(t,x)
%xlabel('t [s]')
%ylabel('x & xDot')
%title('Schwingungsanalyse Einmassenschwinger')
