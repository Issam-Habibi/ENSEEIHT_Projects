package allumettes;

import java.util.Scanner;

/** classe définissant une stratégie humaine qui
 * fait jouer la personne derrière la machine en lui
 * demandant les nombre d'allumettes à tirer.
 * @author ihabibi
 *
 */
public class StrategieHumaine implements Strategie {

	private Scanner sc;

	public StrategieHumaine() {
		this.sc = new Scanner(System.in);
	}

	@Override
	public int prise(Jeu jeu) {
		assert (jeu != null);
		boolean bool = false;
		int choixEntier = 0;
		while (bool == false) {
			try {
				System.out.print("Combien prenez-vous d'allumettes ? ");
				choixEntier = Integer.parseInt(this.sc.nextLine());
				bool = true;
			} catch (NumberFormatException e) {
				System.out.println("Vous devez donner un entier.");
			}
		}
		return choixEntier;
	}


}

