%Zu Aufgabe 2:
function dgl = Zustandsform(t,x,m,d,c,F)
    %dgl = m*yDotDot+d*yDot+c*y-F;
    dgl = [x(2);-(c/m)*x(1)-d/m*x(2)-F/m];
end
    