%La création d'une fonction qui génère une matrice de 3 dimensions (3D) ,
%c'est à dire 3 matrices dont on stocke les niveaux de gris des couleurs :
%Rouge , vert et bleu , selon leur répartition dans la matrice de Bayer . 

function image_RVB = ecriture_RVB(image_originale)
%Obtenir le nombre de lignes (n) et le nombre de colonnes(m) de la matrice
%originale . 
[n,m] = size(image_originale);  
%Initialiser une matrice contenant que des zeros , dont le nombre de lignes et
%de colonne est la moitié de la matrice originale . 
image_RVB = zeros(n/2,m/2,3);
%Remplir la matrice .
image_RVB(:,:,1) = image_originale(1:2:end,2:2:end);    %Couleur rouge
image_RVB(:,:,2) = (image_originale(1:2:end,1:2:end) + image_originale(2:2:end,2:2:end))/2; %COuleur verte
image_RVB(:,:,3) = image_originale(2:2:end,1:2:end);   %Couleur blue;


 