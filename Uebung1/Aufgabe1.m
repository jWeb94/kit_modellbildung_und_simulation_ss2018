%Aufgabe1:
%
%Loesche alles was aktuell in Matlab lebt:
clear
clf %alle Graphiken loeschen
close %alle Graphikfenster schliessen
clc
%Weise die angegebenen Parameter zu:
a = 1;
b = 2;
c = 5;
A = [1 3 7; 0 b c];
v = linspace(1,5,5);
w = [0:.01:20];
I = eye(3); %Einheitsmatrix
%Berechnungen:
B = b*A;
C = power(A,2);
D = A*I;
%for-Schleife zum Ausgeben von v:
for n = 1 : length(v)
    sprintf('element %d of v is %d',n,v(n)) % %d und %s (fuer string) funktioniert genau wie in python!
end
%selbe for-Schleife, aber mit if fuer Werte im Interval [2,4]:
for n = 1 : length(v)
    if n >= 2 & n<=4
        sprintf('element %d of v is %d',n,v(n)) % %d und %s (fuer string) funktioniert genau wie in python!
    else
        sprintf('element %d is not in the desired range',n)
    end
end
%schreibe eine einfache Funktion -> diese wird hier aufgerufen!
[mittelWert,summeDerABC] = sumOfThreeValues(a,b,c);
%Berechne eine Funktion und stelle diese graphisch dar:
x = sin(w)+sqrt(w);
plot(w,x)
xlabel('Laufindex w');
ylabel('Funktionswert x');

