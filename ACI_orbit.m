% Alec Church
% 04/09/22
function [x,OE,t] = ACI_orbit(tspan,x0)
options = odeset('RelTol',1e-10,'AbsTol',1e-10);
[t,x] = ode45(@(t,x) prop_Orbit(t,x),tspan,x0,options);
OE = calcOE(x);
end