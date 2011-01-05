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
 * @created 03-Nov-2009 16:58:23
 */
@Entity
@Table(name = "h_secteur")
public class Secteur {
	
	@Id
	@GeneratedValue
	private Integer id;
	
	private String nom;

	@ManyToOne
	private Falaise falaise;
	
	@OneToMany(mappedBy = "secteur")
	private Set<Voie> voies = new HashSet<Voie>();

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

	public Falaise getFalaise() {
		return falaise;
	}

	public void setFalaise(Falaise falaise) {
		this.falaise = falaise;
	}

	public Set<Voie> getVoies() {
		return voies;
	}

	public void setVoies(Set<Voie> voies) {
		this.voies = voies;
	}

	public Secteur(){
		
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("secteur(id=" + getId() + ",nom=" + getNom()
				+ ",falaise=" + getFalaise().toString() + ")");
		return sb.toString();
	}

}