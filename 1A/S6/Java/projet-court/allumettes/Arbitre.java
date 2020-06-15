package allumettes;

/** classe définissant un arbitre qui organise le jeu
* et fait respecter les règles du jeu aux joueurs.
* @author ihabibi
*
*/
public class Arbitre {

	private Joueur j1; //Le premier joueur
	private Joueur j2; //Le deuième joueur
	private Etat etatArbitre; //Confiant ou méfiant

	/** Construire un arbitre
	 *
	 * @param j1 le premier joueur
	 * @param j2 le deuxième joueur
	 */
	public Arbitre(Joueur j1, Joueur j2) {
		this.j1 = j1;
		this.j2 = j2;
	}

	/**
	 * Mettre à jour l'état de l'arbitre
	 * @param etat l'état de l'arbitre
	 */
	public void setEtat(Etat etat) {
		this.etatArbitre = etat;
	}

	/** Savoir si le jeu est fini ou pas
	 * @param jeu le jeu
	 * @param n le tour actuel
	 * @return un boolean = true si le jeu est fini
	 */
	public boolean estJeuFinie(Jeu jeu, int n) {
		boolean bool;
		//Si il ne reste aucune allumette à tirer
		//C'est le temps de déclarer un gagnant
		if (jeu.getNombreAllumettes() == 0) {
			//Cette déclaration se fait selon le tour
			//dans lequel le jeu est fini.
			if (!(n % 2 == 1)) {
				System.out.println(this.j1.getNom() + " a perdu ! ");
				System.out.println(this.j2.getNom() + " a gagné ! ");
				bool = true;
			} else {
				System.out.println(this.j2.getNom() + " a perdu ! ");
				System.out.println(this.j1.getNom() + " a gagné ! ");
				bool = true;
			}
		} else {
			bool = false;
		}
		return bool;
	}

    /** Un méthode qui aide l'arbitrage
     * @param jeu le jeu
     * @param proxy le jeu-proxy
     * @param joueur le joueur
     */
	public void sousArbitrer(Jeu jeu, Joueur joueur) {
		assert (jeu != null && joueur != null);
		int prise;
		try {
			//L'arbitre est méfiant
			if (this.etatArbitre == Etat.MEFIANT) {
				//On prend en considération l'utilisation de
				//la méthode retirer dans les stratégies
				int nbAlumettes = jeu.getNombreAllumettes();
				prise = joueur.getPrise(new Procuration(nbAlumettes));
			//L'arbitre est confiant
			} else {
				prise = joueur.getPrise(jeu);
			}
			//il y a un 's' à ajouter à allumette si n >=2
			if (prise >= 2) {
				System.out.println(joueur.getNom()
						+ " prend " + prise + " allumettes.");
				jeu.retirer(prise);
			} else {
				System.out.println(joueur.getNom()
						+ " prend " + prise + " allumette.");
				jeu.retirer(prise);
			}
		} catch (CoupInvalideException e) {
			System.out.println("Erreur ! " + e.getMessage());
			System.out.println("Recommencez !");
			arbitrer(jeu);
			System.exit(0);
		} catch (OperationInterditeException e) {
			System.out.println("Partie abandonnée car "
		                  + joueur.getNom() + " a triché !");
			System.exit(0);
		}
	}

	/** arbitrer le jeu, faire respecter les règles
	 *  par les joueurs et décider le gagnant du
	 *  perdant.
	 *  @param jeu le jeu
	 *  @param proxy le jeu-proxy
	 */
	public void arbitrer(Jeu jeu) {
		assert (jeu != null);
		int tour = 1; //Initialisation du premier tour.
		while (!estJeuFinie(jeu, tour)) {
			System.out.println("\nNombre d'allumettes restantes : "
		                + jeu.getNombreAllumettes());
			if (!(tour % 2 == 0)) {
				System.out.println("Au tour de "
			             + this.j1.getNom() + ".");
				sousArbitrer(jeu, this.j1);
			} else {
				System.out.println("Au tour de "
			             + this.j2.getNom() + ".");
				sousArbitrer(jeu, this.j2);
			}
			//On passe au tour suivant
			tour++;
		}
	}

}
