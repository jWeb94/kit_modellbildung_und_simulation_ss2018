%Aufgabe 2: Einmassenschwinger
%
%Parameter:
m = 1;          %kg
c = 100;        %N/m
d = 1;          %N*s/m
tBegin = 0;     %s
tEnd = 10;      %s
%Anfangswerte:
y0 = .01;       %m
yDot0 = 0;      %m/s
%Anregung:
F_t0 = 0;        %N
%DGL loesen:
    %dsolve ist ein symbolischer Loeser, dieser gibt mir einen analytischen
    %Ausdruck aus!
SolverOptionen=odeset('RelTol',1e-3,'AbsTol',1e-6);
[t,x] = ode45(@Zustandsform,[tBegin,tEnd],[y0,yDot0],SolverOptionen,m,d,c,F_t0);
plot(t,x)
xlabel('t [s]')
ylabel('x & xDot')
title('Schwingungsanalyse Einmassenschwinger')

