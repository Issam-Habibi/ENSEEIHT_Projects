with Ensembles_Chainage;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;

procedure Test_Ensembles_Chainage is

    -- On va faire un test qui Affiche un ensemble contenant les entiers de 1 à 10 , l'affichage serait sous la forme : 1  2  3  4  5  6  7  8  9  10. 
 
    Procedure Test_Ensemble_1 is 

          package Ensemble_Entiers is
	      new Ensembles_Chainage(T_Element => Integer);
          use Ensemble_Entiers;

	  procedure Operation_Element(k : IN Integer) is
	  begin
	      Put(" "&Integer'Image(k));
	  end Operation_Element;

          procedure Afficher is new Ensemble_Entiers.Appliquer_Sur_Tous(Operation_Element);

	Ens:T_Ensemble;


    --La création et l'affichage de l'ensemble 
    begin
	Put_Line("L'ensemble d'entiers entre 1 et 10 :");
	Initialiser(Ens);
	for i in 1..10 loop
	    Ajouter_Element(Ens,i);
	end loop;
	Afficher(Ens);
	Pragma Assert(Taille_Ensemble(Ens)=10);    --La taille de l'ensemble est 10
	Pragma Assert(Est_Present(Ens,2));
	Pragma Assert(not Est_Present(Ens,11));        --2 appartient à l'ensemble mais 11 n'appartient pas à l'ensemble.
    end Test_Ensemble_1;
  

    -- On va faire un test qui affiche un ensemble de charactères et puis supprime quelque uns , l'affichage est 'A'  'B'  ...... ect . 
    
    Procedure Test_Ensemble_2 is

	package Ensemble_Characteres is
	    new Ensembles_Chainage(T_Element => character);
	use Ensemble_characteres;

	procedure Operation_Element(y : IN character) is
	begin
	    Put(" "&Character'Image(y));
	end Operation_Element;

	procedure Afficher is new Ensemble_Characteres.Appliquer_Sur_Tous(Operation_Element);

	Ens: T_Ensemble;
    begin
	Put_Line("L'ensemble des charactères : ");
	Initialiser(Ens);
	--L'ajout des éléments . 
	Ajouter_Element(Ens,'A');
	Ajouter_Element(Ens,'B');
	Ajouter_Element(Ens,'C');
	Ajouter_Element(Ens,'D');
	Ajouter_Element(Ens,'E');
	Ajouter_Element(Ens,'Z');
	Ajouter_Element(Ens,'W');
	pragma Assert(Taille_Ensemble(Ens)=7); --On vérifie que la taille de l'ensemble est 7 et la présence de A et l'absence de Y 
	pragma Assert(Est_Present(Ens,'A'));
	pragma Assert(not Est_Present(Ens,'Y')); 
	Afficher(Ens);
	New_Line;
	Put_Line("L'ensemble des charactères après suppression des éléments B,C et E ");
	Supprimer_Element(Ens,'B');
	Supprimer_Element(Ens,'C');
	Supprimer_Element(Ens,'E');
	Pragma Assert(Taille_Ensemble(Ens)=4); -- On vérifie qu'après la supression que la taille est devenu 4 
	pragma Assert(not Est_Present(Ens,'E'));
	Afficher(Ens);
    end Test_Ensemble_2;


begin
    Test_Ensemble_1;
    New_Line;
    New_Line;
    Test_Ensemble_2;
    
end Test_Ensembles_Chainage;




