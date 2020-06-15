--Implantation du module Ensembles_Tableau
package body Ensembles_Tableau is


    procedure Initialiser(E : OUT T_Ensemble) is
    begin
	E.Taille := 0;
    end Initialiser;

    procedure Detruire(E : IN OUT T_Ensemble) is       --La destruction serait faite en chainage  
    begin
	null;
    end Detruire;

    function Est_Vide(E : IN T_Ensemble) return boolean is
    begin
	return E.Taille = 0;
    end Est_Vide;

    function Taille_Ensemble(E : IN T_Ensemble) return Integer is
    begin
	if Est_Vide(E) then
	    return 0;
	else
	    return E.Taille;
	end if;
    end Taille_Ensemble;

    function Est_Present(E : IN T_Ensemble ; Y : IN T_Element) return Boolean is
    begin
	for i in 1..E.Taille loop
	    if E.Elements(i) = Y then
		return True;
	    end if;
	end loop;
	return False;
    end Est_Present;
	    	   

    procedure Ajouter_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) is
    begin
	if E.Taille < CAPACITE then
	    E.Taille := E.Taille + 1;
	    E.Elements(E.Taille) := Y;
	end if;
    end Ajouter_Element;


    procedure Supprimer_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) is 
	X : T_Element;
    begin
	for i in 1..E.Taille loop
	    if Y = E.Elements(i) then
		X := E.Elements(i);
		E.Elements(i) := E.Elements(E.Taille);          --On permute l'élement avec le dernier élement de l'ensemble puis on le supprime . 
		E.Elements(E.Taille) := X; 
	    end if;
	end loop;
	E.Taille := E.Taille - 1;
     end Supprimer_Element;


     

     procedure Appliquer_Sur_Tous(E : IN T_Ensemble) is       -- On essaye de donner un aspect ' général ' à cette procédure , avec la procédure
     begin                                                    -- Operation_Element qui applique une opération sur un élément de l'ensemble .
	 for k in 1..E.Taille  loop
	     Operation_Element(E.Elements(k));
	 end loop;
     end Appliquer_Sur_Tous;



end Ensembles_Tableau;
