with Ada.Unchecked_Deallocation;

package body Registre is

    procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_Registre);

---------------------------------------------------------------------------------------------------------------

    procedure Initialiser_Registre(Registre : OUT T_Registre) is
    begin
	Registre := null;
    end Initialiser_Registre;

---------------------------------------------------------------------------------------------------------------


    function Est_Registre_Vide(Registre : IN T_Registre) return Boolean is
    begin
	return Registre = null;
    end Est_Registre_Vide;

---------------------------------------------------------------------------------------------------------------

    function Taille_Registre(Registre : IN T_Registre) return Integer is
    begin
	if Registre = null then
	    return 0;
	else
	    return 1 + Taille_Registre(Registre.all.Sous_Arbre_Gauche) + Taille_Registre(Registre.all.Sous_Arbre_Droit);
	end if;
    end Taille_Registre;
  
---------------------------------------------------------------------------------------------------------------


    procedure Inserer(Registre : IN OUT T_Registre ; Cle : IN Integer ; Donnee : IN T_Donnee) is
          Cle_Presente : Exception;
    begin
	if Registre = null then
	    Registre := new T_Noeud'(Cle,Donnee,null,null);
	elsif Cle < Registre.all.Cle then
	    Inserer(Registre.all.Sous_Arbre_Gauche,Cle,Donnee);
	elsif Cle > Registre.all.Cle then
	    Inserer(Registre.all.Sous_Arbre_Droit,Cle,Donnee);
	else
	    raise Cle_Presente;
	end if;
    end Inserer;

---------------------------------------------------------------------------------------------------------------


    function Obtenir_Donnee(Registre : T_Registre ; Cle : IN Integer ) return T_Donnee is 
	Cle_Absente : Exception;
    begin
	if Registre = null then
	    raise Cle_Absente;
	elsif Cle < Registre.all.Cle then
	    return Obtenir_Donnee(Registre.all.Sous_Arbre_Gauche,Cle);
	elsif Cle > Registre.all.Cle then
	    return Obtenir_Donnee(Registre.all.Sous_Arbre_Droit,Cle);
	else
	    return Registre.all.Donnee;
	end if;
    end Obtenir_Donnee;

---------------------------------------------------------------------------------------------------------------


    procedure Modifier(Registre : IN OUT T_Registre ; Cle : IN Integer ; Donnee : T_Donnee) is
           Cle_Absente : Exception;
    begin
	if Registre = null then
	    raise Cle_Absente;
	elsif Cle = Registre.all.Cle then
	    Registre.all.Donnee := Donnee;
	elsif Cle < Registre.all.Cle then
	    Modifier(Registre.all.Sous_Arbre_Gauche,Cle,Donnee);
	elsif Cle > Registre.all.Cle then
	    Modifier(Registre.all.Sous_Arbre_Droit,Cle,Donnee);
	end if;
     end Modifier;

---------------------------------------------------------------------------------------------------------------


     procedure Inserer_Nom(Registre : IN OUT T_Registre ; Cle : Integer ; Nom : Unbounded_String) is
     begin
	 if Registre = null then
	     raise Cle_Absente;
	 elsif Cle = Registre.all.Cle then
		 Registre.all.Donnee.Nom := Nom;
         elsif Cle < Registre.all.Cle then
	     Inserer_Nom(Registre.all.Sous_Arbre_Gauche,Cle,Nom);
	 elsif Cle > Registre.all.Cle then
	     Inserer_Nom(Registre.all.Sous_Arbre_Droit,Cle,Nom);
	 end if;
     end Inserer_Nom;

---------------------------------------------------------------------------------------------------------------

     procedure Inserer_Prenom(Registre : IN OUT T_Registre ; Cle : Integer ; Prenom : Unbounded_String) is
     begin
	 if Registre = null then
	     raise Cle_Absente;
	 elsif Cle = Registre.all.Cle then
		 Registre.all.Donnee.Prenom := Prenom;
         elsif Cle < Registre.all.Cle then
	     Inserer_Prenom(Registre.all.Sous_Arbre_Gauche,Cle,Prenom);
	 elsif Cle > Registre.all.Cle then
	     Inserer_Prenom(Registre.all.Sous_Arbre_Droit,Cle,Prenom);
	 end if;
     end Inserer_Prenom;

---------------------------------------------------------------------------------------------------------------

     procedure Inserer_Pays(Registre : IN OUT T_Registre ; Cle : Integer ; Pays : Unbounded_String) is
     begin
	 if Registre = null then
	     raise Cle_Absente;
	 elsif Cle = Registre.all.Cle then
		 Registre.all.Donnee.Pays := Pays;
         elsif Cle < Registre.all.Cle then
	     Inserer_Pays(Registre.all.Sous_Arbre_Gauche,Cle,Pays);
	 elsif Cle > Registre.all.Cle then
	     Inserer_Pays(Registre.all.Sous_Arbre_Droit,Cle,Pays);
	 end if;
     end Inserer_Pays;

---------------------------------------------------------------------------------------------------------------

     procedure Inserer_Annee_De_Naissance(Registre : IN OUT T_Registre ; Cle : Integer ; Annee : Integer) is
     begin
	 if Registre = null then
	     raise Cle_Absente;
	 elsif Cle = Registre.all.Cle then
		 Registre.all.Donnee.Annee_De_Naissance := Annee;
         elsif Cle < Registre.all.Cle then
	     Inserer_Annee_De_Naissance(Registre.all.Sous_Arbre_Gauche,Cle,Annee);
	 elsif Cle > Registre.all.Cle then
	     Inserer_Annee_De_Naissance(Registre.all.Sous_Arbre_Droit,Cle,Annee);
	 end if;
     end Inserer_Annee_De_Naissance;

---------------------------------------------------------------------------------------------------------------


     procedure Vider_Registre(Registre : IN OUT T_Registre) is
     begin
	 if Registre = null then
	     null;
	 else
	     Vider_Registre(Registre.all.Sous_Arbre_Gauche);
	     Vider_Registre(Registre.all.Sous_Arbre_Droit);
	     Free(Registre);
	 end if;
     end Vider_Registre;




end Registre;








      







