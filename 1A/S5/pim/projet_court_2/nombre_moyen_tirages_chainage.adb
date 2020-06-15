with Ensembles_Chainage;
with Alea;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;

procedure Nombre_Moyen_Tirages_Chainage is

    Min: Constant Integer :=20;
    Max: Constant Integer :=300;  -- ici par exemple les valeurs sont entre 20 et 300 .

    package Ensemble_Entiers is 
	new Ensembles_Chainage( T_Element => Integer); 
    use Ensemble_Entiers;
  
    package Mon_Alea is                --Le paquetage Mon_alea pour générer des nombres aléatoires.
	new ALea(Min,Max);
    use Mon_Alea;

    Ens : T_Ensemble;
    s : Float ;
    m : Float :=0.0;
    p : Float;
    moyenne : Integer ;
    nbre_hasard : Integer;


begin

    for i in 1..100 loop
	Initialiser(Ens);
	s := 0.0;      
        while Taille_Ensemble(Ens) /= Max - Min + 1 loop
	   Get_Random_Number(nbre_hasard);
	   s := s + 1.0;
	   if not Est_Present(Ens,nbre_hasard) then
	       Ajouter_Element(Ens,nbre_hasard);
	   end if;
	   p := s ;
        end loop;
        m := m + p;
    end loop;
    Detruire(Ens);
    moyenne := Integer(m*0.01);          -- calcule du nombre moyen de tirage . Je prend la partie entière pour que ça soit un entier . 
    Put("Le nombre moyen de tirages dans l'intervalle ["&Integer'Image(Min));
    Put(" .."&Integer'Image(Max));
    Put(" ] est");
    Put(" : "&Integer'Image(moyenne));



end Nombre_Moyen_Tirages_Chainage;

