% Alec Church
% 04/09/22
% progate orbit with SRP perturbations and compute orbit elements and
% position and velocity vectors in ACI at a given time 't'.
function [Xout] = prop_Orbit(t,x)
mu = 4.892*10^-9;
p_SR = 4.57*10^-3; % W*s/m^3 solar pressure
m_SAT = 1000; % kg
A = 5*10^(-6); % km^2
C_R = 1.2; % coefficient of reflectivity

r = norm(x(1:3)); % normalize position vector for r
v = norm(x(4:6));
rddot = mu .* -x(1:3) / r^3; % calculate change in velocity 
a_SRP = (p_SR * C_R * A * [-1 0 0]) / (m_SAT * [-1 0 0]); % calculate solar pressure
rddot(1) = rddot(1) + a_SRP; % add acceleration due to solar pressure in x direction
Xout = [x(4:6);rddot]; % output position and velocity
