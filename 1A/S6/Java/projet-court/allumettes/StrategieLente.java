package allumettes;

/** classe définissant une stratégie rapide du jeu
 * qui essaye de finir le jeu le plus rapide possible.
 * @author ihabibi
 *
 */
public class StrategieLente implements Strategie {

	@Override
	public int prise(Jeu jeu) {
		return 1;
	}

}

