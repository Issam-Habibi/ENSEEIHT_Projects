function [C_x,C_y,M] = matrice_inertie(E_x,E_y,G_norme_E)
P = sum(G_norme_E); %Calcule de coefficient Pi de l'énoncé.
C_x = 1/P * sum(E_x.*G_norme_E);
C_y = 1/P * sum(E_y.*G_norme_E);
M = zeros(2,2); %Initialisation de la matrice d'inertie de taille 2x2.
M(1,1) = 1/P * sum( ((E_x-C_x).^2).*G_norme_E ); %premier élément de la diagonale . 
M(2,2) = 1/P * sum( ((E_y-C_y).^2).*G_norme_E ); %deuxième élément de la diagonale
M(1,2) = 1/P * sum ( ((E_x-C_x).*(E_y-C_y)).*G_norme_E);
% La matrice d'inertie est symétrique donc
M(2,1) = M(1,2);
end