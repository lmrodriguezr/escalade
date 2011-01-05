package me.thebio.escalade;

import java.util.HashSet;
import java.util.Set;

//import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * @version 1.0
 * @created 03-Nov-2009 16:58:20
 */
@Entity
//@DiscriminatorValue("Grimpeur")	// h1
@Table(name = "h2_grimpeur")		// h2
//@Table(name = "h3_grimpeur")		// h3
public class Grimpeur extends Utilisateur {

	private int age;
	private int poids;
	private int taille;
	
	@OneToMany(mappedBy = "grimpeur")
	private Set<Ascension> ascensions = new HashSet<Ascension>();

	@ManyToMany(mappedBy = "grimpeurs")
	@JoinTable(name = "h_grimpeur_falaise", joinColumns = @JoinColumn(name = "grimpeur_id"), inverseJoinColumns = @JoinColumn(name = "falaise_id"))
	private Set<Falaise> falaises = new HashSet<Falaise>();
	
	public Grimpeur() {
		;
	}

	public Set<Falaise> getFalaises() {
		return falaises;
	}

	public void setFalaises(Set<Falaise> falaises) {
		this.falaises = falaises;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getPoids() {
		return poids;
	}

	public void setPoids(int poids) {
		this.poids = poids;
	}

	public int getTaille() {
		return taille;
	}

	public void setTaille(int taille) {
		this.taille = taille;
	}

	public Set<Ascension> getAscensions() {
		return ascensions;
	}

	public void setAscensions(Set<Ascension> ascencions) {
		this.ascensions = ascencions;
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("grimpeur(id=" + getId() + ",login=" + getLogin()
				+ ",nom=" + getNom() + ",prenom=" + getPrenom() + ")");
		return sb.toString();
	}

}