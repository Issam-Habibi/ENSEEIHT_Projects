function [selection_frequences,selection_alphabet] = selection(frequences,alphabet)
%indices est un vecteur contenant les indices des lettre de fréquence non
%nule .
indices = find(frequences>0);
m = length(indices);
for i = 1:m
    selection_frequences1(i) = frequences(indices(i)); %on séléctionne ces lettres à partir du vecteur fréquence
    selection_alphabet1(i) = alphabet(indices(i)); %on séléctionne ces lettres à partir du vecteur alphabet
end
selection_frequences = selection_frequences1';  %on transpose les résultats pour ne pas obtenir des soucis de dimension
selection_alphabet = selection_alphabet1';




    