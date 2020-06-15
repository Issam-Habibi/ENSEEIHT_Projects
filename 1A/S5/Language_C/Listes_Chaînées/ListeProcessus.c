#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdbool.h>
#include "ListeProcessus.h"


ListeProcessus *creer_noeud(infoProcessus informations) {
    ListeProcessus* nouveau;
    nouveau = (ListeProcessus*)malloc(sizeof(ListeProcessus));
    nouveau->infos = informations;
    nouveau->suivant = NULL;
    return nouveau;
}

ListeProcessus* ajouter(ListeProcessus *liste, infoProcessus informations) {
    ListeProcessus* tmp = creer_noeud(informations);
    if (liste == NULL) {
	return tmp;
    } else {
	ListeProcessus* newList = liste;
	while (newList->suivant != NULL) {
	    newList = newList->suivant;
	}
	newList->suivant = tmp;
	return liste;
    }
}

void supprimer(ListeProcessus *liste, pid_t pid){
    if (liste != NULL) {
	if ( (liste->infos).processus_pid == pid ){
	    liste = liste->suivant;
	} else {
	    ListeProcessus* tmp = liste;
	    while (tmp->suivant != NULL){
		if (((tmp->suivant)->infos).processus_pid == pid) {
		    break;
		} else {
		    tmp = tmp->suivant;
	        }
	    }
	    if (tmp->suivant != NULL) {
		tmp->suivant = (tmp->suivant)->suivant;
	    }
      }
	}
}

bool estPresent(ListeProcessus *liste, int id) {
	ListeProcessus *tmp = liste;
	while (tmp != NULL) {
		if ( (tmp->infos).processus_id == id ) {
			break;
		} else {
			tmp = tmp->suivant;
		}
	}
	if (tmp == NULL) {
		return false;
	} else {
		return true;
	}
}


pid_t getPid(ListeProcessus *liste, int id) {
	ListeProcessus *tmp = liste;
	while (tmp != NULL) {
		if ( (tmp->infos).processus_id == id ) {
			break;
		} else {
			tmp = tmp->suivant;
		}
	}
	return (tmp->infos).processus_pid;
}

int getId(ListeProcessus *liste, pid_t pid) {
	ListeProcessus *tmp = liste;
	while (tmp != NULL) {
		if ( (tmp->infos).processus_pid == pid ) {
			break;
		} else {
			tmp = tmp->suivant;
		}
	}
	return (tmp->infos).processus_id;
}


void changer_etat(ListeProcessus *liste, int id, int nouveau_etat) {
	ListeProcessus *tmp = liste;

	while (tmp != NULL) {
		if ( (tmp->infos).processus_id == id ) {
			break;
		} else {
			tmp = tmp->suivant;
		}
	}
	if (tmp != NULL) {
		(tmp->infos).etat = nouveau_etat;
	}
}


void afficherListe(ListeProcessus *liste) {
    if (liste == NULL){
        printf("La liste est vide \n");
    } else {
	printf("id       pid         etat       commande \n");
	ListeProcessus* tmp = liste;
	printf("%d        %d        %d          %s \n",(tmp->infos).processus_id,(tmp->infos).processus_pid,(tmp->infos).etat,(tmp->infos).commande);
	while (tmp->suivant != NULL) {
	         ListeProcessus* tmp2 = tmp->suivant;
	         printf("%d        %d        %d          %s \n",(tmp2->infos).processus_id,(tmp2->infos).processus_pid,(tmp2->infos).etat,(tmp2->infos).commande);
	         tmp = tmp->suivant;
       }
	  

    }
}







