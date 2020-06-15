---Spécification du module registre 
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

package Registre is
        
        Type T_Donnee is
	record
	    Nom : unbounded_string;
	    Prenom : Unbounded_String;
	    Annee_De_Naissance : Integer;
	    Pays : Unbounded_String;
	end record;


        Type T_Registre is private;

	Cle_Presente : Exception;
	Cle_Absente : Exception;

        --Initialiser un registre , il est vide .
        procedure Initialiser_Registre(Registre : OUT T_Registre) with
	    post => Est_Registre_Vide(Registre);


        --Savoir si un registre est vide ou pas .
	function Est_Registre_Vide(Registre : IN T_Registre) return Boolean;


        --Obtenir la taille du registre.
	function Taille_Registre(Registre : IN T_Registre) return Integer with
	    post => Taille_Registre'Result >= 0;


        --Inserer les informations concernant un individu . 
        procedure Inserer(Registre : IN OUT T_Registre ; Cle : IN Integer ; Donnee : IN T_Donnee) with
	    post => Obtenir_Donnee(Registre,Cle) = Donnee;

 
        --Obtenir les données d'un individu .
	function Obtenir_Donnee(Registre : IN T_Registre ; Cle : IN Integer) return T_Donnee; 
	
         --Modifier la donnée associée à une clé dans le registre
	procedure Modifier(Registre : IN OUT T_Registre ; Cle : IN Integer ; Donnee : T_Donnee);


        --Insérer le nom d'un individu dans le registre .
	procedure Inserer_Nom(Registre : IN OUT T_Registre ; Cle : Integer ; Nom : Unbounded_String); 	    


        --Insérer le prénom d'un individu dans le registre .
	procedure Inserer_Prenom(Registre : IN OUT T_Registre ; Cle : Integer ; Prenom : Unbounded_String); 	   


        --Insérer le pays de résidence d'un individu dans le registre .
	procedure Inserer_Pays(Registre : IN OUT T_Registre ; Cle : Integer ; Pays : Unbounded_String); 	    


        --Insérer l'année de naissance d'un individu dans un registre . 
	procedure Inserer_Annee_De_Naissance(Registre : IN OUT T_Registre ; Cle : Integer ; Annee : Integer); 

	  	  	   
        --Vider le registre et libérer les ressources qu'il utilise . 
	procedure Vider_Registre(Registre : IN OUT T_Registre) with
	    post => Est_Registre_Vide(Registre);        --Le registre est vide .

     --On a choisit de modéliser le registre sous la forme d'un arbre binaire de recherche pour que le parcours du registre soit optimisé . 
private

    Type T_Noeud;        
    Type T_Registre is access T_Noeud;  
    Type T_Noeud is              
	record
	    Cle : Integer;
	    Donnee : T_Donnee;
	    Sous_Arbre_Gauche : T_Registre;
	    Sous_Arbre_Droit : T_Registre;
	end record;
                             --Invariant : Pour tout noeud N dans le sous arbre gauche : N.Cle < Cle .
                             --Invariant : Pour tout noeud N dans le sous arbre droit : N.Cle > Cle .

end Registre;



