--Implantation du module Ensembles_Chainage . 
with Ada.Unchecked_Deallocation;

package body Ensembles_Chainage is

    procedure Free is
	new Ada.Unchecked_Deallocation (T_Cellule, T_Ensemble);


    procedure Initialiser ( E : OUT T_Ensemble ) is
    begin
	E := null;
    end Initialiser;


    procedure Detruire ( E : IN OUT T_Ensemble ) is
    begin
	if E /= null then
	    Detruire(E.all.Suivant);
	    Free(E);
	else
	    null;
	end if;
    end Detruire;



    function Est_Vide( E : IN T_Ensemble ) return Boolean is 
    begin
	return E = null;
    end Est_Vide;



    function Taille_Ensemble(E : IN T_Ensemble) return Integer is
	s : Integer :=0;
	L1 : T_Ensemble;
    begin
	L1 := E;
	while L1 /= null loop
	    s := s + 1;
	    L1 := L1.all.Suivant;
	end loop;

    return s;
    end Taille_Ensemble;



    function Est_Present( E : IN T_Ensemble ; Y : IN T_Element ) return Boolean is
	L1 : T_Ensemble;
	T : Boolean := False;
    begin
	L1 := E;
	while L1 /= null loop
	    if L1.all.Element = Y then
		T := True;
	    end if;
	    L1 := L1.all.Suivant;
	end loop;
    return T;
    end Est_Present;


     procedure Ajouter_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) is
     begin
	 E := new T_Cellule'(Y,E);
     end Ajouter_Element;


     procedure Supprimer_Element(E : IN OUT T_Ensemble ; Y : IN T_Element) is
     begin
	 if E.all.Element = Y then
	     E := E.all.Suivant;
	 else
	     Supprimer_Element(E.all.Suivant,Y);
	 end if;
    end Supprimer_Element;



    procedure Appliquer_Sur_Tous( E : IN T_Ensemble ) is
	L1 : T_Ensemble;
    begin
	L1 := E;
	while L1 /= null loop
	    Operation_Element(L1.all.Element);
	    L1 := L1.all.Suivant;
	end loop;
    end Appliquer_Sur_Tous;
    


end Ensembles_Chainage;

	
	                
