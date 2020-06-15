package allumettes;

/** classe définissant une stratégie de triche
 * qui consiste à tirer toutes les allumettes
 * sauf une pour garantir la victoire.
 * @author ihabibi
 *
 */
public class StrategieTricheur implements Strategie {

	@Override
	public int prise(Jeu jeu) {
		int nb = jeu.getNombreAllumettes() - 1;
		for (int i = 1; i < nb; i++) {
			try {
			jeu.retirer(1);
			} catch (CoupInvalideException e) {
				System.out.println("Erreur ! " + e.getMessage());
				System.out.println("Recommencez ! ");
			}
		}
		return 1;

	}

}
