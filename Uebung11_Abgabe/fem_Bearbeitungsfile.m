clear all; close all; clc

%% Parameter
L = 'ausf�llen';
AnzahlElemente = 'ausf�llen';
LElemente = L/AnzahlElemente;   %% L�nge eines Elemntes
Knoten = 0:L/AnzahlElemente:L;  %% Knotenvektor
AElement = (10-0.09*Knoten);    %% Querschnittsverlauf
%% Aufgabe 2: Analytische L�sung
'ausf�llen'

%% Aufgabe 3: Formfunktion N
N = 'ausf�llen'

%% Aufgabe 4: B und D
% B
B = 'ausf�llen'

% D
D = 'ausf�llen'

%% Aufgabe 5:
for b='ausf�llen'           %% Schleife f�r die Anzahl an gew�hlten Elementen
   K{b} = 'ausf�llen'
end

%% Aufgabe 6
%% KGesamt
KGesamt = zeros(length(Knoten),length(Knoten));
for b='ausf�llen'
    KGesamt(b:b+1,b:b+1) = KGesamt(b:b+1,b:b+1)+K{b};
end

%% Aufgabe 7
fb = 'ausf�llen';
ua = 'ausf�llen';

Kaa = 'ausf�llen';
Kab = 'ausf�llen';
Kba = 'ausf�llen';
Kbb = 'ausf�llen';

ub = 'ausf�llen';
fa = 'ausf�llen';

%% Aufgabe 8
'ausf�llen'