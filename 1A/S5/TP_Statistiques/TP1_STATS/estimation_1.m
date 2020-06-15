function C_estime = estimation_1(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_0)
n = size(C_tests,1);
p = size(x_donnees_bruitees,2);
X = repmat(x_donnees_bruitees,n,1); %On duplique les lignes de ces vecteurs n fois
Y = repmat(y_donnees_bruitees,n,1);
C_x = repmat(C_tests(:,1),1,p);    %On duplique la première colonne de C_tests p fois
C_y = repmat(C_tests(:,2),1,p);    %On duplique la deuxième colonne de C_tests p fois.
M = (((X - C_x).^2 + (Y - C_y).^2).^1/2 - R_0).^2; %La création d'une matrice contenant les distances.
Vecteur = sum(M,2);  %Sommer les termes de chaque colonnes de cette matrice dans une seul colonne . 
indice = find(Vecteur==min(Vecteur)); %indice est un vecteur contenant un seul element , c'est l'indice de 
%l'élément contenant la somme minimale dans le vecteur Vecteur .
C_estime = [C_tests(indice,1) C_tests(indice,2)]; %C_estime contient les coordonées du centre de cerle
%pour le quelle la somme est minimale . 
end
