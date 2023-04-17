% Alec Church
% Proj 01 Main
% 04/09/22
%

%% Part 1.a
[vert,face] = plot_OBJ();

%% Part 1.b
t0 = 0;
tf = 30*3600;
tspan = t0:60:tf;
mu = 4.892*10^-9; 
x0 = [0 -1 0 0 0 sqrt(mu)]'; 
[x,oe] = ACI_orbit(tspan,x0);
% fprintf('%d \n',x)
% fprintf('%d \n',oe)

%% Part 1.c
rACAF = [0 1 0];
facetNumber = 1;
[observable,elevationAngle,cameraAngle] = facet_Observe(rACAF,facetNumber,face,vert);
% fprintf('%d \n',observable)
% fprintf('%d \n',elevationAngle)
% fprintf('%d \n',cameraAngle)
rACAF = [0 -1 0];
[observable,elevationAngle,cameraAngle] = facet_Observe(rACAF,facetNumber,face,vert);
% fprintf('%d \n',observable)
% fprintf('%d \n',elevationAngle)
% fprintf('%d \n',cameraAngle)

%% Part 1.d
P = 3600 * 4.297461;

tspan = 0:60:(3600*24*7);

x0 = [0 1 0 0 0 sqrt(mu)]';
[x1,oe1,t1] = ACI_orbit(tspan,x0);
figure(1)
axis equal
hold on
plot3(x1(:,1),x1(:,2),x1(:,3));

x0 = [0 1 0  0 0 sqrt(mu/2)]';
[x2,oe2t,t2] = ACI_orbit(tspan,x0);
figure(1)
hold on
plot3(x2(:,1),x2(:,2),x2(:,3));
legend('Bennu','X1','X2')

for i = 1:length(x1)
    rACAF = x1(i,1:3);
    facetNumber = 1;
    [observable,elevationAngle,cameraAngle] = facet_Observe(rACAF,facetNumber,face,vert);
    if observable == 1
        view_T1(i) = t1(i);
        elevationAngle_T1(i) = elevationAngle;
        cameraAngle_T1(i) = cameraAngle;
    else 
        view_T1(i) = 0;
        elevationAngle_T1(i) = 0;
        cameraAngle_T1(i) = 0;
    end  
end
% fprintf('%d \n',view_T1)
% fprintf('%d \n',elevationAngle_T1)
% fprintf('%d \n',cameraAngle_T1)


for i = 1:length(x2)
    rACAF = x2(i,1:3);
    facetNumber = 1;
    [observable,elevationAngle,cameraAngle] = facet_Observe(rACAF,facetNumber,face,vert);
    if observable == 1
        view_T2(i) = t2(i);
        elevationAngle_T2(i) = elevationAngle;
        cameraAngle_T2(i) = cameraAngle;
    else 
        view_T2(i) = 0;
        elevationAngle_T2(i) = 0;
        cameraAngle_T2(i) = 0;
    end  
end
% fprintf('%d \n',view_T2)
% fprintf('%d \n',elevationAngle_T2)
% fprintf('%d \n',cameraAngle_T2)

%% 2
[vert,face] = plot_OBJ();
tspan = [0:60:7*24*3600];
mu = 4.892*10^-9; 
target = load('Target_list.mat');
target = target.targets;

x01 = [0 -1 0 0 0 sqrt(mu)]';
% x02 = [0 1 0 0 0 sqrt(mu)]';
[x1,oe1,t1] = ACI_orbit(tspan,x01);
% [x2,oe2,t2] = ACI_orbit(tspan,x02);

[x_b1] = inertialtobody(t1,x1);
% [x_b2] = inertialtobody(t2,x2);
figure(1)
plot3(x_b1(:,1),x_b1(:,2),x_b1(:,3));
% plot3(x_b2(:,1),x_b2(:,2),x_b2(:,3));

targetFace = face(target,:);
targetVert = [vert(targetFace(:,1)) vert(targetFace(:,2)) vert(targetFace(:,1))];
% scatter3(targetVert(:,1),targetVert(:,2),targetVert(:,3));

for i = 1:length(t1)
    for j = 1:length(target)
        [observable(i,j),elevationAngle(i,j),cameraAngle(i,j)] = facet_Observe(x_b1(i,1:3),target(j),face,vert);
    end
end