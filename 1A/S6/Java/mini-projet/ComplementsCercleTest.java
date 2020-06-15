import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
  * Classe de test de la classe Cercle.
  * @author	HABIBI ISSAM
  */

public class ComplementsCercleTest {

	// précision pour les comparaisons réelle
	public static final double EPSILON = 0.001;
	

	// Les points du sujet
	private Point A, B, C, D;

	// Les cercles du sujet
	private Cercle C1;

	@Before public void setUp() {
		// Construire les points
		A = new Point(1, 3);
		B = new Point(3, 1);
		C = new Point(2, 1);
		D = new Point(-55,-3);
		
		C1 = new Cercle(B,50.0);
	}


	
	/** Un test sur l'ensemble des exigences
	 */	
	@Test public void test() {
		
		//Vérifier la création du cercle
		assertEquals(3.0,C1.getCentre().getX(),EPSILON);
		assertEquals(1.0,C1.getCentre().getY(),EPSILON);
		assertEquals(50.0,C1.getRayon(),EPSILON);
		assertEquals(C1.getCouleur(),Color.blue);	
		
		
		//Vérifier que le cercle contient les points A , B et C
		assertTrue(C1.contient(A) && C1.contient(B) && C1.contient(C));
		
		//Changement des caractéristiques du cercle
		C1.setCentre(D);
		C1.setRayon(3.0);
		
		//Vérifier que le cercle ne contient plus les points A , B et C
		assertFalse(C1.contient(A));
		assertFalse(C1.contient(B));
		assertFalse(C1.contient(C));
		assertFalse(C1.getRayon() == 50.0);
		
	}
	
}

