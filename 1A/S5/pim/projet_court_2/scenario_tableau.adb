with Ensembles_Tableau;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Text_IO;
use Ada.Text_IO;



procedure Test_Ensembles_Sujet_Tableau is


	-- Instancier le paquetage Ensembles_Tableau pour avoir un Ensemble
	-- d'entiers de capacité 10

	-- Définir une opération Afficher qui affiche les éléments d'un ensemble
	-- d'entier en s'appuyant sur Appliquer_Sur_Tous.  L'ensemble {5, 28, 10}
	-- sera affiché :
	--           5         28         10
         


	  package Ensemble_10 is 
	      new Ensembles_Tableau(CAPACITE => 10 , T_Element => Integer);
	  use Ensemble_10;

	  procedure Afficher_Element(k : IN Integer) is
	  begin
	      Put("         "&Integer'Image(k));
	  end Afficher_Element;

	  procedure Afficher is new Ensemble_10.Appliquer_Sur_Tous(Afficher_Element);


	  Ens1 : T_Ensemble;

begin

        
	-- Créer un ensemble vide Ens1
        Initialiser(Ens1);
	-- Afficher l'ensemble
	Afficher (Ens1);
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
	pragma Assert (Est_Vide(Ens1));
	pragma Assert (Taille_Ensemble(Ens1)=0);
	pragma Assert (not Est_Present(Ens1,2));
	pragma Assert (not Est_Present(Ens1,5));
	pragma Assert (not Est_Present(Ens1,7));
	pragma Assert (not Est_Present(Ens1,10));
	New_Line;



	-- Ajouter 5 dans Ens1
	Ajouter_Element(Ens1,5);
	-- Afficher l'ensemble
	Afficher (Ens1);
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
	pragma Assert (Est_Vide(Ens1));
	pragma Assert (Taille_Ensemble(Ens1)=1);
	pragma Assert (not Est_Present(Ens1,2));
	pragma Assert (Est_Present(Ens1,5));
	pragma Assert (not Est_Present(Ens1,7));
	pragma Assert (not Est_Present(Ens1,10));
	New_Line;

	
	-- Ajouter 28 puis 10 dans Ens1
	
	Ajouter_Element(Ens1,28);
	Ajouter_Element(Ens1,10);
	-- Afficher l'ensemble
	Afficher (Ens1);
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
	pragma Assert (Est_Vide(Ens1));
	pragma Assert (Taille_Ensemble(Ens1)=3);
	pragma Assert (not Est_Present(Ens1,2));
	pragma Assert (Est_Present(Ens1,5));
	pragma Assert (not Est_Present(Ens1,7));
	pragma Assert (Est_Present(Ens1,10));
	New_Line;



	-- Ajouter 7 dans Ens1
	Ajouter_Element(Ens1,7);
	-- Afficher l'ensemble
	Afficher (Ens1);
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
	pragma Assert (Est_Vide(Ens1));
	pragma Assert (Taille_Ensemble(Ens1)=4);
	pragma Assert (not Est_Present(Ens1,2));
	pragma Assert ( Est_Present(Ens1,5));
	pragma Assert (Est_Present(Ens1,7));
	pragma Assert (not Est_Present(Ens1,10));
	New_Line;

	-- Supprimer 10 en Ens1
	--
	Supprimer_Element(Ens1,10);
	-- Afficher l'ensemble
	Afficher (Ens1);
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
	pragma Assert (Est_Vide(Ens1));
	pragma Assert (Taille_Ensemble(Ens1)=3);
	pragma Assert (not Est_Present(Ens1,2));
	pragma Assert (Est_Present(Ens1,5));
	pragma Assert (Est_Present(Ens1,7));
	pragma Assert (not Est_Present(Ens1,10));
	New_Line;

	--
	-- Supprimer 7 en Ens1
	--
	Supprimer_Element(Ens1,7);
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
	pragma Assert (Est_Vide(Ens1));
	pragma Assert (Taille_Ensemble(Ens1)=2);
	pragma Assert (not Est_Present(Ens1,2));
	pragma Assert (Est_Present(Ens1,5));
	pragma Assert (not Est_Present(Ens1,7));
	pragma Assert (not Est_Present(Ens1,10));
	


	--

	-- Supprimer 5 en Ens1
	Supprimer_Element(Ens1,5);
	-- Afficher l'ensemble
	Afficher (Ens1);
	-- Vérifier si vide ou non, sa taille, la présence ou pas de 2, 5, 7, 10
	pragma Assert (Est_Vide(Ens1));
	pragma Assert (Taille_Ensemble(Ens1)=1);
	pragma Assert (not Est_Present(Ens1,2));
	pragma Assert (not Est_Present(Ens1,5));
	pragma Assert (not Est_Present(Ens1,7));
	pragma Assert (not Est_Present(Ens1,10));
	New_Line;

	--

	-- Détruire l'ensemble
	Detruire(Ens1);    --Cette procédure ne fait rien dans le cas d'un Ensemble modéliser par un tableau.

end Test_Ensembles_Sujet_Tableau;
