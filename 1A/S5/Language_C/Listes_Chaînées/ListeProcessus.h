#ifndef LISTEPROCESSUS__H
#define LISTEPROCESSUS_H

 
#include <stdio.h>    /* entrées sorties */
#include <unistd.h>   /* primivites de base */
#include <stdlib.h>   /* exit */
#include <signal.h>   /* traitement des signaux */
#include <stdbool.h>


	
/* L'enregistrement des informations concernant un processeur */
typedef struct infoProcessus infoProcessus;
struct infoProcessus {
    pid_t processus_pid; /* Le pid du processeur */
    int processus_id; /* L'identifiant du processeur dans le minishell */
    int etat; /* L'état du processuer */
    char commande[256]; /* La ligne de commande lancée */
};

/* La liste chaînée des processus , qui se compose des informations de chaque 
processus et d'un pointeur sur un processus suivant */
typedef struct ListeProcessus ListeProcessus;
struct ListeProcessus {
    infoProcessus infos;
    ListeProcessus *suivant;
};



/* Les méthodes pour manipuler les listes des processeurs */
ListeProcessus* creer_noeud(infoProcessus informations);
ListeProcessus* ajouter(ListeProcessus *liste, infoProcessus informations);
void supprimer(ListeProcessus *liste, pid_t processus_pid);
bool estPresent(ListeProcessus *liste, int id);
pid_t getPid(ListeProcessus *liste, int id);
int getId(ListeProcessus *liste, pid_t pid); 
void changer_etat(ListeProcessus *liste, int id, int nouveau_etat);
void afficherListe(ListeProcessus *liste);



#endif

