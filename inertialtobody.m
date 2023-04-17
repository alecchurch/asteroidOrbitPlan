function [x_b] = inertialtobody(t,x)
T = 4.297461*3600;
o = 2*pi/T;
psi = o.*t;
for i = 1:length(psi)
    R3 = [cos(psi(i)) -sin(psi(i)) 0;...
        sin(psi(i)) cos(psi(i)) 0;...
        0 0 1];
    x_b(i,1:3) = x(i,1:3) * R3;
end
end