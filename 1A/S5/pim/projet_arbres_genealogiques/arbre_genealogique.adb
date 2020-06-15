with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;


package body Arbre_Genealogique is


---------------------------------------------------------------------------------------------------------------------------------------------

    function Est_Cle_Presente_1(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Boolean is
    begin
	return Est_Cle_Presente(Arbre,Cle);
    end Est_Cle_Presente_1;
----------------------------------------------------------------------------------------------------------------------------------------------


    procedure Creer_Arbre_Minimale(Arbre : OUT T_Arbre_Genealogique ; Cle : IN Integer) is
    begin
	Creer_Arbre(Arbre,Cle);
    end Creer_Arbre_Minimale;

--------------------------------------------------------------------------------------------------------------------------------------------

    procedure Ajouter_Parent(Arbre : IN OUT T_Arbre_Genealogique ; Cle : IN Integer ; Cle_Parent : IN Integer ; Type_Parent : Character) is
	Arbre1 , Arbre2 : T_Arbre_Genealogique;  --Des variables intérmediaires.
    begin
	if Est_Arbre_Vide(Arbre)  then
	    null;
	else
	    if Cle = get_Cle(Arbre) then
		if Type_Parent = 'P' then
		    Inserer_Gauche(Arbre,Cle_Parent);
		elsif Type_Parent = 'M' then
		    Inserer_Droite(Arbre,Cle_Parent);
		else
		    null;
		end if;
            else
		Remplacer_Gauche(Arbre1,Arbre);    --Remplacer l'arbre Arbre1 par le sous arbre gauche de Arbre.
		Remplacer_Droite(Arbre2,Arbre);    --Remplace l'arbre Arbre 2 par le sous arbre droit de Arbre.
		Ajouter_Parent(Arbre1,Cle,Cle_Parent,Type_Parent); --Appliquer la récursivité au
		Ajouter_Parent(Arbre2,Cle,Cle_Parent,Type_Parent);
            end if;
	end if;
     end Ajouter_Parent;



-----------------------------------------------------------------------------------------------------------------------------------------------------

     function Nombre_Ancetres(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer is
     begin
         if Est_Arbre_Vide(Arbre) then
	     return 0;
	 else
	     if Cle = get_Cle(Arbre) then
		 return Nombre_Elements(Arbre);
	     else
		 return Nombre_Ancetres(get_Arbre_Gauche(Arbre),Cle) + Nombre_Ancetres(get_Arbre_Droit(Arbre),Cle);
	     end if;
	 end if;
     end Nombre_Ancetres;

-----------------------------------------------------------------------------------------------------------------------------------------------------
     
     procedure Supprimer_Ancetres_1(Arbre : IN OUT T_Arbre_Genealogique ; Cle : IN Integer) is

     begin
	 Supprimer_Ancetres(Arbre,Cle);
     end Supprimer_Ancetres_1;


-----------------------------------------------------------------------------------------------------------------------------------------------------

	      procedure Ensemble_Un_Parent_Connu(Arbre : IN T_Arbre_Genealogique) is

		  Ensemble : T_Ensemble;

		  	            
	      begin
	           if Est_Arbre_Vide(Arbre) then
		        null;
	           else
		        if Est_Arbre_Vide(get_Arbre_Gauche(Arbre)) and not Est_Arbre_Vide(get_Arbre_Droit(Arbre)) then
			    Ajouter_Element(Ensemble,get_Cle(Arbre));
			    Afficher(Ensemble);

		        elsif not Est_Arbre_Vide(get_Arbre_Gauche(Arbre)) and Est_Arbre_Vide(get_Arbre_Droit(Arbre)) then
			    Ajouter_Element(Ensemble,get_Cle(Arbre));
			    Afficher(Ensemble);

		        else
		            null;
		        end if;
		   Ensemble_Un_Parent_Connu(get_Arbre_Gauche(Arbre));
		   Ensemble_Un_Parent_Connu(get_Arbre_Droit(Arbre));
	           end if;
              end Ensemble_Un_Parent_Connu;

-----------------------------------------------------------------------------------------------------------------------------------------------



	procedure Ensemble_Deux_Parents_Connus(Arbre : IN T_Arbre_Genealogique) is

	    Ensemble : T_Ensemble;

	begin
	    if Est_Arbre_Vide(Arbre) then
		null;
            else 
		if not Est_Arbre_Vide(get_Arbre_Gauche(Arbre))  and not Est_Arbre_Vide(get_Arbre_Droit(Arbre)) then

		    Ajouter_Element(Ensemble,get_Cle(Arbre));
		    Afficher(Ensemble);
		else
		    null;
		end if;
	    Ensemble_Deux_Parents_Connus(get_Arbre_Gauche(Arbre));
	    Ensemble_Deux_Parents_Connus(get_Arbre_Droit(Arbre));
	    end if;
	end Ensemble_Deux_Parents_Connus;


--------------------------------------------------------------------------------------------------------------------------------------------


	  procedure Ensemble_Deux_Parents_Inconnus(Arbre : IN T_Arbre_Genealogique) is

	      Ensemble : T_Ensemble;

	  begin
	      if Est_Arbre_Vide(Arbre) then
		  null;
	      else
		  if Est_Arbre_Vide(get_Arbre_Gauche(Arbre)) and Est_Arbre_Vide(get_Arbre_Droit(Arbre)) then

		      Ajouter_Element(Ensemble,get_Cle(Arbre));
		      Afficher(Ensemble);
		  else
		      null;
		  end if;
	      Ensemble_Deux_Parents_Inconnus(get_Arbre_Gauche(Arbre));
	      Ensemble_Deux_Parents_Inconnus(get_Arbre_Droit(Arbre));
              end if;
	 end Ensemble_Deux_Parents_Inconnus;


----------------------------------------------------------------------------------------------------------------------

      procedure Ensemble_Ancetres(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer ; Generation : IN Integer) is

	  procedure Sous_Ensemble_Ancetres(Arbre : IN T_Arbre_Genealogique ; Generation : IN Integer) is

	      Ensemble : T_Ensemble;

	  begin
	      if Est_Arbre_Vide(Arbre) then
		  null;
              else
		  if Generation = 0 and not Est_Arbre_Vide(Arbre) then

		      Ajouter_Element(Ensemble,get_Cle(Arbre));
		      Afficher(Ensemble);
		  else
		      null;
		  end if;
	      Sous_Ensemble_Ancetres(get_Arbre_Gauche(Arbre),Generation - 1);
	      Sous_Ensemble_Ancetres(get_Arbre_Droit(Arbre),Generation - 1);
	      end if;
	  end Sous_Ensemble_Ancetres;

      begin
	  if Est_Arbre_Vide(Arbre) then
	      null;
	  else
	      if Cle = get_Cle(Arbre) then 
		  Sous_Ensemble_Ancetres(Arbre,Generation);
	      else
		  null;
	      end if;
	  Ensemble_Ancetres(get_Arbre_Gauche(Arbre),Cle,Generation);
	  Ensemble_Ancetres(get_Arbre_Droit(Arbre),Cle,Generation);
          end if;
      end Ensemble_Ancetres;


-------------------------------------------------------------------------------------------------------

     procedure Identifier_Ancetres(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer ; Generation : IN Integer) is

	  procedure Sous_Identifier(Arbre : IN T_Arbre_Genealogique ; Generation : IN Integer) is

	      Ensemble : T_Ensemble;

	  begin
	      if Est_Arbre_Vide(Arbre) then
		  null;
              else
		  if Generation >= 0 and not Est_Arbre_Vide(Arbre) then

		      Ajouter_Element(Ensemble,get_Cle(Arbre));
		      Afficher(Ensemble);
		  else
		      null;
		  end if;
	      Sous_Identifier(get_Arbre_Gauche(Arbre),Generation - 1);
	      Sous_Identifier(get_Arbre_Droit(Arbre),Generation - 1);
	      end if;
	  end Sous_Identifier;

      begin
	  if Est_Arbre_Vide(Arbre) then
	      null;
	  else
	      if Cle = get_Cle(Arbre) then 
		  Sous_Identifier(Arbre,Generation);
	      else
		   Identifier_Ancetres(get_Arbre_Gauche(Arbre),Cle,Generation);
	           Identifier_Ancetres(get_Arbre_Droit(Arbre),Cle,Generation);		 
	      end if;
          end if;
      end Identifier_Ancetres;

-------------------------------------------------------------------------------------------------------------

      function Nombre_Generations(Arbre : IN T_Arbre_Genealogique) return Integer is
      begin
	  return Hauteur(Arbre) - 1;	  --On considère que la génération 0 correspond à la racine.
      end Nombre_Generations;
	  
	  
----------------------------------------------------------------------------------------------------------------
     
    procedure Afficher_Arbre(Arbre : IN T_Arbre_Genealogique) is

	procedure Indenter(Decalage : IN Integer) is

	begin
	    for i in 1..Decalage loop
		Put(' ');
            end loop;
	end Indenter;

	procedure Afficher_Profondeur(Arbre : IN T_Arbre_Genealogique ; Profondeur : IN Integer ; Cote : IN string) is
	begin
	    if Est_Arbre_Vide(Arbre) then
		null;
	    else
		Indenter(Profondeur*4);
		Put(Cote);
		Put(" : ");
		Put(get_Cle(Arbre),0);
		New_Line;
		Afficher_Profondeur(get_Arbre_Gauche(Arbre),Profondeur + 1,"-- père");
		Afficher_Profondeur(get_Arbre_Droit(Arbre),Profondeur + 1,"-- mère");
	     end if;
	end Afficher_Profondeur;


    begin
	Afficher_Profondeur(Arbre,0,"/Racine");
    end Afficher_Arbre;

-----------------------------------------------------------------------------------------------

     procedure Afficher(Arbre : IN T_Arbre_Genealogique) is
   
	  procedure Afficher_Generations(Arbre : IN T_Arbre_Genealogique) is 
	  begin
	      Put(0,0);
	      Put(' ');
	      Put(' ');
	      for i in 1..Nombre_Generations(Arbre) loop
		  Put(i,0);
		  Put(' ');
		  Put(' ');
              end loop;
	      Put("Generations");
	      New_Line;
	      for i in 0..Nombre_Generations(Arbre) loop
		  Put("--------");
	      end loop;
	      New_Line;
	  end Afficher_Generations;


      begin
	  if Est_Arbre_Vide(Arbre) then
	      null;
	  else
	      Afficher_Generations(Arbre);
	      Afficher_Arbre(Arbre);
	  end if;
      end Afficher;

----------------------------------------------------------------------------------------------------------------------
      
      procedure Afficher_Element(n : Integer) is
      begin
	  Put(""&Integer'Image(n));
      end Afficher_Element;


------------------------------------------------------------------------------------------------------------------------
     
      function get_Cle_Pere(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer is
	  Arbre1 , Arbre2 : T_Arbre_Genealogique;
	  n : Integer;
      begin
	  if Est_Arbre_Vide(Arbre)  then
	      null;
	  elsif Cle = get_Cle(Arbre) then
	      if not Est_Arbre_Vide(get_Arbre_Gauche(Arbre)) then
		  return get_Cle(get_Arbre_Gauche(Arbre));
	      else
		  null;	
	      end if;
          else
	      Remplacer_Gauche(Arbre1,Arbre);
	      Remplacer_Droite(Arbre2,Arbre);
	      n := get_Cle_Pere(Arbre1,Cle) + get_Cle_Pere(Arbre2,Cle);
	  end if;
       return n;
      end get_Cle_Pere;


---------------------------------------------------------------------------------------------------------------

      function get_Cle_Mere(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer is
      	  Arbre1 , Arbre2 : T_Arbre_Genealogique;
	  n : Integer;
      begin
	  if Est_Arbre_Vide(Arbre)  then
	      null;
	  elsif Cle = get_Cle(Arbre) then
	      if not Est_Arbre_Vide(get_Arbre_Droit(Arbre)) then
		  return get_Cle(get_Arbre_Droit(Arbre));
	      else
		  null;	
	      end if;
          else
	      Remplacer_Gauche(Arbre1,Arbre);
	      Remplacer_Droite(Arbre2,Arbre);
	      n := get_Cle_Mere(Arbre1,Cle) + get_Cle_Mere(Arbre2,Cle);
	  end if;
       return n;
      end get_Cle_Mere;

---------------------------------------------------------------------------------------------------------------
      --
      function get_Cle_Fils(Arbre : IN T_Arbre_Genealogique ; Cle : IN Integer) return Integer is
	  Arbre1 , Arbre2 : T_Arbre_Genealogique;
	  n : Integer;
      begin
	  if Est_Arbre_Vide(Arbre) then
	      null;
	  else
	      if not Est_Arbre_Vide(get_Arbre_Gauche(Arbre)) and not Est_Arbre_Vide(get_Arbre_Droit(Arbre)) then
		  Remplacer_Gauche(Arbre1,Arbre);
		  Remplacer_Droite(Arbre2,Arbre);
		  if Cle = get_Cle(Arbre1) or Cle = get_Cle(Arbre2) then
		      return get_Cle(Arbre);
		  else
		      n := get_Cle_Fils(Arbre1,Cle) + get_Cle_Fils(Arbre2,Cle);
		  end if;
	      end if;
	  end if;
	  return n;
      end get_Cle_Fils;

      

-----------------------------------------------------------------------------------------------------------------
      
      function Est_Egaux(Arbre1 : IN T_Arbre_Genealogique ; Arbre2 : IN T_Arbre_Genealogique) return Boolean is
      begin
	  return Est_Egaux_Arbres(Arbre1,Arbre2);
      end Est_Egaux;


-------------------------------------------------------------------------------------------
      
      function get_Arbre(Arbre : IN T_Arbre_Genealogique) return T_Arbre_Genealogique is
      begin
	  return get_Arbre_Binaire(Arbre);
      end get_Arbre;
	 
------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------

      procedure Remplacer_Arbre_1(Arbre1 : IN OUT T_Arbre_Genealogique ; Arbre : IN T_Arbre_Genealogique) is
      begin
	  Remplacer_Arbre(Arbre1,Arbre);
      end Remplacer_Arbre_1;
      
	       
      
------------------------------------------------------------------------------------------------------
      procedure Vider_Arbre(Arbre : IN OUT T_Arbre_Genealogique) is
      begin
	  Vider(Arbre);
      end Vider_Arbre;

     


end Arbre_Genealogique;

    














    



