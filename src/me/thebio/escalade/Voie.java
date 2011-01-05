package me.thebio.escalade;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * @version 1.0
 * @created 03-Nov-2009 16:58:24
 */
@Entity
@Table(name = "h_voie")
public class Voie {

	@Id
	@GeneratedValue
	private Integer id;

	private String nom;
	
	@ManyToOne
	private Cotation cotation;
	
	@ManyToOne
	private Secteur secteur;
	
	@OneToMany(mappedBy="voie")
	private Set<Ascension> ascensions = new HashSet<Ascension>();

	public Voie() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public Cotation getCotation() {
		return cotation;
	}

	public void setCotation(Cotation cotation) {
		this.cotation = cotation;
	}

	public Secteur getSecteur() {
		return secteur;
	}

	public void setSecteur(Secteur secteur) {
		this.secteur = secteur;
	}

	public Set<Ascension> getAscensions() {
		return ascensions;
	}

	public void setAscensions(Set<Ascension> a) {
		this.ascensions = a;
	}

	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("voie(nom=" + nom + ",cotation=" + getCotation().toString()
				+ ",secteur=" + getSecteur().toString() + ")");
		return sb.toString();
	}

}