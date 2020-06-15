with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Integer_Text_IO;
use Ada.Integer_Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Arbre_Genealogique;
use Arbre_Genealogique;
with Registre;
use Registre;

procedure main is


    Arbre : T_Arbre_Genealogique;
    Le_Registre : T_Registre;
    Type_Parent : Character;
    Donnee : T_Donnee;
    Choix_1 : Integer := 100;
    Choix_2 : Integer := 100;
    Choix_3 : Integer := 100;
    Choix_4 : Character := 'n';
    Choix_5 : Integer := 100;
    Cle , Cle_Parent , p , Annee , Nombre_Generations : Integer;

 

begin
     
       Initialiser_Registre(Le_Registre); --On initialiser un registere pour le remplire au fur et à mesure avec le remplissage de l'arbre.

       while Choix_1 /= 3 loop

             New_Line;
	     Put_Line("**********************************************************************************");
	     New_Line;
	     Put_Line("                                  MENU PRINCIPAL                                  ");
	     New_Line;
	     Put_Line("**********************************************************************************");
	     New_Line;

	     New_Line;
	     New_Line;
	     Put_Line("Veuillez saisir un choix parmis les trois suivants");
	     New_Line;
	     New_Line;
	     Put_Line("   1- Acceder au registre d'état civil de l'arbre généalogique ");
	     Put_Line("   2- Acceder au fonctionnalités de l'arbre généalogique ");
	     Put_Line("   3- Quitter le menu");
	     New_Line;
	     New_Line;
	     Put("Votre choix est : ");
 	     Get(Choix_1);
	     New_Line;

	     if Choix_1 = 1 then

		   
		   while Choix_3 /= 3 loop

		           New_Line;
		           Put_Line("Veuillez saisir un choix parmis les suivants");
		           New_Line;
		           New_Line;
		           Put_Line("   1- Ajouter des données à un individu");
		           Put_Line("   2- Obtenir les données d'un individu");
		           Put_Line("   3- Revenir au menu principal");
			   New_Line;
			   New_Line;
			   Put("Votre choix est : ");
			   Get(Choix_3);
			   New_Line;


			   if Choix_3 = 1 then

			         while Choix_4 /= 'o' loop

				       New_Line;
				       loop
				           Put("Veuillez saisir la clé de l'individu : ");
					   Get(Cle);
				       exit when Est_Cle_Presente_1(Arbre,Cle);
				       end loop;
				       Skip_Line;
		                       Put("Veuillez saisir Le nom de l'individu : ");
		                       Inserer_Nom(Le_Registre,Cle,To_Unbounded_String(Get_Line));
	         	               Put("Veuillez saisir Le prénom de l'individu : ");
		                       Inserer_Prenom(Le_Registre,Cle,To_Unbounded_String(Get_Line));
		                       Put("Veuillez saisir L'année de naissance de l'individu : ");
				       Get(Annee);
				       Skip_Line;
				       Inserer_Annee_De_Naissance(Le_Registre,Cle,Annee);
		                       Put("Veuillez saisir Le pays de résidence de l'individu : ");
				       Inserer_Pays(Le_Registre,Cle,To_Unbounded_String(Get_Line));
				       New_Line;
				       New_Line;
				       New_Line;
		                       Put_Line("Voulez-vous revenir au Menu-Registre ? (o/n) : ");
		                       Get(Choix_4);
				       New_Line;

				 end loop;
				 Choix_4 := 'n';


			   elsif Choix_3 = 2 then

			         while Choix_5 /= 5 loop

				        New_Line;
					Put_Line(" Veuillez choisir l'information que vous voulez Obtenir ");
		                        Put_Line(" 1- Le nom d'un individu ");					
		                        Put_Line(" 2- Le prénom d'un individu");
		                        Put_Line(" 3- L'année de naissance d'un individu");
		                        Put_Line(" 4- Le pays de résidence d'un individu");
		                        Put_Line(" 5- Revenir au Menu-Registre ");
		                        New_Line;
		                        New_Line;
		                        Put(" Votre choix est : ");
		                        Get(Choix_5);


					if Choix_5 = 1 then 

                                             
				              loop
				                   Put("Veuillez saisir la clé de l'individu : ");
					           Get(Cle);
				              exit when Est_Cle_Presente_1(Arbre,Cle);
				              end loop;
					      Skip_Line;
		                              New_Line;
		                              Put("Le nom de l'individu est : ");
		                              Put(To_String(Obtenir_Donnee(Le_Registre,Cle).Nom));
		                              New_Line;


					elsif Choix_5 = 2 then

				               loop
				                     Put("Veuillez saisir la clé de l'individu : ");
					             Get(Cle);
				               exit when Est_Cle_Presente_1(Arbre,Cle);
				               end loop;
					       Skip_Line;
		                               New_Line;
		                               Put("Le prenom de l'individu est : ");
		                               Put(To_String(Obtenir_Donnee(Le_Registre,Cle).Prenom));
		                               New_Line;


				        elsif Choix_5 = 3 then
				              loop
				                 Put("Veuillez saisir la clé de l'individu : ");
					         Get(Cle);
				              exit when Est_Cle_Presente_1(Arbre,Cle);
				              end loop;
					      Skip_Line;
		                              New_Line;
		                              Put("L'annee de naissance de l'individu est : "&Integer'Image(Obtenir_Donnee(Le_Registre,Cle).Annee_De_Naissance));
		                              New_Line;


					elsif Choix_5 = 4 then

				              loop
				                  Put("Veuillez saisir la clé de l'individu : ");
					          Get(Cle);
				              exit when Est_Cle_Presente_1(Arbre,Cle);
				              end loop;
					      Skip_Line;
		                              New_Line;
		                              Put("Le pays de résidence de l'individu est : ");
		                              Put(To_String(Obtenir_Donnee(Le_Registre,Cle).Pays));
		                              New_Line;


					end if;

			         end loop;
				 Choix_5 := 100;

		                 
			   end if;

		    end loop;
		    Choix_3 := 100;



	
	     elsif Choix_1 = 2 then

		   while Choix_2 /= 11 loop

		       New_Line;
		       New_Line;
		       Put_Line("Veuillez choisir une fonctionnalité parmis les suivantes en saisissant un entier");
	               New_Line;
	               New_Line;
                       Put_Line("    1 - Créer un arbre minimale contenant seulement le noeud racine");
	               Put_Line("    2 - Ajouter un parent ( père ou mère ) à un noeud donné");
	               Put_Line("    3 - Obtenir le nombre d'ancêtres connus d'un individu ( lui compris )");
	               Put_Line("    4 - Obtenir l'ensemble des ancêtres situés à une génération donné d'un individu");
	               Put_Line("    5 - Obtenir l'ensemble des individus ayant un seul parent connu");
	               Put_Line("    6 - Obtenir l'ensemble des individus ayant les deux parents connus");
	               Put_Line("    7 - Obtenir l'ensemlbe des individus ayant les deux parents indonnus");
		       Put_Line("    8 - Identifier l'ensemble des ancêtres d'un individu sur n Générations");
		       Put_Line("    9 - Supprimer les ancêtres d'un individu ");
	               Put_Line("   10 - Afficher l'arbre généalogique");
	               Put_Line("   11 - Revenir au Menu");
	               New_Line;
	               New_Line;
	               Put("Votre choix est : ");
	               Get(Choix_2);
	               New_Line;

		       if Choix_2 = 1 then
			       Put("Veillez Choisir l'identifiant entier de votre racine : ");
	                       Get(Cle);
	                       Creer_Arbre_Minimale(Arbre,Cle);
			       Inserer(Le_Registre,Cle,Donnee);
	                       New_Line;

		       elsif Choix_2 = 2 then
                               loop
			           Put("Veuillez Choisir l'identifiant du noeud : ");
	                           Get(Cle);
			       exit when Est_Cle_Presente_1(Arbre,Cle);
		               end loop;
	                       New_Line;
	                       Put("Veuillez Choisir l'identifiant du parent : ");
	                       Get(Cle_Parent);
	                       New_Line;
	                       Put("Veuillez Choisir le type du parent ( P/M ) : ");
	                       Get(Type_Parent);
	                       Ajouter_Parent(Arbre,Cle,Cle_Parent,Type_Parent);
			       Inserer(Le_Registre,Cle_Parent,Donnee);
	                       New_Line;

			elsif Choix_2 = 3 then

                               loop
			            Put("Veuillez Choisir l'identifiant de l'individu : ");
	                            Get(Cle);
			       exit when Est_Cle_Presente_1(Arbre,Cle);
		               end loop;
	                       New_Line;
	                       p := Nombre_Ancetres(Arbre,Cle);
	                       Put("Le nombre d'ancêtres connus de cet individu est : "&Integer'Image(p));
	                       New_Line;

			elsif Choix_2 = 4 then

                                loop
			             Put("Veuillez Choisir l'identifiant de l'individu : ");
	                             Get(Cle);
				exit when Est_Cle_Presente_1(Arbre,Cle);
			        end loop;
	                        New_Line;
	                        Put("Veuillez Choisir le nombre de générations : ");
	                        Get(Nombre_Generations);
	                        New_Line;
				Put("L'ensembre des ancêtres situés à "&Integer'Image(Nombre_Generations));
				Put(" générations de l'individu est : ");
				Put("[");
	                        Ensemble_Ancetres(Arbre,Cle,Nombre_Generations);
				Put(" ]");
	                        New_Line;


	                 elsif Choix_2 = 5 then

   
			        Put_Line("L'ensemble des individus ayant un seul parent connu est : ");
	                        Put("[");
	                        Ensemble_Un_Parent_Connu(Arbre);
	                        Put(" ]");
	                        New_Line;

		         elsif Choix_2 = 6 then


			        Put_Line("L'ensemble des individus ayant les deux parents connus est : ");
	                        Put("[");
	                        Ensemble_Deux_Parents_Connus(Arbre);
	                        Put(" ]");
	                        New_Line;

		         elsif Choix_2 = 7 then

			        Put_Line("L'ensemble des individus ayant les deux parents inconnus est : ");
	                        Put("[");
	                        Ensemble_Deux_Parents_Inconnus(Arbre);
	                        Put(" ]");
	                        New_Line;

		         elsif Choix_2 = 8 then
                                loop
			            Put_Line("Veuillez choisir l'identifiant de l'individu : ");
				    Get(Cle);
				exit when Est_Cle_Presente_1(Arbre,Cle);
			        end loop;
				New_Line;
				Put("Veuillez choisir le nombre de générations : ");
				Get(Nombre_Generations);
				New_Line;
				Put("L'ensmeble des ancêtres sur "&Integer'Image(Nombre_Generations));
				Put(" de l'individu est : ");
				Put("[");
				Identifier_Ancetres(Arbre,Cle,Nombre_Generations);
				Put(" ]");
				New_Line;

		         elsif Choix_2 = 9 then

                                 loop
			             Put("Veuillez choisir la clé de l'individu : ");
				     Get(Cle);
				 exit when Est_Cle_Presente_1(Arbre,Cle);
				 end loop;
				 New_Line;
				 Supprimer_Ancetres_1(Arbre,Cle);
				 Put("La suppression est faite avec succés");
				 New_Line;




		         elsif Choix_2 = 10 then

			        Afficher(Arbre);

		         end if;
			 

	           end loop;
		   Choix_2 := 100;

	     end if;

       end loop;

       Vider_Registre(Le_Registre); --Libérer les ressources utilisés par le registre .
       Vider_Arbre(Arbre);  --Libérer les ressources utilisés par l'arbre . 


end main;










