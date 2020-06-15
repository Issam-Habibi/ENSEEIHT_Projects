function bornes = partitionnement(selection_frequences);
n = length(selection_frequences);
%le nombre de colonnes de la matrice bornes correspond au nombre de lettres
%du texte , son nombre de lignes est fixé à 2 car chaque lettre est encodée
%par un intervalle [a,b[ dont on tire les éléments a et b et on les
%insèrent comme une colonne de la matrice . 
bornes = zeros(2,n);
%On traite le cas de la première lettre . 
bornes(1,1) = 0;
bornes(2,1) = selection_frequences(1);
for i = 2:n
    bornes(1,i) = bornes(2,i-1);
    bornes(2,i) = bornes(1,i) + selection_frequences(i);
end;


