package allumettes;

import java.util.Random;

/** classe définissant une stratégie expert
 * dans la quelle les allumettes sont tirées
 * d'un manière optimisée et la mieux possible
 * @author ihabibi
 *
 */
public class StrategieExpert implements Strategie {


	@Override
	public int prise(Jeu jeu)  {
		assert (jeu != null);
		Random random = new Random();
		int nb = jeu.getNombreAllumettes();
		int choix;
		if ((nb - 1) % (Jeu.PRISE_MAX + 1) == 0) {
			choix = random.nextInt(Math.min(jeu.PRISE_MAX, nb)) + 1;
		} else {
			choix = (nb - 1) % (jeu.PRISE_MAX + 1);
		}
		return choix;
	}


}

