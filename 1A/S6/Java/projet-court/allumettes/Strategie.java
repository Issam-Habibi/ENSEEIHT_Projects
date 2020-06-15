package allumettes;

/** Interface définissant la stratégie de jeu adoptée
 * par le joueur.
 * @author ihabibi
 *
 */
public interface Strategie {

	/** obtenir le nombre d'alumettes à tirer
	 * avec la stratégie suivie
	 * @param jeu le jeu joué
	 * @return le nombre d'alumettes à tirer
	 */
	int prise(Jeu jeu);

}
