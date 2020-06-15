package allumettes;


/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Partie {

	public static final int NB_ALUMETTES = 13;

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		try {
			verifierNombreArguments(args);
			Jeu jeuAlumettes = new JeuAlumettes(NB_ALUMETTES);
			if (args.length == 2) {
				String[] premierArgument = args[0].split("@");
				String[] deuxiemeArgument = args[1].split("@");
				Joueur joueur1 = new Joueur(premierArgument[0],
						toStrategie(premierArgument[1]));
				Joueur joueur2 = new Joueur(deuxiemeArgument[0],
						toStrategie(deuxiemeArgument[1]));
				Arbitre arbitre = new Arbitre(joueur1, joueur2);
				arbitre.setEtat(Etat.MEFIANT);
				arbitre.arbitrer(jeuAlumettes);
			} else {
				if (!args[0].toLowerCase().equals("-confiant")) {
					throw new IllegalArgumentException();
				}
				String[] premierArgument = args[1].split("@");
				String[] deuxiemeArgument = args[2].split("@");
				Joueur joueur1 = new Joueur(premierArgument[0],
						toStrategie(premierArgument[1]));
				Joueur joueur2 = new Joueur(deuxiemeArgument[0],
						toStrategie(deuxiemeArgument[1]));
				Arbitre arbitre = new Arbitre(joueur1, joueur2);
				arbitre.setEtat(Etat.CONFIANT);
				arbitre.arbitrer(jeuAlumettes);
			}
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		} catch (IllegalArgumentException e) {
			System.out.println();
			System.out.println("Vous devez insérer :"
		+ " -confiant player1@strategie1 player2@strategie2");
		} catch (ArrayIndexOutOfBoundsException e) {
			System.out.println();
			afficherUsage();
		}
	}


	/** Convertir un string décrivant la stratégie
	 * en une stratgie
	 * @param strategie le string stratégie
	 * @return la stratégie
	 */
	public static Strategie toStrategie(String strategie) {
		Strategie strat = null;
		if (strategie.toLowerCase().equals("humain")) {
			strat = new StrategieHumaine();
		} else if (strategie.toLowerCase().equals("naif")) {
			strat = new StrategieNaive();
		} else if (strategie.toLowerCase().equals("rapide")) {
			strat = new StrategieRapide();
		} else if (strategie.toLowerCase().equals("expert")) {
			strat = new StrategieExpert();
		} else if (strategie.toLowerCase().equals("tricheur")) {
			strat = new StrategieTricheur();
		} else if (strategie.toLowerCase().equals("lente")) {
			strat = new StrategieLente();
		} else {
			throw new ConfigurationException("Stratégie inconnue");
		}
		return strat;
	}


	private static void verifierNombreArguments(String[] args) {
		final int nbJoueurs = 2;
		if (args.length < nbJoueurs) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > nbJoueurs + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Partie joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert | humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Partie Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

}
