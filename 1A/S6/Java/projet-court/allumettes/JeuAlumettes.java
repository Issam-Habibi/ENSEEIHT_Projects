package allumettes;

public class JeuAlumettes implements Jeu {

	private int nbreAlumettes;

	/** Constructeur d'un jeu d'alumettes
	 * le nombre d'alumettes n'est pas fixé ici mais
	 * on utilisera toujours 13 alumettes .
	 * @param nbreAlumettes le nombre d'alumettes.
	 */
	public JeuAlumettes(int nbreAlumettes) {
		this.nbreAlumettes = nbreAlumettes;
	}

    /** Récupérer le nombre des alumettes restantes.
     */
	@Override
	public int getNombreAllumettes() {
		return this.nbreAlumettes;
	}

	/** Mettre à jour le nombre d'alumettes
	 *
	 * @param nb le nombre d'alumettes
	 */
	public void setNombreAlumettes(int nb) {
		this.nbreAlumettes = nb;
	}

	/** Retirer un nombre précis d'alumettes
	 * @param nbPrises le nombre d'alumettes à retirer
	 */
	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		if (nbPrises <= 0) {
			throw new CoupInvalideException(nbPrises, "< 1");
		} else if (nbPrises > PRISE_MAX) {
			if (PRISE_MAX < this.nbreAlumettes) {
				throw new CoupInvalideException(nbPrises,
						"> " + PRISE_MAX);
			} else {
				throw new CoupInvalideException(nbPrises,
						"> " + this.nbreAlumettes);
			}
		} else if (nbPrises > this.nbreAlumettes)  {
			throw new CoupInvalideException(nbPrises,
					"> " + this.nbreAlumettes);
		} else {
			this.nbreAlumettes = this.nbreAlumettes - nbPrises;
		}
	}

}
