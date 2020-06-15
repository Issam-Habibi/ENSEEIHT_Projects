with Foret;
use Foret;
with Arbre_Genealogique;
use Arbre_Genealogique;
with Ada.Text_IO;
use Ada.Text_IO;

procedure test_foret is

        procedure Generer_Foret(Foret : OUT T_Foret) is  --Générer une forêt . 

	    Arbre1 , Arbre2 ,Arbre3, Arbre4  : T_Arbre_Genealogique;

	begin

	   
            --Création du 1ér arbre
	    Creer_Arbre_Minimale(Arbre1,1);

            Ajouter_Parent(Arbre1,1,2,'P');
            Ajouter_Parent(Arbre1,1,3,'M');
	    	    
            Ajouter_Parent(Arbre1,2,22,'P');
            Ajouter_Parent(Arbre1,2,23,'M');
	    	   
            Ajouter_Parent(Arbre1,3,33,'P');
            Ajouter_Parent(Arbre1,3,34,'M');
	    
	    Ajouter_Parent(Arbre1,22,25,'M');
	    Ajouter_Parent(Arbre1,33,35,'P');


            --Création du 2éme arbre
	    Creer_Arbre_Minimale(Arbre2,5);

            Ajouter_Parent(Arbre2,5,56,'P');
            Ajouter_Parent(Arbre2,5,57,'M');
	    	    
            Ajouter_Parent(Arbre2,56,2,'P');
            Ajouter_Parent(Arbre2,56,333,'M');
	    	   
            Ajouter_Parent(Arbre2,57,257,'P');
            Ajouter_Parent(Arbre2,57,256,'M');

	    

	    --Creation du 3éme arbre . 
	    Creer_Arbre_Minimale(Arbre3,6);

            Ajouter_Parent(Arbre3,6,2,'P');
            Ajouter_Parent(Arbre3,6,27,'M');
	    	    
            Ajouter_Parent(Arbre3,2,22,'P');
            Ajouter_Parent(Arbre3,2,23,'M');
	    	   
            Ajouter_Parent(Arbre3,27,270,'P');
            Ajouter_Parent(Arbre3,27,271,'M');
	    
	    Ajouter_Parent(Arbre3,270,26,'M');
	    Ajouter_Parent(Arbre3,370,36,'P');


            --Creation du 4éme arbre
	    Creer_Arbre_Minimale(Arbre4,8);

            Ajouter_Parent(Arbre4,8,335,'P');
            Ajouter_Parent(Arbre4,8,336,'M');
	    	    
            Ajouter_Parent(Arbre4,335,29,'P');
            Ajouter_Parent(Arbre4,335,3,'M');
	    	   
            Ajouter_Parent(Arbre4,336,61,'P');
            Ajouter_Parent(Arbre4,336,57,'M');
	    




	    Ajouter_Element_Foret(Foret,Arbre1);
	    Ajouter_Element_Foret(Foret,Arbre2);
	    Ajouter_Element_Foret(Foret,Arbre3);
	    Ajouter_Element_Foret(Foret,Arbre4);


	    
     end Generer_Foret;

     Foret_1 : T_Foret;
     
     Arbre : T_Arbre_Genealogique;



begin

      Creer_Arbre_Minimale(Arbre,1);

      Ajouter_Parent(Arbre,1,2,'P');
      Ajouter_Parent(Arbre,1,3,'M');
	    	    
      Ajouter_Parent(Arbre,2,22,'P');
      Ajouter_Parent(Arbre,2,23,'M');
	    	   
      Ajouter_Parent(Arbre,3,33,'P');
      Ajouter_Parent(Arbre,3,34,'M');
	    
      Ajouter_Parent(Arbre,22,25,'M');
      Ajouter_Parent(Arbre,33,35,'P');


     Generer_Foret(Foret_1);
     New_Line;
     Put("L'ensemble des demi frères et soeurs de l'individu 1 est : ");
     Put("[");
     Ensemble_Demi_Freres_Soeurs(Foret_1,1,Arbre);
     Put(" ]");
     New_Line;

     Detruire_Foret(Foret_1);

end test_foret;

