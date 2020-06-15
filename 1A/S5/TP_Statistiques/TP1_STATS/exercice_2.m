donnees;

R_0 = 8;
% Tirage aleatoire uniforme de positions du centre C : 
nb_tests = 1000;
R_1 = (std(x_donnees_bruitees) + std(y_donnees_bruitees))/2 %On introduit la variance . 
R_new = (1.5*R_1 - 0.5*R_1) * rand(nb_tests,1) + 0.5*R_1; %On tire aléatoirement dans l'intervalle [0.5*R_1,1.5*R_1]
C_tests = (taille-R_0)*(2*rand(nb_tests,2)-1);
[C_estime,R] = estimation_2(x_donnees_bruitees,y_donnees_bruitees,C_tests,R_new);

% Affichage du cercle estime :
x_cercle_estime = C_estime(1) + R*cos(theta_cercle); %Mettre à jour R_0 par R
y_cercle_estime = C_estime(2) + R*sin(theta_cercle); %Mettre à jour T_0 par R
plot(x_cercle_estime([1:end 1]),y_cercle_estime([1:end 1]),'b','LineWidth',3);
lg = legend('~Cercle reel $(C_0,R_0)$', ...
		'~Donnees bruitees', ...
		'~Cercle estime $(C^*,R_0)$', ...
		'Location','Best');
set(lg,'Interpreter','Latex');