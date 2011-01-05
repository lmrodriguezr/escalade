package me.thebio.escalade;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * @version 1.0
 * @created 03-Nov-2009 16:58:21
 */
@Entity
@Table(name="h_pays")
public class Pays {

	@Id
	@GeneratedValue
	private Integer id;

	@Basic(optional = false)
	@Column(unique = true)
	private String nom;

	@OneToMany(mappedBy = "pays")
	private Set<Falaise> falaises = new HashSet<Falaise>();

	public Pays() {

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

	public Set<Falaise> getFalaises() {
		return falaises;
	}

	public void setFalaises(Set<Falaise> falaises) {
		this.falaises = falaises;
	}

	@Override
	public String toString() {
		return "pays(nom=" + nom + ")";
	}
}