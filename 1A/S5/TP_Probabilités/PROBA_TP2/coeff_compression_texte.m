function coeff_compression = coeff_compression_texte(texte,texte_encode)
nbre_bits_texte_originale = 8 * length(texte);
nbre_bits_texte_encode = length(texte_encode);
coeff_compression = nbre_bits_texte_originale/nbre_bits_texte_encode;

%On s'attend bien à un coefficient strictement supérieur à 1 , car
%l'interet du codage de Huffman est de réduire le nombre de bits utilisé
%pour encoder un texte . 