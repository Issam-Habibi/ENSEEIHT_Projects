import java.awt.Color;

/**Un cercle représente une courbe plane fermée constitué des points d'égale
 * distance (rayon) d'un point qui est son centre .
 * @author  HABIBI ISSAM <Issam.Habibi@enseeiht.fr>
 */

public class Cercle implements Mesurable2D {

    /**Constante PI = 3.14 . */
	public static final double PI = Math.PI;
	/**Le centre du cercle . */
	private Point centre;
	/**Le rayon du cercle . */
	private double rayon;
	/**La couleur du cercle . */
	private Color couleur;

	/**Construire un cercle à partie d'un point représentant
	 * son centre et à partir de son rayon.
	 * @param centre Le centre du cercle
	 * @param rayon Le rayon du cercle
	 */
	public Cercle(Point centre, double rayon) {
		assert (centre != null && rayon > 0);
		Point pointCentre = new Point(centre.getX(), centre.getY());
		this.centre = pointCentre;
		this.rayon = rayon;
		this.couleur = Color.blue;
	}

	/**Obtenir le centre du cercle.
	 * @return Le centre du cercle
	 */
	public Point getCentre() {
		Point point = new Point(this.centre.getX(), this.centre.getY());
		return point;
	}

	/**Obtenir le rayon du cercle.
	 * @return Le rayon du cercle
	 */
	public double getRayon() {
		return this.rayon;
	}

	/**Obtenir le diametre du cercle.
	 * @return Le diametre du cercle
	 */
	public double getDiametre() {
		return 2 * this.rayon;
	}

	/**Obtenir la couleur du cercle.
	 * @return La couleur du cercle
	 */
	public Color getCouleur() {
		return this.couleur;
	}

	/**Changer le centre du cercle.
	 * @param nouveauCentre le nouveau centre
	 */
	public void setCentre(Point nouveauCentre) {
		assert (nouveauCentre != null);
		this.centre = nouveauCentre;
	}

	/**Changer le rayon du cercle.
	 * @param nouveauRayon le nouveau rayon
	 */
	public void setRayon(double nouveauRayon) {
		assert (nouveauRayon > 0);
		this.rayon = nouveauRayon;
	}

	/**Changer la couleur du cercle.
	 * @param nouvelleCouleur la nouvelle couleur
	 */
	public void setCouleur(Color nouvelleCouleur) {
		assert (nouvelleCouleur != null);
		this.couleur = nouvelleCouleur;
	}

	/**Translater le point.
	 * @param dx déplacement suivant l'axe des X
	 * @param dy déplacement suivant l'axe des Y
	 */
	public void translater(double dx, double dy) {
		this.centre.translater(dx, dy);
	}

	/**Savoir si un point est à l'intérieur du cercle.
	 * @param point le point
	 * @return boolean qui indique si le point est à l'intérieur du cercle
	 */
	public boolean contient(Point point) {
		assert (point != null);
		double distance = this.centre.distance(point);
		double rayonCercle = this.getRayon();
		return (distance <= rayonCercle);
	}

	/**Construire un cercle à partie de deux points diamétralement opposés.
	 * @param point1 Le premier point
	 * @param point2 Le deuxième point
	 */
	public Cercle(Point point1, Point point2) {
		assert (point1 != null && point2 != null);
		assert (point1.distance(point2) > 0);
		double rayonNouveau = (point1.distance(point2)) / 2;
		Point futureCentre = new Point((point1.getX() + point2.getX()) / 2,
				(point1.getY() + point2.getY()) / 2);
		this.centre = futureCentre;
		this.rayon = rayonNouveau;
		this.couleur = Color.blue;
	}

	/**Construire un cercle à partie de deux points diamétralement opposés
	 * et sa couleur.
	 * @param point1 Le premier point
	 * @param point2 Le deuxième point
	 * @param couleur La couleur
	 */
	public Cercle(Point point1, Point point2, Color couleur) {
		assert (point1 != null && point2 != null && couleur != null);
		assert (point1.distance(point2) > 0);
		double rayonNouveau = (point1.distance(point2)) / 2;
		Point futureCentre = new Point((point1.getX() + point2.getX()) / 2,
				(point1.getY() + point2.getY()) / 2);
		this.centre = futureCentre;
		this.rayon = rayonNouveau;
		this.couleur = couleur;
	}

	/**Construire un cercle à partie de deux points diamétralement opposés
	 * et sa couleur.
	 * @param point1 Le premier point qui est le centre
	 * @param point2 Le deuxième point
	 * @return Cercle le cercle construit
	 */
	public static Cercle creerCercle(Point point1, Point point2) {
		assert (point1 != null && point2 != null);
		assert (point1.distance(point2) > 0);
		double rayonNouveau = (point1.distance(point2));
		Cercle cercle = new Cercle(point1, rayonNouveau);
		return cercle;
	}

	/**Afficher le cercle.
	 * @return String[] , une chaine de charactère décrivant
	 * le cercle de cette façon : "Crayon@(x, y)"
	 */
	public String toString() {
		String affichage = "C" + this.rayon + "@" + this.centre.toString();
		return affichage;
	}

	/**Changer le diamère du cercle.
	 * @param diametre le diamètre
	 */
	public void setDiametre(double diametre) {
		assert (diametre > 0);
		this.rayon = diametre / 2;
	}

	/**Obtenir le perimètre d'un cercle.
	 * @return le perimètre du cercle
	 */
	public double perimetre() {
		return 2 * PI * this.rayon;
	}

	/**Obtenir l'air d'un cercle.
	 * @return l'aire du cercle
	 */
	public double aire() {
		return PI * Math.pow(this.rayon, 2);
	}


}























































