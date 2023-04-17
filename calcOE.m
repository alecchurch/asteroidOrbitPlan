% Alec Church
% 04/09/22
function OE = calcOE(x)

for j = 1:length(x)
    
    mu = 4.892*10^-9;
    r = norm(x(j,1:3));
    v = norm(x(j,4:6));
    h = cross(x(j,1:3),x(j,4:6));
    a(j) = -mu/(2*(v^2/2 - mu/r));
    i(j) = acos(h(3)/norm(h));
    evec = cross(x(j,4:6),h)/mu - x(j,1:3)/r;
    e(j) = norm(evec);
    n = cross([0 0 1],h);
    Omega(j) = acos(n(1)/norm(n));
    if n(2) < 0
        Omega(j) = Omega(j) + pi;
    end
    
    omega(j) = acos((dot(n,evec)/(norm(n)*norm(evec))));
    if evec(3) < 0
        omega(j) = omega(j) + pi;
    end
    
    theta(j) = acos(dot(x(j,1:3),evec) /(e(j)*r));
    if dot(x(j,1:3),x(j,4:6)) < 0
        theta(j) = 2*pi - theta(j);
    end
    
    OE(j,1:6) = [a(j) e(j) i(j) omega(j) Omega(j) theta(j)];
end

end