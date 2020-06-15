with Ensembles_Chainage;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Unchecked_Deallocation;



package body Foret is
    
    --On instancie le packetage Ensemlbe_Chainage pour l'utiliser dans le stockage et l'affichage des clés représentant
    --les demis frères et soeurs d'un ijndividu 
    package  Ensemble_Entiers is 
	new Ensembles_Chainage( T_Element => Integer);
    use Ensemble_Entiers;

    procedure Operation_Element(k : IN Integer) is
    begin
	 Put(" "&Integer'Image(k));
    end Operation_Element;

    procedure Afficher is new Ensemble_Entiers.Appliquer_Sur_Tous(Operation_Element);

    procedure Free is
	new Ada.Unchecked_Deallocation (T_Cellule_Foret,T_Foret);


-----------------------------------------------------------------------------------------------------------------

    procedure Initialiser_Foret(Foret : OUT T_Foret) is
    begin
	Foret := null;
    end Initialiser_Foret;

-----------------------------------------------------------------------------------------------------------------

    procedure Ajouter_Element_Foret(Foret : IN OUT T_Foret ; Arbre : IN T_Arbre_Genealogique) is
    begin
	Foret := new T_Cellule_Foret'(get_Arbre(Arbre),Foret);
    end Ajouter_Element_Foret;

-----------------------------------------------------------------------------------------------------------------


    function Taille_Foret(Foret : IN T_Foret) return Integer is
	Foret_1 : T_Foret := Foret;
	s : Integer := 0;
    begin
	while Foret_1 /= null loop
	    Foret_1 := Foret_1.all.Suivant;
	    s := s + 1;
	end loop; 
     return s;
     end Taille_Foret;

-----------------------------------------------------------------------------------------------------------------

    procedure Supprimer_Arbre(Foret : IN OUT T_Foret ; Arbre : IN T_Arbre_Genealogique) is
    begin
	 if Est_Egaux(Foret.all.Arbre,Arbre) then
	     Foret := Foret.all.Suivant;
	 else
	     Supprimer_Arbre(Foret.all.Suivant,Arbre);
	 end if;
    end Supprimer_Arbre;

-----------------------------------------------------------------------------------------------------------------
 

    procedure Ensemble_Demi_Freres_Soeurs(Foret : IN OUT T_Foret ; Cle_Individu : IN Integer ; Arbre : IN T_Arbre_Genealogique) is
	Cle_Pere , Cle_Fils , Cle_Mere : Integer;
	Ensemble : T_Ensemble;
    begin

	if Foret = null then
	    null;
	else
	    Cle_Pere := get_Cle_Pere(Arbre,Cle_Individu); --On récupère la clé du père de l'individu
	    Cle_Mere := get_Cle_Mere(Arbre,Cle_Individu); --On récupère la clé du mère de l'individu . 
	    while Foret /= null loop --On parcours la forêt . 
		--Si on ne rencontre pas un arbre contenant la clé du père oubien du mère , on passe au suivant.
		if not Est_Cle_Presente_1(Foret.all.Arbre,Cle_Pere) and not Est_Cle_Presente_1(Foret.all.Arbre,Cle_Mere) then
		    Foret := Foret.all.Suivant;
		--Si on trouve un arbre contenant la clé du père , en rentre là dedans.
		elsif Est_Cle_Presente_1(Foret.all.Arbre,Cle_Pere) then
		    Cle_Fils := get_Cle_Fils(Foret.all.Arbre,Cle_Pere); --On récupère la clé du fils du père .
		    if Cle_Fils /= Cle_Individu then --si le fils est différent de l'individu
			Ajouter_Element(Ensemble,Cle_Fils); --On stock la clé du fils dans un ensemble . 
		    end if;
		    Foret := Foret.all.Suivant; --On continue le parcours du forêt . 
		elsif Est_Cle_Presente_1(Foret.all.Arbre,Cle_Mere) then --Si on trouve la mère dans un arbre on effectute le même traitement . 
		    Cle_Fils := get_Cle_Fils(Foret.all.Arbre,Cle_Mere);
		    if Cle_Fils /= Cle_Individu then
			Ajouter_Element(Ensemble,Cle_Fils);
	            end if;
		    Foret := Foret.all.Suivant;
		end if;
	    end loop;
	end if;
	Afficher(Ensemble); --L'affichage de l'ensemble des demi-frères et soeurs 
    end Ensemble_Demi_Freres_Soeurs;

-----------------------------------------------------------------------------------------------------------------


    procedure Detruire_Foret( Foret : IN OUT T_Foret ) is
    begin
	if Foret /= null then
	    Detruire_Foret(Foret.all.Suivant);
	    Free(Foret);
	else
	    null;
	end if;
    end Detruire_Foret; 


end Foret;



