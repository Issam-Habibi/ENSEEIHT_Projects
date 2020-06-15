with Registre;
use Registre;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Text_IO;
use Ada.Text_IO;



procedure Test_Registre is
        

        Cles : constant array (1..5) of Integer
                          := (1, 2, 3, 4, 5);
     
        Donnees : array (1..5) of T_Donnee;

	Donnee_1 , Donnee_2 , Donnee_3 , Donnee_4 , Donnee_5 : T_Donnee;

        Un_Registre : T_Registre;

        Donnee : T_Donnee;
 

begin
       --On crée un registre de données.
    
       Donnee_1.Nom := To_Unbounded_String("HABIBI");
       Donnee_1.Prenom := To_Unbounded_String("ISSAM");
       Donnee_1.Annee_De_Naissance := 1999;
       Donnee_1.Pays := To_Unbounded_String("MAROC");

       Donnee_2.Nom := To_Unbounded_String("BIN ABOULHAMID");
       Donnee_2.Prenom := To_Unbounded_String("ALI");
       Donnee_2.Annee_De_Naissance := 1992;
       Donnee_2.Pays := To_Unbounded_String("MAROC");

       Donnee_3.Nom := To_Unbounded_String("HABIBI");
       Donnee_3.Prenom := To_Unbounded_String("SAID");
       Donnee_3.Annee_De_Naissance := 1960;
       Donnee_3.Pays := To_Unbounded_String("MAROC");

       Donnee_4.Nom := To_Unbounded_String("REFASS");
       Donnee_4.Prenom := To_Unbounded_String("BOUCHRA");
       Donnee_4.Annee_De_Naissance := 1969;
       Donnee_4.Pays := To_Unbounded_String("MAROC");

       Donnee_5.Nom := To_Unbounded_String("ALEX");
       Donnee_5.Prenom := To_Unbounded_String("ICH");
       Donnee_5.Annee_De_Naissance := 1995;
       Donnee_5.Pays := To_Unbounded_String("USA");


       Donnees := (Donnee_1,Donnee_2,Donnee_3,Donnee_4,Donnee_5);

       Initialiser_Registre (Un_Registre);
        -- On test les sous programmes Initialiser_Registre, Est_Registre_Vide et Nombre_Individus
 
       Donnees := (Donnee_1,Donnee_2,Donnee_3,Donnee_4,Donnee_5);

       Initialiser_Registre (Un_Registre);
        -- On test les sous programmes Initialiser_Registre, Est_Registre_Vide et Nombre_Individus
        pragma Assert (Est_Registre_Vide (Un_Registre));
        pragma Assert (Taille_Registre(Un_Registre) = 0);

        for i in 1..5 loop
	    Inserer(Un_Registre, Cles(i), Donnees(i));
            pragma Assert (not Est_Registre_Vide (Un_Registre));
            pragma Assert (Taille_Registre(Un_Registre) = i);

	    Donnee := Obtenir_Donnee(Un_Registre,i);
	    New_Line;
	    Put("Le nom de l'individu "&Integer'Image(i));
	    Put(" est : ");
	    Put(To_string(Donnee.Nom));
	    New_Line;
	    New_Line;
	    Put("l'annéee de naissance de l'individu "&Integer'Image(i));
	    Put(" est : "&Integer'Image(Donnee.Annee_De_Naissance));
	    New_Line;
	    New_Line;
	    Put("Le pays de résidence de l'individu "&Integer'Image(i));
	    Put(" est : ");
	    Put(To_string(Donnee.Pays));
	    New_Line;
        end loop;


	Vider_Registre(Un_Registre); --Libérer les ressources utilisées par registre.


end Test_registre;
