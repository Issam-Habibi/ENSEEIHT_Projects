package allumettes;

/** La classe de proxy permettant de contrôler
 * la triche potentielle des joueurs
 *
 * @author ihabibi
 *
 */
public class Procuration extends JeuAlumettes  {


	/** Le constructeur du proxy
	 *
	 * @param nbreAlumettes le nombre des alumettes
	 */
	public Procuration(int nbreAlumettes) {
		super(nbreAlumettes);
	}

    @Override
	public void retirer(int nbPrises) throws OperationInterditeException {
			throw new OperationInterditeException();
	}



}
