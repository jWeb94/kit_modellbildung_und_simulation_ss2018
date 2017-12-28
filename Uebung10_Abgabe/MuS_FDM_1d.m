function MuS_FDM_1d
%
% Modellbildung und Simulation
% Übung zum Kapitel: Zeitkontinuierliche Modelle mit verteilten Parametern
%
% Dr.-Ing. Balazs Pritz, pritz@kit.edu
%
% 1D Testfall: Konvektions-Diffusionsgleichung mit Dirichlet-Randbedingungen
%
% Diskretisierungsschema: Finite Differenzen Methode
% 
% Quelle: Joel H. Ferziger, Milovan Peric:
% Numerische Strömungsmechanik, Springer, 2008

clear all
clc

% Zeitschritt
dt = [0.0045, .00045, .00145 , .0032]; % 3. Komponente: .0145

% Maximale Anzahl von Zeitschritten
% (Simulationszeit=timestep*maxnt = dt * maxnt)
% (Es ist auch möglich, dass die Simulation nicht nur durch maxnt beendet
% wird, sondern die Änderung der Lösung von zwei Zeitschritten berechnet
% wird und anhand dieser ein Abbruchkriterium definiert wird. - das mache
% ich aber nicht!) --> Umbau auf while-Schleife und Abbruchbed. einbauen

% Variation der Anzahl an Zeitschritten, die simuliert werden sollen!
% aendere ich diese nicht, werte ich bei allen an gleich viele Stellen aus,
% das ist allerdings nicht sinnvoll, 
% maxnt=[200, 200, 200, 200]; % so war es im Mustercode
maxnt = [100, 100, 30, 40];
% maxnt = [200, 200, 400, 50];

% Alternativ können Sie die Simulationszeit definieren und maxnt ausrechnen
% lassen:
% simZeit = 2 % s
% nMax = length(dt);
% for n = 1:nMax
%     maxnt(n) = simZeit/dt(n);
%     printText = strcat('Anzahl der Schritte fuer k = ', num2str(n) , ' bei einer Simulationszeit von ', num2str(simZeit) ,' ist: ', num2str(maxnt(n)));
%     disp(printText)
% end

% Konvektionsgeschwindigkeit
%u0=1.0;  % m/s
u0 = [2, 20, 4, 4];

% Räumliche Auflösung
% Problemgebiet: x=[0,1]
%
% Es wird hier ein äquidistantes Netz verwendet.
    % 1D-Problem!
% Wenn Sie lokale Verfeinerung benutzen möchten, dann müssen Sie
% für x(i) einen Vektor definieren, und in den Gleichungen dx durch
% x(i)-x(i-1), x(i+1)-x(i) oder x(i+1)-x(i-1) ersetzen.
%
% Anzahl der Knotenpunkte --> 1D Problem - Hier wird also das Gitter definiert!
% Quasi die diskredisierung der Ortskomponente (pendant maximale Zeitschritte)
%nx = [11, 11, 11, 31]; % Aufgabenstellung
nx = [11, 11, 31, 31];  % passable Loesung fuer Pe = 40 ; 3. Komponente: 11

% Laengenparameter des Rohr: (vgl Aufgabenstellung)
L = 1; % m

for k = 1:4

    nxm1=nx(k)-1;  % Zur Definition der Zellgroesse-Matlab zaehlt von 1 an, aber wir haben 10 Zellen, 
                % also muessen wir das faelschlicher Weise als  erste Element
                % angenommene Element als nulltes Element verwenden!
    % Zellengröße
    dx=L/(nxm1);    % entspricht delta_x! - pendant zur Zeitschrittweite

    % Materialeigenschaften
    % Dichte
    % Luft
    rho=1.25;
    % Wasser
    %rho=998;

    % Diffusionskoeffizient für phi
    gamma=0.01;
    gamma = [1, 10, 0.1, 0.1];


    % Initialisierung der Funktionswertverlaufs-Speichervektoren
    phi_uds=zeros(nx(k),1);    % Upwind -> Vorwaerts ODER(!) Rueckwaertsdifferenz
    phi_cds=zeros(nx(k),1);    % Zentrale Differenzen

    % Randbedingungen für phi (Dirichlet-Randbedingung - Fkt-Werte auf dem Rand des Definitionsbereichs werden vorgegeben)
    % Upwind:
    phi_uds(1)=0;
    phi_uds(nx(k))=1;
    % Zentrale Differenzen
    phi_cds(1)=0;
    phi_cds(nx(k))=1;


    % Peclet-Zahl - Verhaeltnis advektiven und diffusiven Transportprozessen
    % Für die Änderung der Pe-Zahl können Sie natürlich beliebig rho, u oder gamma ändern
    peclet=rho*u0(k)/gamma(k);


    % Die exakte Lösung (wird mit besserer Auflösung gerechnet)
    xel=zeros(100,1);
    el=zeros(100,1);
    for i=1:100             % 99 Auswertepunkte fuer die exakte Loesung
        xel(i)=0.01*i-0.01;
        el(i)=(exp(xel(i)*peclet) - 1.)/(exp(peclet) - 1.);
    end

    % Zur Beurteilung der Stabilität wird DCFL gerechnet.
    % (Wenn Sie eine lokale Verfeinerung verwenden, müssen Sie nach dem größten Wert suchen.)
    dcfl=2*gamma(k)*dt(k)/(dx*dx*rho) + u0(k)*dt(k)/dx;


    % Die Position der Stützstellen wird berechnet
    x=zeros(nx(k),1);
    for i=1:nx(k)
        x(i)=dx*i-dx;
    end


    % Initialisierung von Vektoren - rhs = right hand side der Gleichungen (vgl Folien VL-9b)
    % Das ist quasi dPhi/dt
    rhs_uds=zeros(nx(k),1);
    rhs_cds=zeros(nx(k),1);


    % Zeitschleife
    for nt=1:maxnt(k) % 10 Zeitschritte
        % Schleife ueber alle Zellen - Ortsableitungen           
        for i=2:nxm1      % bei 2 anfangen, da ich i-1 machen muss und es kein 0tes Element gibt!
            % Konvektiver Term mit Upwind Differenzen Schema -> nur
            % rueckwartsgewandt, nicht vorwaerts!
            konv_uds=rho*u0(k)* (phi_uds(i) - phi_uds(i-1)) / (x(i) - x(i-1));

            % Konvektiver Term mit zentralem Differenzen Schema
            konv_cds=rho*u0(k)* (phi_cds(i+1) - phi_cds(i-1)) / (x(i+1) - x(i-1));

            % Diffusiver Term mit CDS
            diff_uds=gamma(k)* (phi_uds(i+1) - 2*phi_uds(i) + phi_uds(i-1)) / dx^2;
            diff_cds=gamma(k)* (phi_cds(i+1) - 2*phi_cds(i) + phi_cds(i-1)) / dx^2;


            rhs_uds(i)=diff_uds-konv_uds;
            rhs_cds(i)=diff_cds-konv_cds;

        end

        % Kalkuliere neue Werte für phi in der Zeit mit einem
        % expliziten Euler Schema --> x_n+1 = f(x_n,t_n)*h + x_n
        % d_phi/dt ist die rhs_...; phi_.. wird im jeweiligen Vektor
        % gespeichert und ist somit abrufbar. Die Initialwerte stehen schon
        % drin

        % Schleife ueber alle Zellen - Zeitableitungen
        for i=2:nxm1
            phi_uds(i)= phi_uds(i) + rhs_uds(i) * dt(k);
            phi_cds(i)= phi_cds(i) + rhs_cds(i) * dt(k);
        end

        % Simulationszeit
        zeit=nt*dt(k);     % Schrittweite dt mal Zeitschritt

        % Ergebnisse werden dargestellt
        % Nach jeder n-ten Iteration soll das Ergebnis geplottet werden
        % (werden die Ergebnisse nicht in jeder Iteration dargestellt, läuft
        % die Simulation schneller)
        n=5;
        if rem(nt,n)==0     % der Plot der erscheint wird alle 5 Schritte ueberschrieben!
            figure(1)
            subplot(2,2,k) % auskommentieren, um den zeitlichen Verlauf
            %besser sehen zu koennen! 
            % Idee: plotte zeit auf einer dritten Achse - das ist aber
            % nicht die Aufgabe gewesen und es waere relativ viel Aufwand!
            % Dafuer koennte man das Konvergenzverhalten untersuchen, was
            % ebenfalls nochmal viel Aufwand waere, wenn man da
            % gesetzmaessigkeiten erkennen will!
            plot(xel,el,'-b',x,phi_uds,'-ro',x,phi_cds,'-kx');
            xlabel('x (m)')
            ylabel('Konzentration des Stoffes')
            legend('exakt','uds','cds','Location','Eastoutside');
            axis([0 1 -0.2 1]) % insbesondere zum Parameter raus fahren wichtig, da ich sonst nicht sehe, wie gross PE und DCFL ist
            text(0.1,0.9,['Peclet-Zahl= ',num2str(peclet)]) % Wichtiger Befehl! Kannte ich noch nicht 
            text(0.1,0.85,['DCFL-Zahl= ',num2str(dcfl)])
            text(0.1,0.8,['Zeit= ',num2str(zeit)])
            %drawnow %in neuerer Version von Matlab soll diese Funktion zusätzlich benutzt werden
        end

    end
    %Ende Zeitschleife

    end
    % Ende Funktion
end

