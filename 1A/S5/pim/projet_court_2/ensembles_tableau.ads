--Spécification du module Ensembles_Tableau
Generic

    CAPACITE : Integer;  --Le nombre d'éléments qu'un ensemble peut contenir
    type T_Element is private;    --Le type des éléments de l'ensemble

package Ensembles_Tableau is

    	type T_Ensemble is limited private;


         --Initialiser un ensemble , il est vide
        procedure Initialiser(E : OUT T_Ensemble) with
	    post => Est_Vide(E);


        --Détruire l'ensemble , il ne serait utilisé que s'il est initialiser de nouveau
  	procedure Detruire(E : IN OUT T_Ensemble) with
	    post => Est_Vide(E);


        --Est-ce que l'ensemble est vide ?
	function Est_Vide(E : IN T_Ensemble ) return Boolean;


        --La taille d'un ensemble.
	function Taille_Ensemble(E : IN T_Ensemble) return Integer;


        --La présence ou pas d'un élément dans un ensemble	
 	function Est_Present(E : IN T_Ensemble ; Y : IN T_Element) return Boolean with
	    pre => not Est_Vide(E);


        --L'ajout d'un élément dans un ensemble . 
	procedure Ajouter_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) with
	    pre => Taille_Ensemble(E) < CAPACITE and not Est_Present(E,Y),
	    post => Est_Present(E,Y);


        --Supprimer un élément déja présent dans un ensemble
	procedure Supprimer_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) with
	    pre => Est_Present(E,Y),
	    post => not Est_Present(E,Y);

	  
        --Afficher les éléments d'un ensemble . 
	Generic
	      with procedure Operation_Element(Y : IN T_Element);
	procedure Appliquer_Sur_Tous(E : IN T_Ensemble);


private

     Type T_Tab_Elements is array(1..CAPACITE) of T_Element;

     Type T_Ensemble is record
	 Taille: Integer;
	 Elements: T_Tab_Elements;
     end record;

end Ensembles_Tableau;
