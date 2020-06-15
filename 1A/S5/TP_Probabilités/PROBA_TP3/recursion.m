function [E,contour,G_somme] = recursion(E,contour,G_somme,i,j,voisins,G_x,G_y,card_max,cos_alpha)
% Fonction recursive permettant de construire un ensemble candidat E

contour(i,j) = 0;
G_somme_normalise = G_somme/norm(G_somme);
nb_voisins = size(voisins,1);
k = 1;
while k<=nb_voisins & size(E,1)<=card_max
	i_voisin = i + voisins(k,1); 			
	j_voisin = j + voisins(k,2);		
	if contour(i_voisin,j_voisin) 
        V = [G_x(i_voisin,j_voisin),G_y(i_voisin,j_voisin)];
        produit_scalaire = G_somme_normalise(1)*V(1) + G_somme_normalise(2)*V(2);
        if produit_scalaire > cos_alpha % la condition de parallélisme entre le gradient et la somme des gradients
            %Mettre à jour l'ensemble E .
            E = [E;i_voisin,j_voisin];
            %Mettre à jour G_somme .
            G_somme = G_somme + [G_x(i_voisin,j_voisin),G_y(i_voisin,j_voisin)]; 
            %l'appel récursive 
            [E,contour,G_somme] = recursion(E,contour,G_somme,i_voisin,j_voisin,voisins,G_x,G_y,card_max,cos_alpha); %%l'appel récursive .
		end
	end
	k = k+1;
end
