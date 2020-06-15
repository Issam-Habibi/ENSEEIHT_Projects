---Spécification du module Arbre_Genealogique . 

with Arbre_Binaire;
with Ensembles_Chainage;

package Arbre_Genealogique is

      type T_Arbre_Genealogique is limited private;
    
 
      --L'instantiation du packetage Ensemble_Chainage avec des entiers comme éléments , ceci serait utile
      --dans le stockage et l'affichage des ensembles d'ancêtres , de individu ayant un parent connu ...ect
      package Ensembles_Entiers is 
	       new Ensembles_Chainage(T_Element => Integer);
      use Ensembles_Entiers;

      --L'instantiation des procédure d'affichage de ce paquetage .
      procedure Afficher_Element(n : Integer);
      
      procedure Afficher is
	      new Ensembles_Entiers.Appliquer_Sur_Tous(Afficher_Element);




      function Est_Cle_Presente_1(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return boolean;

      --Créer un arbre minimal contenant un seul noeud , sans père ni mère .
      procedure Creer_Arbre_Minimale(Arbre : OUT T_Arbre_Genealogique ; Cle : IN Integer );


      --Ajouter un parent à un noeud donné , on précisera le type de parent par 'P' si c'est un père ou 'M' si c'est une mère . 
      procedure Ajouter_Parent(Arbre : IN OUT T_Arbre_Genealogique ; Cle : IN Integer ; Cle_Parent : IN Integer ; Type_Parent : Character) with
	  pre => Cle_Parent /= Cle;
	                             --Invariant : Le Père est toujours inséré à gauche .
	                             --Invariant : La Mère est toujours insérée à droite .


      --Obtenir le nombre d'ancêtres connus d'un individu . 
      function Nombre_Ancetres(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer;


      --Obtenir l'ensemlbe des ancêtres situés à une certaine génération d'un noeud donné . 
      procedure Ensemble_Ancetres(Arbre : IN T_Arbre_Genealogique ; Cle : Integer ; Generation : Integer);


      --Obtenir l'ensemble des individus dont un seul parent est connu .
      procedure Ensemble_Un_Parent_Connu(Arbre : IN T_Arbre_Genealogique);

      --Supprimer les ancêtres d'un individu .
      procedure Supprimer_Ancetres_1(Arbre : IN OUT T_Arbre_Genealogique ; Cle : IN Integer);
      

      --Obtenir l'ensemble des individus dont les deux parents sont connus . 
      procedure Ensemble_Deux_Parents_Connus(Arbre : IN T_Arbre_Genealogique);


      --Obtenir l'ensemble des individus dont les deux parents sont inconnus .
      procedure Ensemble_Deux_Parents_Inconnus(Arbre : IN T_Arbre_Genealogique);


      --Identifier les ancêtres d'un individu sur un nombre donné de générations .
      procedure Identifier_Ancetres(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer ; Generation : IN Integer);


      --Obtenir le nombre de générations dans un arbre généalogique.
      function Nombre_Generations(Arbre : IN T_Arbre_Genealogique) return Integer;
 
      
      --Afficher l'arbre avec une procedure Afficher_Element qui afficher chaque élément de l'arbre .
      -- L'affichage devrait aussi indique le nombre de générations dans l'arbre .
      -- la clé du racine n'est précedée par aucun symbole .
      -- la clé des ancêtres est précédée par ' -- ' et leur sexe .
      -- Exemple : 
      --        0   1   2   génération
      --        -----------------------
      --        /Racine : 17
      --            --père : 1
      --                --père : 12
      --            --mère : 7
      --                --mère : 28
      --  
      --
      --Une procédure intermédiaire d'affichage d'arbre .
      procedure Afficher_Arbre(Arbre : IN T_Arbre_Genealogique);


      --La procédure principale de l'affichage de l'arbre . 
      procedure Afficher(Arbre : IN T_Arbre_Genealogique);


      --Récupérer la clé du Père d'un individu . 
      function get_Cle_Pere(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer;

      --Récupérer la clé du Mère d'un individu . 
      function get_Cle_Mere(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer;
      
      --Récupérer la clé du fils d'un individu . 
      function get_Cle_Fils(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer;

      --Récupérer un arbre
      function get_Arbre(Arbre : IN T_Arbre_Genealogique) return T_Arbre_Genealogique;

      --Affecter un arbre à un autre . 
      procedure Remplacer_Arbre_1(Arbre1 : IN OUT T_Arbre_Genealogique ; Arbre : IN T_Arbre_Genealogique);

      --Vérifier l'égalité entre deux arbres .
      function Est_Egaux(Arbre1 : IN T_Arbre_Genealogique ; Arbre2 : IN T_Arbre_Genealogique) return Boolean;      

       --Libérer les ressources utilisés par l'arbre .
      procedure Vider_Arbre(Arbre : IN OUT T_Arbre_Genealogique);

private


    --On fait l'instanciation du module Arbre_Binaire pour pouvoir l'utiliser pour manipuler les arbres généologiques . 


      package Arbre_Binaire_Entiers is
	  new Arbre_Binaire(T_Cle => Integer);
      use Arbre_Binaire_Entiers;

      Type T_Arbre_Genealogique is new T_Arbre_Binaire;

end Arbre_Genealogique; 
