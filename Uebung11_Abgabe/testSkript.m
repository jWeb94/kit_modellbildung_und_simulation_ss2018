%% Test A2:
% 
L = 100;
F = 20000;                      %% N
E = 70*10^9; 
u_exakt_symbolisch = dsolve('Du=F/(E*(10-0.09*x))', 'u(0)=0', 'x');
u_exakt_werte = dsolve('Du=20000/(70*10^9*(10-0.09*x))', 'u(0)=0', 'x')
% Umschreiben in Matlab-Funktion
% u_exakt_werte = simplify(u_exakt_werte);
% u_exakt_werte = matlabFunction(u_exakt_werte);
% % Berechnen der realen Verschiebungspunkte fuer Plot
% x_exakt = 0:.0001:L;
% u_exakt = u_exakt_werte(x_exakt);
% 
% % Spannung:
% sigma_exakt = F./(10-0.09*x_exakt);
% % Visualisierung der realen Loesung
% yyaxis left
% [ax, h1, h2] = plotyy(x_exakt,u_exakt,x_exakt, sigma_exakt);    % generiere Handles fuer die Achsen und Linien
% % Stelle Achenparameter ein
% set(get(ax(1),'Ylabel'),'String','Verschiebung')
% set(get(ax(2),'Ylabel'),'String','Spannung')
% title('Exakte Loesung')

% Aufgabe 3:
clear
clc
L = 100;                        %% cm
AnzahlElemente = 10;
LElemente = L/AnzahlElemente;   %% Laenge eines Elementes
Knoten = 0:L/AnzahlElemente:L;  %% Knotenvektor
AElement = (10-0.09*Knoten);    %% Querschnittsverlauf

F = 20000;                      %% N
E = 70*10^9;                    %% Pa (N/m^2)

syms x
N=sym(zeros(2,AnzahlElemente));         % Erstelle leere mathematisch-symbolische Matrix N(x_i)

for i=1:AnzahlElemente
    N(1,i) = @(x) (1-x/LElemente);      % so erstellt man in Matlab funktionen -> ein Aufruf mit x=0:.1:1 und N(x) ergaebe eine Wertetabelle!
                                        % in matlab nennt man diese
                                        % Funktionsdefinitionen auf der lhs 'function handle'
end
for j=1:AnzahlElemente
    N(2,j) = @(x) (x/LElemente);
end

% Berechnung der mittleren Querschnittswerte:
for k = 1:length(Knoten)-1
    A_mittel(k) = (AElement(k)+AElement(k+1))/2;
end

%% Aufgabe 4

% B
B = diff(N);

% D
D = E;  




