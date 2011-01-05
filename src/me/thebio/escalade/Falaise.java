package me.thebio.escalade;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * @version 1.0
 * @created 03-Nov-2009 16:58:22
 */
@Entity
@Table(name = "h_falaise", uniqueConstraints = { @UniqueConstraint(columnNames = {
		"nom", "pays_id" }) })
public class Falaise {

	@ManyToOne
	@JoinColumn(name = "pays_id")
	private Pays pays;

	@Id
	@GeneratedValue
	private Integer id;

	@Basic(optional = false)
	private String nom;
	private String ville;

	@OneToMany(mappedBy="falaise")
	private Set<Secteur> secteurs = new HashSet<Secteur>();

	@ManyToMany
	private Set<Grimpeur> grimpeurs = new HashSet<Grimpeur>();

	public Set<Grimpeur> getGrimpeurs() {
		return grimpeurs;
	}

	public void setGrimpeurs(Set<Grimpeur> grimpeurs) {
		this.grimpeurs = grimpeurs;
	}

	public Falaise() {

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

	public String getVille() {
		return ville;
	}

	public void setVille(String ville) {
		this.ville = ville;
	}

	public Pays getPays() {
		return pays;
	}

	public void setPays(Pays pays) {
		this.pays = pays;
	}

	public Set<Secteur> getSecteurs() {
		return secteurs;
	}

	public void setSecteurs(Set<Secteur> secteurs) {
		this.secteurs = secteurs;
	}

	@Override
	public String toString() {
		return "falaise(id=" + getId() + "nom=" + getNom() +
				",ville=" + getVille() + ",pays=" + getPays().toString() + ");";
	}

}