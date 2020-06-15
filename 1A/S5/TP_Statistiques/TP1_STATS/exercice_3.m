donnees_occultees; %faire appel au script donnees_occultees 

R_0 = 8;
% Tirage aleatoire uniforme de positions du centre C : 
nb_tests = 1000;
R_1 = (std(x_new) + std(y_new))/2
R_new = (1.5*R_1 - 0.5*R_1) * rand(nb_tests,1) + 0.5*R_1;
C_tests = (taille-R_0)*(2*rand(nb_tests,2)-1);
[C_estime,R] = estimation_2(x_new,y_new,C_tests,R_new); %On applique la fonction estimation_2 sur les
%nouveaux vecteurs obtenus .

% Affichage du cercle estime :
x_cercle_estime = C_estime(1) + R*cos(theta_cercle);
y_cercle_estime = C_estime(2) + R*sin(theta_cercle);
plot(x_cercle_estime([1:end 1]),y_cercle_estime([1:end 1]),'b','LineWidth',3);
lg = legend('~Cercle reel $(C_0,R_0)$', ...
		'~Donnees bruitees', ...
		'~Cercle estime $(C^*,R_0)$', ...
		'Location','Best');
set(lg,'Interpreter','Latex');