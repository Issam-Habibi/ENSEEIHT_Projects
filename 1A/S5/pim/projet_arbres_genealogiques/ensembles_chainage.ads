--Spécifier le module Ensembles_Chainage.
Generic

     type T_Element is  private;  --Le type des éléments de l'ensemble.

package Ensembles_Chainage is

	type T_Ensemble is limited private;

        --Initialiser un ensemble , il est vide .
        procedure Initialiser(E : OUT T_Ensemble) with
	    post => Est_Vide(E);


        --Détruire un ensemble , il ne peut être utilisé que s'il est initialisé de nouveau .
	procedure Detruire(E : IN OUT T_Ensemble) with
	    post => Est_Vide(E);


        --Est-ce que l'ensemble est vide ?
	function Est_Vide(E : IN T_Ensemble ) return Boolean;


         --La taille d'un ensemble . 
	function Taille_Ensemble(E : IN T_Ensemble) return Integer;


        --La présence ou pas d'un élément dans un ensemble .	
	function Est_Present(E : IN T_Ensemble ; Y : IN T_Element) return Boolean with
	    pre => not Est_Vide(E);


        --L'ajout d'un élément dans un ensemble .
	procedure Ajouter_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) with
	    pre => not Est_Present(E,Y),
	    post => Est_Present(E,Y);


        --Supprimer un élément déja présent dans un ensemble . 
	procedure Supprimer_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) with
	    pre => Est_Present(E,Y),
	    post => not Est_Present(E,Y);



	procedure Remplacer_Ensemble(E1 : IN OUT T_Ensemble ; E : IN T_Ensemble);

        function get_Element(Ensemble : IN T_Ensemble) return T_Element;

	procedure Copie(Element_1 : IN OUT T_Element ; Element_2 : IN T_Element);
	


        --Afficher les éléments d'un ensemble .
 	Generic
	      with procedure Operation_Element(Y : IN T_Element);
	procedure Appliquer_Sur_Tous(E : IN T_Ensemble);


private

     Type T_Cellule;

     Type T_Ensemble is access T_Cellule;

     Type T_Cellule is record
	 Element : T_Element;
	 Suivant : T_Ensemble; 
     end record;

end Ensembles_Chainage;
