clear all; close all; clc

%% Parameter
L = 100;                        %% cm
% AnzahlElemente = 10;
% AnzahlElemente = 100;
AnzahlElemente = 10000;
LElemente = L/AnzahlElemente;   %% Laenge eines Elementes
Knoten = 0:L/AnzahlElemente:L;  %% Knotenvektor
AElement = (10-0.09*Knoten);    %% Querschnittsverlauf

F = 20000;                      %% N
E = 70*10^9;                    %% Pa (N/m^2)

%% Aufgabe 2: Analytische L�sung
% Berechne Symbolisch
u_exakt_symbolisch = dsolve('Du=F/(E*(10-0.09*x))', 'u(0)=0', 'x');
u_exakt_werte = dsolve('Du=20000/(70*10^9*(10-0.09*x))', 'u(0)=0', 'x')
% Umschreiben in Matlab-Funktion
u_exakt_werte = simplify(u_exakt_werte);
u_exakt_werte = matlabFunction(u_exakt_werte);
% Berechnen der realen Verschiebungspunkte fuer Plot
x_exakt = 0:.0001:L;
u_exakt = u_exakt_werte(x_exakt);

% Spannung:
sigma_exakt = F./(10-0.09*x_exakt);
% Visualisierung der realen Loesung
yyaxis left
[ax, h1, h2] = plotyy(x_exakt,u_exakt,x_exakt, sigma_exakt)
hold on 
set(get(ax(1),'Ylabel'),'String','u [cm]')
set(get(ax(2),'Ylabel'),'String','sigma [n/mm^2]')
xlabel('x [cm]')
title('Exakte Loesung')

%% Aufgabe 3: Formfunktion N & A_mittel

% Erstelle Funktionen(!) zur Berechnung der Veschiebung
% N=sym(zeros(1,2));         % Erstelle leere mathematisch-symbolische Matrix N(x_i)
% N(1,1) = @(x) (1-x/LElemente);      % so erstellt man in Matlab funktionen -> ein Aufruf mit x=0:.1:1 und N(x) ergaebe eine Wertetabelle!
% N(1,2) = @(x) (x/LElemente);        % in matlab nennt man diese
%                                     % Funktionsdefinitionen auf der lhs 'function handle'
% Funktioniert aber nicht mit meiner Variante - N ist nur Symbolisch!
% N(1) liefert 1-x/10, da N als Symbol angesehen wird!

% Mehr dazu in Matlab-Doku Symbolic Math Toolbox

%syms N     % erstellt sym (symbolische Variable)
syms N(x)   % erstellt Symfun
N(x) = [1 - x/LElemente, x/LElemente];
% Liesse sich dynamisch erweitern mit N(x) = [N(x), N(x)];
% N(1) liefert den Wert fuer [1-1/10 1/10]

% Berechnung der mittleren Querschnittswerte
for k = 1:length(Knoten)-1
    A_mittel(k) = (AElement(k)+AElement(k+1))/2;
end

%% Aufgabe 4: B und D
% B
syms B(x)           % symfun, da (x)     
B = diff(N,x);

% D
D = E;                  % Da u_i_approx bei uns nur ein Skalar ist -> keine Matrix

% man koennte jetzt mit den Formeln fuer Sigma und Epsilon die Spannung und
% Dehnung an den Enden der jeweiligen finiten Elementen ausrechnen!
% allerdings in den Elementkoordinaten!!!
% um das eleganter zu gestalten transformieren wir in globale Koordinaten
% und rechnen dann die Spannungen an den Raendern aus!

%% Aufgabe 5:
for b=1:AnzahlElemente           %% Schleife fuer die Anzahl an gewaehlten Elementen
   K{b} = B(x)' * D * B(x) * A_mittel(b) * LElemente;
end

%% Aufgabe 6
%% KGesamt
KGesamt = zeros(length(Knoten),length(Knoten));
for b=1:length(K)
    
    KGesamt(b:b+1,b:b+1) = KGesamt(b:b+1,b:b+1)+K{b};
end

%% Aufgabe 7

% Randbedingungen:
fb = [zeros(size(KGesamt,2)-2,1); F];   % Mappe F fuer das letzte Element auf die Matrixgroesse
ua = 0;                                 % An der Einspannung habe ich keine Verschiebung - kinematische Abhaengigkeit
% Gesamtsteifigkeitsmatrix-Elemente (vgl Skript S. 81)
Kaa = KGesamt(1,1);                     % K11 ist das Matrixelement, das nur auf u_a einfluss hat; Abh. f_a von u_a
Kab = KGesamt(1,2:end);                 % Abhaengigkeit f_a von u_b
Kba = KGesamt(2:end,1);                 % Abhaengigkeit f_b von u_a
Kbb = KGesamt(2:end,2:end);             % K22 ist das Matrixelement, das nur auf u_b (unbekannt) auswirkung hat; Abh. f_b von u_b 

%% Aufgabe 8

% Berechnung der unbekannten Kraefte und Verschiebungen -> loesen des
% aufgestellten Gleichungssystems
ub = Kbb \ (fb - Kba * ua);             % vgl Formel im Skript nur umgestellt - Matlab invertiert Matrix automatisch!
ub_ref = inv(Kbb)*(fb - Kba * ua);      % die inverse Matrix ist der rechenaufwendige Teil!
fa = Kaa * ua + Kab * ub;

% zusammenfuegen zu vollstaendigen Vektoren (f=Kraftvektor; u=Verschiebungsvektor)
f = [fa; fb];
U = [ua; ub];

% Verschiebung bei x = L
disp(['Verschiebung bei x=L: U(L) = ' num2str(U(end)) ' cm']);

% Spannungsverlauf numerisch approximiert
sigma_FEM = zeros(length(U)-1,1);

for b = 1:length(U)-1
    
    sigma_FEM(b) = D * double(B) * [U(b); U(b+1)];
end

% Visualisierung
figure
stairs(Knoten,U)
hold all
plot(x_exakt, u_exakt);
legend('exakte Loesung', 'FEM-Loesung')
xlabel('x [cm]')
ylabel('u [cm]')
title('Verschiebung')

% 
figure;
plot(x_exakt, sigma_exakt)
hold all
stairs(Knoten(1:end-1), sigma_FEM)
title('Spannung')
xlabel('x [cm]')
ylabel('sigma [Pa]')
legend('exakte Loesung', 'FEM-Loesung')
