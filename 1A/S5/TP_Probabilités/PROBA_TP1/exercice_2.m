clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Lecture d'une image interne a Matlab et conversion en doubles :
I_max = 255;
I_min = -255;  %prise en compte des valeurs négatifs que les termes de I peuvent prendre . 
I = rgb2gray(imread('autumn.tif'));
I = double(I);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Effectuer la décorrélation des niveaux de gris de I: 
[n,m]=size(I);
%V est le premier vecteur colonne de la matrice I.
V = I(:,1);
% A est la matrice I privée de sa dernière colonne . 
A = I(:,1:m-1);
% B est la matrice I privée de sa première colonne .
B = I(:,2:m);
% soustraire de chaque colonne , la colonne de gauche .
C = B - A;
% Concaténation de la première colonne de I inchangeable , avec le reste de
% la matrice après soustraction , on obtient ainsi I décorrelee . 
I_decorrelee = [V,C];

%On remarque un changement dans l'histogrammes des niveaux de gris , le
%niveau 0 domine avec une fréquence élevée . La répartition du nuage des
%paires des niveaux de gris change aussi , ils sont plus condensés autour
%du niveau 0 ( ce qui est logic car on a effectuer la différence entre
%chaque niveau et son voisin ) et la droite de regression est de pente plus
%petite que celle d'avant . 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Affichage de l'image :
figure('Name','Exemple d''image interne a Matlab','Position',[0,0,0.33*L,0.3*L]);
imagesc(I_decorrelee);
axis off;
axis equal;
colormap gray;

% Affichage de l'histogramme de l'image :
histogramme = hist(I_decorrelee(:),[I_min:I_max]);
figure('Name','Histogramme des niveaux de gris','Position',[0.33*L,0,0.33*L,0.3*L]);
plot([I_min:I_max],histogramme);
axis([I_min I_max 0 1.1*max(histogramme)]);
xlabel('Niveau de gris','FontSize',15);
ylabel('Frequence','FontSize',15);
set(gca,'FontSize',20);

% Calcul de vecteurs contenant les niveaux de gris de gauche (de droite) d'une paire de pixels :
[X,Y] = vectorisation(I_decorrelee);

% Affichage des paires de niveaux de gris sous la forme d'un nuage de points :
figure('Name','Mise en evidence de la correlation entre pixels voisins','Position',[0.66*L,0,0.33*L,0.3*L]);
plot(X,Y,'b+');
axis([I_min I_max I_min I_max]);
xlabel('Niveau de gris du pixel de gauche','FontSize',15);
ylabel('Niveau de gris du pixel de droite','FontSize',15);
hold on;
set(gca,'FontSize',20);
axis equal;

% Calcul des parametres de la droite de regression :
[r,a,b] = calcul_parametres(X,Y);
fprintf('Coefficient de correlation lineaire : %.4f\n',r);

% Affichage de la droite de regression (d'equation y = a*x+b) :
x = I_min:I_max;
y = a*x+b;
plot(x,y,'r','LineWidth',3);
