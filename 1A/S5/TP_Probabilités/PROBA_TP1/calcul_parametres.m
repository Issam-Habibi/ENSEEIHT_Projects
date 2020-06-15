%Calcul du coefficient de corrélation (r) et des paramètres de droite de
%régression (a,b).
function [r,a,b] = calcul_parametres(X,Y)
%La multiplication termes de X par les termes de Y.
C = X.*Y; 
%la fonction mean calcule la moyenne d'un vecteur.
Covariance = mean(C) - (mean(X)*mean(Y));
%Le carré des termes de X et de Y
A = X.^2;
B = Y.^2;
%Le calcule des variances et des écarts types .
Variance_X = mean(A) - (mean(X)*mean(X));
Variance_Y = mean(B) - (mean(Y)*mean(Y));
Ecart_Type_X = sqrt(Variance_X);
Ecart_Type_Y = sqrt(Variance_Y);
Ecart_Type_XY = Ecart_Type_X * Ecart_Type_Y;
%le calcules des paramètres cherchés .
r = Covariance/Ecart_Type_XY;
a = Covariance/Variance_X;
b = -(Covariance*mean(X))/Variance_X + mean(Y);
%Remarque : On va considérer les paires oubien les couples des niveaux de
%gris obtenus grâce au couple [X,Y] et les représenter sous forme de nuage
%de points , puis on va chercher la droite (y = ax + b) la plus proche de ces couples
%(modèle de régression)dont le paramètre b est considéré comme un terme
%'d'erreur ' . Cette droite décrit donc la tendance de ce nuage de points
%et on s'attend bien à ce qu'elle traverse tout le nuage ce qu'on peut
%remarquer dans le graphe . 