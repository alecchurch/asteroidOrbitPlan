%% Part 1.a
% Alec Church
% 04/09/22
% A function to read and plot an OBJ file specifying the target asteroid.
function [vert,face] = plot_OBJ()
%Read in the .obj file
obj = readObj('Preliminary_Bennu.obj');
%Save vertices 
vert = obj.v;
%Save faces
face = obj.f.v;
%Use patch() to plot vertices and faces
figure(1)
hold on
patch('Faces',face,'Vertices',vert,'FaceColor','black','EdgeColor','blue','LineWidth',0.001);
view(3)
title('Bennu')
end