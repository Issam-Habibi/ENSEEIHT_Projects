function [rho_F,theta_F] = estimation_F(rho,theta)
A = [cos(theta) , sin(theta)];
Vecteur_X = pinv(A)*rho; %%la fonction pinv nous donne la matrice pseudo-inverse de A.
x_F = Vecteur_X(1);
y_F = Vecteur_X(2);
rho_F = sqrt( x_F^2 + y_F^2 );
theta_F = atan2(y_F,x_F);    
end
