with Arbre_Genealogique;
use Arbre_Genealogique;


package Foret is

    ---La forêt est modélisée par une liste chaînée.

      type T_Cellule_Foret;
      type T_Foret is access T_Cellule_Foret;
      type T_Cellule_Foret is
	  record
	      Arbre : T_Arbre_Genealogique;
	      Suivant : T_Foret;
	  end record;
 
      --Initialiser une forêt .
      procedure Initialiser_Foret(Foret : OUT T_Foret);

      --Ajouter un arbre à une forêt . 
      procedure Ajouter_Element_Foret(Foret : IN OUT T_Foret ; Arbre : IN T_Arbre_Genealogique);

      --Obtenir le nombre d'arbre constituant une forêt .
      function Taille_Foret(Foret : IN T_Foret) return Integer;

      --Supprimer un arbre d'une forêt . 
      procedure Supprimer_Arbre(Foret : IN OUT T_Foret ; Arbre : IN T_Arbre_Genealogique);

      --Obtenir l'ensemble des demi frères et soeurs d'un undividu . 
      procedure Ensemble_Demi_Freres_Soeurs(Foret : IN OUT T_Foret ; Cle_Individu : IN Integer ; Arbre : IN T_Arbre_Genealogique);

      --Librérer les ressources utilisés par une forêt . 
      procedure Detruire_Foret(Foret : IN OUT T_Foret);
      
      
      
  
end Foret;
