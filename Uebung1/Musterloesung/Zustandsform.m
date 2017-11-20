function dy = Zustandsform(t,y,m,d,c,f)

dy = zeros(2,1);

dy(1) = y(2);
dy(2) = (f-d*y(2)-c*y(1))/m;

end

