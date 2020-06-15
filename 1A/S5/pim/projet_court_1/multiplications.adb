--------------------------------------------------------------------------------
--  Auteur   : HABIBI ISSAM
--  Objectif : Permettre à l'utilisateur de réviser des tables de multiplication entre 1 et 10 lus au clavier .  
--------------------------------------------------------------------------------

with Ada.Text_IO;           use Ada.Text_IO;
with Ada.Integer_Text_IO;   use Ada.Integer_Text_IO;
With Alea;
with Ada.Calendar;          use Ada.Calendar; 

procedure Multiplications is

    package Mon_Alea is
	new Alea(1,10);  --Le nombre au hasard doit être compris entre 1 et 10 
    use Mon_Alea;


    x: Integer;             --La table que l'utilisateur veut réviser 
    nbre_reponses_justes: Integer:=0;
    nbre_reponses_fausses: Integer:=0;
    nbre_hasard: Integer;    --le nombre au hasard généré entre 1 et 10
    valeur_saisie: Integer;
    y: Character:='o';       --un caractère caractérisant le choix de continuer ou pas , initialisé par o ( oui )
    Debut: Time;
    Fin: Time;
    temps_de_saisie: Duration;
    s: Duration:=0.0;
    duree_moy: Duration:=0.0;
    p: Duration;
    d: Integer;
    

begin
    while y='o' loop         --On commence le programme par une boucle while pour que le message ' On continue ? ' puisse s'afficher à la fin de chaque révision .
	loop                 
	    Put("Table à Réviser : ");
	    Get(x);
	exit when x>=1 or x>=10;         --On répète le demande jusqu'à la valeur de la table soit comprises entre 1 et 10 
        end loop;
	New_Line;
	

	for k in 1..10 loop             --On pose à l'utilisateur 10 questions de multiplication dont le nombre à gauche est choisi et le nombre à droite est généré au hasard entre 1 et 10 

	        Get_Random_Number (nbre_hasard);  -- On génère un nombre au hasard entre 1 et 10 
		Debut:=Clock;    --On souhaite calculer le temps de saisie de chaque réponse , initialisé ici 
	        Put("(M");
		Put(k,1);
	        Put(")");
	        Put(""&Integer'Image(x));
	        Put(" *"&Integer'Image(nbre_hasard));
	        Put(" ? ");
	        Get(valeur_saisie);
		Fin:=clock;
		temps_de_saisie:=Fin-Debut;  --le calcule du temps de sasie 
		s:=s+temps_de_saisie;
		duree_moy:=duree_moy+(s*0.1); --le calcule de la durée moyenne de réponse , qui est par définition la somme des temps de saisie divisée par 10
		if temps_de_saisie>duree_moy then
		    p:=temps_de_saisie;          --Dans le cas où l'utilisateur hésite sur une table et dépasse la durée moyenne , on stock les informations nécessaires dans des variables pour commenter après .
		    d:=nbre_hasard;
		end if;
	        if x*nbre_hasard = valeur_saisie then           --L'évaluation de la validité de chaque réponse avec un commentaire correspondant .
		   Put_Line("Bravo !");
		   nbre_reponses_justes:=nbre_reponses_justes +1;             --Le comptage du nombre total des réponses justes .         
		else
		   Put_Line("Mauvaise réponse.");
		   nbre_reponses_fausses:=nbre_reponses_fausses +1;            --Le comptage du nombre total des réponses fausses . 
	        end if; 
	        New_Line;
	duree_moy:=s*0.1;
        end loop;
	case nbre_reponses_justes is                 --Les différents commentaires à afficher selon le nombre de réponses justes de l'utilisateur .
	    when 10=>Put_Line("Aucune erreur, Excellent!");
	    when 9=>Put_Line("Une seule erreur. Très bien");
	    when 0=>Put_Line("Tout est faux!Volontaire ?");
	    when 1..5=>Put("Seulement "&Integer'Image(nbre_reponses_justes));
	               Put(" bonnes reponses , Il faut apprendre la table de "&Integer'Image(x));
            when others=>Put(nbre_reponses_fausses,1);
                         Put(" erreurs. Il faut encore travailler la table de "&Integer'Image(x));
	end case;
	New_Line;
	New_Line;
	Put("Des hésitation sur la table de "&Integer'Image(d));         --Afficher un commentaire sur l'hésitation de l'utilisateur sur une table et l'inviter à la réviser .
	Put(" : "&Duration'Image(p));
	Put(" secondes contre "&Duration'Image(duree_moy));
	Put(" en moyenne . Il faut certainement la réviser ");
	New_Line;
	New_Line;
	Put("On Continue ? (o/n) ");              --Permettre à l'utilisateur de choisir s'il veut continuer la révision ou pas , on voit ici le rôle de la variable y initialisée précedemment . 
	Get(y);
	New_Line;
    end loop;
   
end Multiplications;
