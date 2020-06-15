package allumettes;

/** classe définissant une stratégie rapide du jeu
 * qui essaye de finir le jeu le plus rapide possible.
 * @author ihabibi
 *
 */
public class StrategieRapide implements Strategie {

	@Override
	public int prise(Jeu jeu) {
		assert (jeu != null);
		int nb;
		if (jeu.getNombreAllumettes() >= Jeu.PRISE_MAX) {
			nb = Jeu.PRISE_MAX;
		} else {
			nb = jeu.getNombreAllumettes();
		}
		return nb;
	}

}
