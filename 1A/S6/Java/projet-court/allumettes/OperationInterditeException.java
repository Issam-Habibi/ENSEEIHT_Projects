package allumettes;

public class OperationInterditeException extends RuntimeException {

	/** Initaliser une ConfigurationException avec le message précisé.
	  */
	public OperationInterditeException() {
		super("L'operation retirer est interdite");
	}

}


