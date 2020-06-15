package allumettes;

import java.util.Random;

/** classe définissant une stratégie naive
 * qui tire aléatoirement les allumettes.s
 * @author ihabibi
 *
 */
public class StrategieNaive implements Strategie {


	@Override
	public int prise(Jeu jeu)  {
		assert (jeu != null);
		Random nbreAlea = new Random();
	    if (jeu.getNombreAllumettes() >= Jeu.PRISE_MAX) {
	    	return  1 + nbreAlea.nextInt(Jeu.PRISE_MAX);
	    } else if (jeu.getNombreAllumettes() == 2) {
	    	return  1 + nbreAlea.nextInt(2);
	    } else {
	    	return 1;
	    }
	}

}
