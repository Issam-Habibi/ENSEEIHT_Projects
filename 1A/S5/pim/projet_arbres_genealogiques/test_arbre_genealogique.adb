with Ada.Text_IO;
use Ada.Text_IO;
with Arbre_Genealogique;
use Arbre_Genealogique;



procedure test_arbre_genealogique is


    procedure Generer_Arbre(Arbre : OUT T_Arbre_Genealogique) is

    begin
            --La création d'un arbre.
	
	    Creer_Arbre_Minimale(Arbre,1);
	    pragma assert(Nombre_Generations(Arbre) = 0);

            Ajouter_Parent(Arbre,1,2,'P');
            Ajouter_Parent(Arbre,1,3,'M');
            pragma assert(Nombre_Generations(Arbre) = 1);
	    	    
            Ajouter_Parent(Arbre,2,22,'P');
            Ajouter_Parent(Arbre,2,23,'M');
            pragma assert(Nombre_Generations(Arbre) = 2);
	    	   
            Ajouter_Parent(Arbre,3,33,'P');
            Ajouter_Parent(Arbre,3,34,'M');
            pragma assert(Nombre_Generations(Arbre) = 2);
	    
	    Ajouter_Parent(Arbre,22,25,'M');
	    Ajouter_Parent(Arbre,33,35,'P');
            pragma assert(Nombre_Generations(Arbre) = 3);
	    
	    

     end Generer_Arbre;

     Arbre : T_Arbre_Genealogique;
  
begin

        Generer_Arbre(Arbre);  --Générer l'arbre sous la forme déja définie . 

        pragma assert(Nombre_Generations(Arbre) = 3);

        New_Line;
        Afficher(Arbre);

        New_Line;


        Put_Line("L'arbre après suppression des ancetres de la clé 22");
	New_Line;
	Supprimer_Ancetres_1(Arbre,2);
	Afficher(Arbre);
	
	New_Line;


	Put_Line("Revenons à l'arbre principale . ");
	New_Line;
	New_Line;


	 Put("Le nombre des ancêtres de l'individu 1 est : "&Integer'Image(Nombre_Ancetres(Arbre,1)));

	 New_Line;
	 New_Line;

	 Put("L'ensemble des individus dont un seul parent est connu est : ");
	 Put("[");
	 Ensemble_Un_Parent_Connu(Arbre);
	 Put(" ]");

	 New_Line;
	 New_Line;

	 Put("L'ensemble des individus dont les deux parents sont connus est : ");
	 Put("[ ");
	 Ensemble_Deux_Parents_Connus(Arbre);
	 Put(" ]");

	 New_Line;
	 New_Line;

	 Put("L'ensemlbe des individus dont les deux parent son inconnus est :");
	 Put("[ ");
	 Ensemble_Deux_Parents_Inconnus(Arbre);
	 Put(" ]");

	 New_Line;
	 New_Line;

    for i in 1..3 loop

	 Put("*********** Des informations sur La Génération "&Integer'Image(i));
	 Put(" ***********");

	 New_Line;
	 New_Line;

	 Put("L'ensemble des ancêtres situés à la génération "&Integer'Image(i));
	 Put(" de l'individu 1 sont : ");
	 Put("[ ");
	 Ensemble_Ancetres(Arbre,1,i);
	 Put(" ]");

	 New_Line;
	 New_Line;

	 Put("L'ensemble des ancêtres sur " &Integer'Image(i));
	 Put("générations de l'individu 1 sont : ");
	 Put("[");
	 Identifier_Ancetres(Arbre,1,i);
	 Put(" ] ");

	 New_Line;
	 New_Line;



   end loop;

   Vider_Arbre(Arbre); --Libérer les ressources utilisés par l'arbre . 
   


end test_arbre_genealogique;


