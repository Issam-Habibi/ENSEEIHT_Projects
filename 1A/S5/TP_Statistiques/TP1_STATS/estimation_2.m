function [C_estime , R] = estimation_2(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_new)
n = size(C_tests,1);
p = size(x_donnees_bruitees,2);
X = repmat(x_donnees_bruitees,n,1);
Y = repmat(y_donnees_bruitees,n,1);
C_x = repmat(C_tests(:,1),1,p);
C_y = repmat(C_tests(:,2),1,p);
R_duplique = repmat(R_new,1,p); %On crée une matrice grâce à la duplication de la colonne R_new qui contient les
%valeur aléatoires du rayon qu'on a tiré .
M = (((X - C_x).^2 + (Y - C_y).^2).^1/2 - R_duplique).^2; %on remarque que le problème ici prend en compte 2 variables
% les coordonées du cercle et le rayon lui même.
Vecteur = sum(M,2);
indice = find(Vecteur==min(Vecteur));
C_estime = [C_tests(indice,1) C_tests(indice,2)];
R = R_new(indice);
end
