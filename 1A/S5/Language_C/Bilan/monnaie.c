//NOM ET PRENOM : HABIBI ISSAM
//GROUPE : D

#include <stdlib.h> 
#include <stdio.h>
#include <assert.h>
#include <stdbool.h>
#define Taille 5            //5 est une constante pré-processeur.


// Definition du type monnaie

struct T_Monnaie {     //T_Monnaie est un enregistrement d'un valeur et une devise . 
    float Valeur;
    char Devise;
};
typedef struct T_Monnaie T_Monnaie;    //La création d'un alias de notre type pour faciliter sa manipulation .  




/**
 * \brief Initialiser une monnaie 
 * \param[out] Monnaie  un pointeur sur le type T_Monnaie
 * \param[in] Valeur la valeur de la monnaie,
 * \param[in] Devise la devise de la monnaie,
 * \pre Valeur > 0
 * \post Monnaie.Valeur == Valeur , Monnaie.Devise == Devise
 */ 

void initialiser(T_Monnaie* Monnaie,float Valeur,char Devise) {
    assert(Valeur > 0);
    Monnaie->Valeur = Valeur;
    Monnaie->Devise = Devise;
}




/**
 * \brief Ajouter une monnaie m2 à une monnaie m1 
 * \param[in] Monnaie_1 le premier paramètre Monnaie_1 est de type T_Monnaie ( Mode IN ) car la valeur de Monnaie_1 restera inchangée.
 *            
 * \param[in out] Monnaie_2 le deuxième paramètre Monnaie_2 est un pointeur sur type T_Monnaie ( Mode IN OUT ) car la valeur de Monnaie_2 va être changée 
 */ 


bool ajouter(T_Monnaie Monnaie_1,T_Monnaie* Monnaie_2) {
    bool T = false;
    if (Monnaie_1.Devise == Monnaie_2->Devise) {
	T = true;
	Monnaie_2->Valeur = Monnaie_1.Valeur + Monnaie_2->Valeur;
    } else {
	T = false;
	printf("Erreur, La devise des deux monnaies à sommer dans votre teste n'est pas identique\n\n");
    }
    return T;

}




/**
 * \brief Tester Initialiser 
 * \param[out] : Monnaie_1 un monnaie de type T_Monnaie qu'on initialisera .
 * \param[out] : Monnaie_2 une monnaie de type T_Monnaie qu'on initialisera .
 * \param[in] : a1,a2,c1,c2 désignant les valeurs et le devises des deux monnaies.
 */ 

void tester_initialiser() {
    
    T_Monnaie Monnaie_1,Monnaie_2;
    initialiser(&Monnaie_1,5.0,'$');
    initialiser(&Monnaie_2,6.0,'$');
    const float a1 = Monnaie_1.Valeur;
    const float a2 = Monnaie_2.Valeur;
    const char c1 = Monnaie_1.Devise;
    const char c2 = Monnaie_2.Devise;
    assert(a1 == 5.0 && a2 == 6.0);
    assert(c1 == '$' && c2 == '$');
   
   //Ce teste est correcte , il passera avec succès .
 
}


/**
 * \brief Tester Ajouter 
 * \param[out] : Monnaie_1 une monnaie à initialiser avec une somme et une devise
 * \param[out] : Monnaie_2 une monnaie à initialiser avec une somme et une devise
 * \param[in] : a1,a2,c1,c2 désignant les valeurs et les devises des deux monnaies.
 */ 

void tester_ajouter() {   

    T_Monnaie Monnaie_1,Monnaie_2;
    initialiser(&Monnaie_1,5.0,'$');
    initialiser(&Monnaie_2,6.0,'$');
    ajouter(Monnaie_1,&Monnaie_2);
    const float a1 = Monnaie_1.Valeur;
    const float a2 = Monnaie_2.Valeur;
    const char c1 = Monnaie_1.Devise;
    const char c2 = Monnaie_2.Devise;
    assert(a1 == 5.0 && a2 == 11.0);
    assert(c1 == '$' && c2 == '$');

    //Ce teste est Correcte . il passera avec succès.
    

}



int main(void) {

    tester_initialiser();
    tester_ajouter();   

    //Le programme principal .

    printf("\n\n************* Phase du programme Principal *****************\n\n");

    //Declarer un tableau de 5 monnaies .
    T_Monnaie porte_monnaie[Taille];


    //Initialiser les monnaies

    float Valeur;
    char Devise;
    int i=0;
    for (i = 0 ; i < Taille ; i++){

	printf("Entrer la valeur numéro %i : ",i+1); //Demander à l'utilisateur d'entrer la ième valeur.
	scanf("%f",&Valeur); //Lire la valeur
	printf("Entrer la devise numéro %i : ",i+1);  //Demander à l'utilisateur d'entrer la ième devise.
	scanf(" %c",&Devise);	//Lire la devise
	initialiser(&porte_monnaie[i],Valeur,Devise);
    }


    // Afficher la somme de toutes les monnaies qui sont dans une devise entrée par l'utilisateur.

    char Devise_Somme; //une variable dans la quelle on stockera la devise que l'utilisateur choisit pour sommer .

    printf("Entrer la devise à sommer : ");
    scanf(" %c",&Devise_Somme);
    T_Monnaie Monnaie_Copie,Monnaie_Somme; //Une monnaie dans la quelle on stock la valeur saisie par l'utilisateur , et une monnaie dans la quelle on somme les valeurs.
    for (i=0 ; i < Taille ; i++) {
	if (porte_monnaie[i].Devise == Devise_Somme){       //On parcours le tableau jusqu'à trouver une monnaie de la devise précisée.
	    initialiser(&Monnaie_Copie,porte_monnaie[i].Valeur,Devise_Somme);  //on initialise la Monnaie_Copie par la valeur de la monnaie contenant la devise précisée.
	    Monnaie_Somme.Devise = Devise_Somme;       //On Initialiser la devise de la Monnaie_Somme par la devise précisé pour ne pas avoir des erreurs d'ajout.
	    ajouter(Monnaie_Copie,&Monnaie_Somme);   //On effectue l'ajout.
	}
    }
    printf("La somme est : %1.2f %c \n",Monnaie_Somme.Valeur,Devise);

    printf("\n\n******************** Fin du programme Principal ****************\n\n");


    return EXIT_SUCCESS;
}

