function [rho_F_1,theta_F_1] = RANSAC_2(rho,theta,parametres)
n = length(rho);
Ecart_moyen_inf = Inf;
for i = 1:parametres(3)
    nb_aleatoire = randperm(n,2);
    [rho_test,theta_test] = estimation_F(rho(nb_aleatoire),theta(nb_aleatoire));
    Vecteur_residu = abs(rho - rho_test*cos(theta - theta_test));
    indices = find(Vecteur_residu <= parametres(1));
     p = length(indices);
    if p / n >= parametres(2)
        Vecteur = abs(rho(indices)  - rho_test*cos(theta(indices) - theta_test));
        Ecart_moyen_conforme = 1/n*sum(abs(Vecteur));
        if Ecart_moyen_conforme <= Ecart_moyen_inf
            Ecart_moyen_inf = Ecart_moyen_conforme;
            rho_F_1 = rho_test;
            theta_F_1 = theta_test;
        end
    end
end
end
