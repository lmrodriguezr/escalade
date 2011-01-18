package me.thebio.escalade;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;



/**
 * @version 1.0
 * @created 15-Nov-2010 10:33:00
 */
@Entity
//@Inheritance(strategy = InheritanceType.SINGLE_TABLE) // h1
//@DiscriminatorColumn(name="typeUtilisateur", discriminatorType=DiscriminatorType.STRING) // h1
//@Table(name = "h1_utilisateur")	// h1
@Inheritance(strategy = InheritanceType.JOINED)	// h2
@Table(name = "h2_utilisateur")		// h2
//@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)	// h3
//@Table(name = "h3_utilisateur")		// h3
public abstract class Utilisateur {

	@Id
	@GeneratedValue(strategy = GenerationType.TABLE)
	private Integer id;

	@Basic(optional = false)
	@Column(unique = true)
	private String login;

	@Basic(optional = false)
	private String password;
	
	private String email;
	private String nom;
	private String prenom;

	public Utilisateur() {
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPrenom() {
		return prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

}