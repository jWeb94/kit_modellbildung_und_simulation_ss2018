%% Task 1
clear all;
close all;
clc;

%% Task 2
a = 1;
b = 2;
c = 5;

A = [1 3 7; 0 b c];
v = [1 2 3 4 5]';
w = 0:0.01:20;

I = eye(3,3);

%% Task 3
B = b*A;
C=A.^2;
D=A*I;

%% Task 4
for i=1:1:length(v)
    v(i)
end

%% Task 5
for i=1:1:length(v)
    if v(i)>=2 && v(i)<=4
        v(i)
    end
end

%% Task 6
[mittelwert,summe] = funktion(a,b,c);

%% Task 7
x = sin(w)+sqrt(w);
plot(w,x)
xlabel('w')
ylabel('x')
title('Plot')

%% single-degree-of-freedom oscillator
%% Task 1: defining parameters
m = 1;
c = 100;
d = 1;
f = 0;

%% Task 3: call function "Zustandsform"

SolverOptionen=odeset('RelTol',1e-3,'AbsTol',1e-6);

[T,Y]=ode45(@Zustandsform,[0,10],[0.01;0],SolverOptionen,m,d,c,f);


%% Task 4
plot(T,Y(:,1),'b',T,Y(:,2),'r'); 
xlabel('x-Achse')
ylabel('y-Achse')
title('Titel')

%% Task 5

m_vector = 1:1:10;
T = [];
Y = [];
for i=1:1:length(m_vector)
    m = m_vector(i);
    [T,Y]=ode45(@Zustandsform,[0:0.1:10],[0.01;0],SolverOptionen,m,d,c,f);
    Matrix(i,:) = [m, Y(:,1)'];
end
    

