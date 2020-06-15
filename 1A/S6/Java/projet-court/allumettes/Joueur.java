package allumettes;

/** classe définissant un joueur qui joue
 * au jeu, il peut choisir son nom, sa stratégie
 * et tire un nombre contrôlé d'allumettes .
 * @author ihabibi
 *
 */
public class Joueur {

	private String nom;
	private Strategie strategie;

	/** définir un joueur à partir de son nom
	 * et sa stratégie
	 * @param nom le nom du joueur
	 * @param strategie la stratégie du joueur
	 */
	public Joueur(String nom, Strategie strategie) {
		this.nom = nom;
		this.strategie = strategie;
	}

	/** Récupérer le nom d'un joueur
	 *
	 * @return le nom du joueur
	 */
	public String getNom() {
		return this.nom;
	}

	/** Récupérer la stratégie d'un joueur
	 *
	 * @return la stratégie
	 */
	public Strategie getStrategie() {
		return this.strategie;
	}


    /** Récupérer la prise du joueur
     *
     * @param jeu le jeu joué
     * @return la prise du joueur
     * @throws CoupInvalideException tentative de prendre un nombre invalide d'alumettes
     */
 	public int getPrise(Jeu jeu) throws CoupInvalideException {
		int nb = 0;
		if (jeu != null && this.strategie != null) {
			 nb = this.strategie.prise(jeu);
		}
		return nb;
	}

}
