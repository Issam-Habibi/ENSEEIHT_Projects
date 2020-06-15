%La vectorisation de la matrice I . 
function [X,Y] = vectorisation(I)
%Obtenir le nombre de lignes et de colonnes de I.
[n,m] = size(I);
%La matrice I sauf la dernière colonne .
Z = I(:,1:m-1);
% La matrice I sauf la première colonne . 
U = I(:,2:m);
%Concatenation des colonnes de Z.
X = Z(:);
%Concatenation des colonnes de U.
Y = U(:);