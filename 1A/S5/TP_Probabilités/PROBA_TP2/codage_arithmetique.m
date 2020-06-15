function [borne_inf,borne_sup] = codage_arithmetique(texte,selection_alphabet,bornes);
borne_inf = 0;
borne_sup = 1;
n = length(texte);
for i = 1:n
    %indices est un vecteur d'une seule composante qui contient l'indice
    %dans l'alphabet du iéme lettre du texte.
    indices = find(selection_alphabet==texte(i));
    largeur = borne_sup - borne_inf;
    borne_sup = borne_inf + largeur*bornes(2,indices(1));
    borne_inf = borne_inf + largeur*bornes(1,indices(1));
end


%après avoir executé le programme , on remarquera qu'effectivement le
%nombre de bits du codage arithmétique (47) est bien inférieur à celui de
%Huffman (52) , donc cette méthode est plus optimale