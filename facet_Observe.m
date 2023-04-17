% Alec Church
% 04/09/22
function [observable,elevationAngle,cameraAngle] = facet_Observe(rACAF,facetNumber,face,vert)
format long
FOV = 15 * (pi/180); %viewing angle
elevation15 = 15 * (pi/180); %elevation angle
vertices = face(facetNumber,:); %get vertices corresponding to face 1
p1 = vert(vertices(1),:); % xyz for vertex 1 of face 1
p2 = vert(vertices(2),:); % xyz for vertex 2 of face 1
p3 = vert(vertices(3),:); % xyz for vertex 2 of face 1
pAv = (p1 + p2 + p3)/3; % center of face
pr1 = p2 - p1; % point 1 to 2 
pr2 = p3 - p1; % point 1 to 3
normal = cross(pr1,pr2); % normal vector of face
r_Obs = rACAF - pAv; % vector from satellite to center of face 

elevationAngle = pi/2 - acos( dot(r_Obs,normal) / (norm(r_Obs)*norm(normal)) );
cameraAngle = acos( dot(r_Obs,rACAF) / (norm(r_Obs)*norm(rACAF)) );

H = ceil(dot([-1 0 0],pAv));

if (cameraAngle <= FOV) && (elevationAngle >= elevation15) && (H == 1)
    observable = 1;
else
    observable = 0;
end

end