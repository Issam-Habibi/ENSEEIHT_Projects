with Ada.Unchecked_Deallocation;

package body Arbre_Binaire is

    procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Noeud, Name => T_Arbre_Binaire);

---------------------------------------------------------------------------------------------------------------
    

    procedure Initialiser(Arbre : OUT T_Arbre_Binaire) is
    begin
	Arbre := null;
    end Initialiser;

---------------------------------------------------------------------------------------------------------------


    function Est_Arbre_Vide(Arbre : IN T_Arbre_Binaire) return Boolean is
    begin
	return Arbre = null;
    end Est_Arbre_Vide;


---------------------------------------------------------------------------------------------------------------


    function Est_Cle_Presente(Arbre : IN T_Arbre_Binaire ; Cle : IN T_Cle) return Boolean is
    begin
	if Arbre = null then
	    return false;
	elsif Cle = Arbre.all.Cle then
	    return true;
	else
	    return Est_Cle_Presente(Arbre.all.Sous_Arbre_Gauche,Cle) or Est_Cle_Presente(Arbre.all.Sous_Arbre_Droit,Cle);
	end if;
    end Est_Cle_Presente;

---------------------------------------------------------------------------------------------------------------


    function Nombre_Elements(Arbre : IN T_Arbre_Binaire) return Integer is 
    begin

	if Arbre = null then
	    return 0;
	else
	    return 1 + Nombre_Elements(Arbre.all.Sous_Arbre_Gauche) + Nombre_Elements(Arbre.all.Sous_Arbre_Droit);
	end if;
    end Nombre_Elements;

    
---------------------------------------------------------------------------------------------------------------

      
     procedure Supprimer_Ancetres(Arbre : IN OUT T_Arbre_Binaire ; Cle : IN T_Cle) is

     begin
	 if Arbre = null then
	     null;
	 else
	     if Cle = Arbre.all.Cle then
		 if Arbre.all.Sous_Arbre_Gauche /= null and Arbre.all.Sous_Arbre_Droit /= null then
		     Vider(Arbre);
		 elsif Arbre.all.Sous_Arbre_Gauche = null and Arbre.all.Sous_Arbre_Droit /= null then
		     Vider(Arbre.all.Sous_Arbre_Droit);
		 elsif Arbre.all.Sous_Arbre_Gauche /= null and Arbre.all.Sous_Arbre_Droit = null then
		     Vider(Arbre.all.Sous_Arbre_Gauche);
		 elsif Arbre.all.Sous_Arbre_Gauche = null and Arbre.all.Sous_Arbre_Droit = null then
		     Vider(Arbre);
		 end if;
	      else
		  Supprimer_Ancetres(Arbre.all.Sous_Arbre_Gauche,Cle);
		  Supprimer_Ancetres(Arbre.all.Sous_Arbre_Droit,Cle);
	      end if;
	end if;
    end Supprimer_Ancetres;


---------------------------------------------------------------------------------------------------------------


    function Hauteur(Arbre : IN T_Arbre_Binaire) return Integer is

	function Max(a : IN Integer ; b : IN Integer) return Integer is
	    Max : Integer;
	begin
	    if a >= b then
		Max := a;
	    else
		Max :=b;
            end if;
	return Max;
        end Max;


    begin
	if Arbre = null then
	    return 0;
	else
	    return 1 + Max(Hauteur(get_Arbre_Gauche(Arbre)),Hauteur(get_Arbre_Droit(Arbre)));
	end if;
    end Hauteur;

---------------------------------------------------------------------------------------------------------------


    function get_Cle(Arbre : IN T_Arbre_Binaire) return T_Cle is
	Cle : T_Cle;
    begin
	if Arbre = null then
	    null;
	else
	    Cle := Arbre.all.Cle;
	end if;
    return Cle;
    end get_Cle;

---------------------------------------------------------------------------------------------------------------
    
    function get_Arbre_Gauche(Arbre : IN T_Arbre_Binaire) return T_Arbre_Binaire is
	Arbre1 : T_Arbre_Binaire;
    begin
	if Arbre = null then
	    null;
	else
	    Arbre1 := Arbre.all.Sous_Arbre_Gauche;
	end if;
    return Arbre1;
    end get_Arbre_Gauche;

---------------------------------------------------------------------------------------------------------------

    function get_Arbre_Droit(Arbre : IN T_Arbre_Binaire) return T_Arbre_Binaire is
	Arbre1 : T_Arbre_Binaire;
    begin
	if Arbre = null then
	    null;
	else
	    Arbre1 := Arbre.all.Sous_Arbre_Droit;
	end if;
    return Arbre1;
    end get_Arbre_Droit;

---------------------------------------------------------------------------------------------------------------

    procedure Creer_Arbre(Arbre : OUT T_Arbre_Binaire ; Cle : IN T_Cle) is
    begin
	Arbre := new T_Noeud'(Cle,null,null);
    end Creer_Arbre;


---------------------------------------------------------------------------------------------------------------

    procedure Inserer_Droite(Arbre : IN OUT T_Arbre_Binaire ; Cle : IN T_Cle) is
    begin
	if Arbre = null then
	    null;
	else
	    if Arbre.all.Sous_Arbre_Droit = null then
		Arbre.all.Sous_Arbre_Droit := new T_Noeud'(Cle,null,null);
	    end if; 
	end if;
    end Inserer_Droite;

---------------------------------------------------------------------------------------------------------------

    procedure Inserer_Gauche(Arbre : IN OUT T_Arbre_Binaire ; Cle : IN T_Cle) is
    begin
	if Arbre = null then
	    null;
	else
	    if Arbre.all.Sous_Arbre_Gauche = null then
		Arbre.all.Sous_Arbre_Gauche := new T_Noeud'(Cle,null,null);
	    end if;
	end if;
    end Inserer_Gauche;

---------------------------------------------------------------------------------------------------------------

    procedure Remplacer_Gauche(Arbre1 : IN OUT T_Arbre_Binaire ; Arbre2 : IN T_Arbre_Binaire) is 
    begin
	if Arbre2 = null then
	    null;
	else
	    Arbre1 := Arbre2.all.Sous_Arbre_Gauche;
	end if;
    end Remplacer_Gauche;

---------------------------------------------------------------------------------------------------------------

    procedure Remplacer_Droite(Arbre1 : IN OUT T_Arbre_Binaire ; Arbre2 : IN T_Arbre_Binaire) is
    begin
	if Arbre2 = null then
	    null;
	else
	    Arbre1 := Arbre2.all.Sous_Arbre_Droit;
	end if;
    end Remplacer_Droite;

---------------------------------------------------------------------------------------------------------------

    function get_Arbre_Binaire(Arbre : IN T_Arbre_Binaire) return T_Arbre_Binaire is
    begin
	return Arbre;
    end;
---------------------------------------------------------------------------------------------------------------


    function Est_Egaux_Arbres(Arbre1 : IN T_Arbre_Binaire ; Arbre2 : IN T_Arbre_Binaire) return Boolean is
	T : Boolean := false;
    begin
	if Arbre1 = Arbre2 then
	    T := true;
	end if;
    return T;
    end Est_Egaux_Arbres;

---------------------------------------------------------------------------------------------------------------

    procedure Remplacer_Arbre(Arbre1 : IN OUT T_Arbre_Binaire ; Arbre : T_Arbre_Binaire) is
    begin
	Arbre1 := Arbre;
    end Remplacer_Arbre;

---------------------------------------------------------------------------------------------------------------


     procedure Vider(Arbre : IN OUT T_Arbre_Binaire) is
     begin
	 if Arbre = null then
	     null;
	 else
	     Vider(Arbre.all.Sous_Arbre_Gauche);
	     Vider(Arbre.all.Sous_Arbre_Droit);
	     Free(Arbre);
	 end if;
     end Vider;



end Arbre_Binaire;
