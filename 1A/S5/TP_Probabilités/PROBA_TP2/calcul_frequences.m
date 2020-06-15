function frequences = calcul_frequences(texte,alphabet)
%Obtenir la longeur des vecteurs alphabet et texte.
n = length(alphabet);
m = length(texte);
%initialiser un vecteur de n lignes et une colonne contenant que des zeros.
V = zeros(n,1);
for i = 1:n
    %indices est un vecteur contenant les indices d'une lettre dans le
    %texte coincidant avec la lettre 'alphabet(i)' , sa longeur
    %représentera donc le nombre d'occurences de cette lettre dans le
    %texte.
    indices = find(texte==alphabet(i));
    V(i) = length(indices);
end
frequences = (1/m)*V; %on divise par la longeur du texte pour obtenir une fréquence relative . 




    
    

    