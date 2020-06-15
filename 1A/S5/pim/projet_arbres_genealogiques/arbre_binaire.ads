---Spécification du module Arbre_Binaire .

Generic

       type T_Cle is private;
       
package Arbre_Binaire is 

        Type T_Arbre_Binaire is limited private;

       Arbre_Null : Exception;
       Cle_Presente_Exception : Exception;   --La clé est déja présente dans l'arbre . 
       Cle_Absente_Exception : Exception;    -- La clé est absente dans l'arbre . 


       --Initialiser un arbre , il est vide . 
       procedure Initialiser(Arbre : OUT T_Arbre_Binaire) with
	   post => Est_Arbre_Vide(Arbre);             --L'arbre est initialement vide .


       --Vérifier si un arbre est vide ou pas .
       function Est_Arbre_Vide(Arbre : IN T_Arbre_Binaire) return Boolean;
       

       function Est_Cle_Presente(Arbre : IN T_Arbre_Binaire ; Cle : IN T_Cle) return Boolean;


       --Calculer le nombre d'élements d'un arbre.
       function Nombre_Elements(Arbre : IN T_Arbre_Binaire) return Integer;


       --Calculer la hauteur d'un arbre .
       function Hauteur(Arbre : IN T_Arbre_Binaire) return Integer; 


       --Obtenir la clé du racine d'un arbre.
       function get_Cle(Arbre: IN T_Arbre_Binaire) return T_Cle;


        --Obtenir le sous arbre gauche d'un arbre
       function get_Arbre_Gauche(Arbre : IN T_Arbre_Binaire) return T_Arbre_Binaire;


       --Obtenir le sous arbre droit d'un arbre
       function get_Arbre_Droit(Arbre : IN T_Arbre_Binaire) return T_Arbre_Binaire;


      --Creer un arbre
       procedure Creer_Arbre(Arbre : OUT T_Arbre_Binaire ; Cle : IN T_Cle);


       --Insérer un noeud à droite d'un arbre .
       procedure Inserer_Droite(Arbre : IN OUT T_Arbre_Binaire ; Cle : IN T_Cle);


       --Insérer un noeud à gauche d'un arbre .
       procedure Inserer_Gauche(Arbre : IN OUT T_Arbre_Binaire ; Cle : IN T_Cle);


      --Remplacer un arbre par le sous arbre gauche d'un arbre . 
       procedure Remplacer_Gauche(Arbre1 : IN OUT T_Arbre_Binaire ; Arbre2 : IN T_Arbre_Binaire);


       --Remplacer un arbre par le sous arbre droit d'un arbre .
       procedure Remplacer_Droite(Arbre1 : IN OUT T_Arbre_Binaire ; Arbre2 : IN T_Arbre_Binaire);

       --Récupérer un arbre .
       function get_Arbre_Binaire(Arbre : IN  T_Arbre_Binaire) return T_Arbre_Binaire;

       --Vérifier l'égalité entre deux arbres .
       function Est_Egaux_Arbres(Arbre1 : IN T_Arbre_Binaire ; Arbre2 : IN T_Arbre_Binaire) return Boolean;

       --Affecter un arbre à un autre .
       procedure Remplacer_Arbre(Arbre1 : IN OUT T_Arbre_Binaire ; Arbre : T_Arbre_Binaire);

       --Supprimer les ancetres d'une clé dans l'arbre . 
       procedure Supprimer_Ancetres(Arbre : IN OUT T_Arbre_Binaire ; Cle : IN T_Cle);
       

       --Vider un arbre et libirer les ressources que ça utilise .
       procedure Vider(Arbre : IN OUT T_Arbre_Binaire) with
            post => Est_Arbre_Vide(Arbre);        --L'arbre devient vide . 
      
    

private

      Type T_Noeud;
      Type T_Arbre_Binaire is access T_Noeud;
      Type T_Noeud is
	  record
	      Cle : T_Cle;
	      Sous_Arbre_Gauche : T_Arbre_Binaire;
	      Sous_Arbre_Droit : T_Arbre_Binaire;
          end record;



end Arbre_Binaire;







