function coeff_compression_apres_decorrelation = coeff_compression_image(histogramme,dico)
n=length(histogramme);
nbre_bits_avant_codage = 8*sum(histogramme);
nbre_bits_apres_codage = 0;
for i = 1:n
    %histogramme(i) nous donne accès au nombre de pixels utilisé ,
    %dico{i,2} est un vecteur contenant la représentation binaire d'un
    %objet , d'où sa longueur nous donne le nombre de bits utilisé pour
    %coder cet objet.
    nbre_bits_apres_codage = nbre_bits_apres_codage + histogramme(i)*length(dico{i,2});
end
coeff_compression_apres_decorrelation = nbre_bits_avant_codage/nbre_bits_apres_codage;

