package me.thebio.escalade;

//import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @version 1.0
 * @created 15-Nov-2010 10:40:00
 */
@Entity
//@DiscriminatorValue("Administrateur")	// h1
@Table(name = "h2_administrateur")		// h2
//@Table(name = "h3_administrateur")		// h3
public class Administrateur extends Utilisateur {

	private String visibleEmail;
	
	public Administrateur() {
		;
	}

	public String getVisibleEmail() {
		return visibleEmail;
	}

	public void setVisibleEmail(String visibleEmail) {
		this.visibleEmail = visibleEmail ;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("administrateur(id=" + getId() + ",login=" + getLogin()
				+ ",nom=" + getNom() + ",prenom=" + getPrenom() + ")");
		return sb.toString();
	}

}