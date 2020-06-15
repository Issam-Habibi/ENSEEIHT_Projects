import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
  * Classe de test de la classe Cercle.
  * @author	HABIBI ISSAM
  */

public class CercleTest {
	

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;
	
	
	/** vérifier l'éxigence E12 qui consiste à construire
	 * un cercle à partir de deux points diamétralement
	 * opposés .
	 */	
	@Test public void testerE12() {
		
		// Construire les points
		Point A = new Point(1, 3);
		Point B = new Point(3, 1);
		Point C = new Point(5, 1);
		
		//Construire les cercles
		Cercle C1 = new Cercle(A,B);
		Cercle C2 = new Cercle(A,C);
		Cercle C3 = new Cercle(B,C);
		
		//Tests sur les abssices des cercles
		assertEquals("E12 sur C1 (Abssice du centre)", 2.0 , C1.getCentre().getX(), EPSILON);
		assertEquals("E12 sur C2 (Abssice du centre)", 3.0 , C2.getCentre().getX(), EPSILON);
		assertEquals("E12 sur C3 (Abssice du centre)", 4.0 , C3.getCentre().getX(), EPSILON);
		
		//Tests sur les ordonnées des cercles		
		assertEquals("E12 sur C1 (Ordonnée du centre)", 2.0 , C1.getCentre().getY(), EPSILON);
		assertEquals("E12 sur C2 (Ordonnée du centre)", 2.0 , C2.getCentre().getY(), EPSILON);
		assertEquals("E12 sur C3 (Ordonnée du centre)", 1.0 , C3.getCentre().getY(), EPSILON);
		
		//Tests sur la couleur des cercles		
		assertEquals("E12 sur C1 (Couleur)", Color.blue , C1.getCouleur());
		assertEquals("E12 sur C2 (Couleur)", Color.blue , C2.getCouleur());
		assertEquals("E12 sur C3 (Couleur)", Color.blue , C3.getCouleur());
		
		//Calcule des rayons des cercles
		double r1 = A.distance(B)*0.5;
		double r2 = A.distance(C)*0.5;
		double r3 = B.distance(C)*0.5;
		
		
		//Tests sur les rayons des cercles
		assertEquals("E12 sur C1 (Rayon)",r1,C1.getRayon(),EPSILON);
		assertEquals("E12 sur C2 (Rayon)",r2,C2.getRayon(),EPSILON);
		assertEquals("E12 sur C3 (Rayon)",r3,C3.getRayon(),EPSILON);
		
	}
	
	
	/** vérifier l'éxigence E13 qui consiste à construire
	 * un cercle à partir de deux points diamétralement
	 * opposés et une couleur.
	 */	
	@Test public void testerE13() {
		
		//Construire les points
		Point A = new Point(1, 3);
		Point B = new Point(3, 1);
		Point C = new Point(5, 1);
		
		//Construire les cercles
		Cercle C1 = new Cercle(A,B,Color.red);
		Cercle C2 = new Cercle(A,C,Color.blue);
		Cercle C3 = new Cercle(B,C,Color.yellow);
		

		//Tests sur les abssices des cercles
		assertEquals("E13 sur C1 (Abssice du centre)", 2.0 , C1.getCentre().getX(), EPSILON);
		assertEquals("E13 sur C2 (Abssice du centre)", 3.0 , C2.getCentre().getX(), EPSILON);
		assertEquals("E13 sur C3 (Abssice du centre)", 4.0 , C3.getCentre().getX(), EPSILON);
		
		//Tests sur les ordonnées des cercles		
		assertEquals("E13 sur C1 (Ordonnée du centre)", 2.0 , C1.getCentre().getY(), EPSILON);
		assertEquals("E13 sur C2 (Ordonnée du centre)", 2.0 , C2.getCentre().getY(), EPSILON);
		assertEquals("E13 sur C3 (Ordonnée du centre)", 1.0 , C3.getCentre().getY(), EPSILON);
		
		//Tests sur la couleur des cercles
		
		assertEquals("E13 sur C1 (Couleur)", Color.red , C1.getCouleur());
		assertEquals("E13 sur C2 (Couleur)", Color.blue , C2.getCouleur());
		assertEquals("E13 sur C3 (Couleur)", Color.yellow , C3.getCouleur());
		
		//Calcule des rayons des cercles
		double r1 = A.distance(B)*0.5;
		double r2 = A.distance(C)*0.5;
		double r3 = B.distance(C)*0.5;
		
		//Tests sur les rayons des cercles
		assertEquals("E13 sur C1 (Rayon)",r1,C1.getRayon(),EPSILON);
		assertEquals("E13 sur C2 (Rayon)",r2,C2.getRayon(),EPSILON);
		assertEquals("E13 sur C3 (Rayon)",r3,C3.getRayon(),EPSILON);
		
		
				
	}
	
	
	/** vérifier l'éxigence E14 qui est une méthode de construction
	 * de cercle à partir de 2 points , l'un représente le centre 
	 * et l'autre représente un point du cercle.
	 */	
	@Test public void testerE14() {
		
		//Création des poits
		Point A = new Point(1, 3);
		Point B = new Point(3, 1);
		Point C = new Point(5, 1);
		
		//Création des cercles par la méthode statique creerCercle 
		Cercle C1 = Cercle.creerCercle(A,B);
		Cercle C2 = Cercle.creerCercle(A,C);
		Cercle C3 = Cercle.creerCercle(B,C);
		

		//Tests sur les abssices des cercles
		assertEquals("E14 sur C1 (Abssice du centre)", 1.0 , C1.getCentre().getX(), EPSILON);
		assertEquals("E14 sur C2 (Abssice du centre)", 1.0 , C2.getCentre().getX(), EPSILON);
		assertEquals("E14 sur C3 (Abssice du centre)", 3.0 , C3.getCentre().getX(), EPSILON);
		
		//Tests sur les ordonnées des cercles		
		assertEquals("E14 sur C1 (Ordonnée du centre)", 3.0 , C1.getCentre().getY(), EPSILON);
		assertEquals("E14 sur C2 (Ordonnée du centre)", 3.0 , C2.getCentre().getY(), EPSILON);
		assertEquals("E14 sur C3 (Ordonnée du centre)", 1.0 , C3.getCentre().getY(), EPSILON);
		
		//Tests sur la couleur des cercles
		
		assertEquals("E14 sur C1 (Couleur)", Color.blue , C1.getCouleur());
		assertEquals("E14 sur C2 (Couleur)", Color.blue , C2.getCouleur());
		assertEquals("E14 sur C3 (Couleur)", Color.blue , C3.getCouleur());
		
		//Calcule des rayons des cercles
		double r1 = A.distance(B);
		double r2 = A.distance(C);
		double r3 = B.distance(C);
				
		//Tests sur les rayons des cercles
		assertEquals("E14 sur C1 (Rayon)",r1,C1.getRayon(),EPSILON);
		assertEquals("E14 sur C2 (Rayon)",r2,C2.getRayon(),EPSILON);
		assertEquals("E14 sur C3 (Rayon)",r3,C3.getRayon(),EPSILON);
				
		
	}
	
	
	
	
	
	
	
}
	
