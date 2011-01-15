package me.thebio.escalade;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;


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
	private String gender;
	
	@OneToMany(mappedBy = "grimpeur")
	private Set<Ascension> ascensions = new HashSet<Ascension>();

	@ManyToMany(targetEntity=Falaise.class)
	@JoinTable(name = "h_falaise_h2_grimpeur", joinColumns = @JoinColumn(name = "grimpeurs_id"), inverseJoinColumns = @JoinColumn(name = "falaises_id"))
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
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender ;
	}

	public Set<Ascension> getAscensions() {
		return ascensions;
	}

	public void setAscensions(Set<Ascension> ascensions) {
		this.ascensions = ascensions;
	}
	
	@SuppressWarnings("unchecked")
	public void updateFalaises(SessionFactory sessionFactory){
		Session session=null;
		try{
			session = sessionFactory.openSession();
			List<Falaise> falaises = session.createQuery(
				"select distinct f from Falaise f, Ascension a where " +
				"a.grimpeur = ? and " +
				"a.voie.secteur.falaise = f").
				setEntity(0, this).list();
			Set<Falaise> fSet = new HashSet(falaises);
			this.setFalaises(fSet);
			session.update(this);
			session.flush();
		}finally{
			if(session!=null)
				session.close();
		}
	}
	
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("grimpeur(id=" + getId() + ",login=" + getLogin()
				+ ",nom=" + getNom() + ",prenom=" + getPrenom() + ")");
		return sb.toString();
	}
	public String toJson() {
		return "{\"id\": "+getId()+", \"login\": \""+getLogin()+
				"\", \"nom\": \""+getNom()+"\", \"prenom\": \"" + getPrenom() + "\", \"gender\": \""+getGender()+
				"\", \"age\": "+ getAge() + ", \"poids\": "+getPoids() + 
				", \"taille\": "+getTaille()+", \"ascensions\": "+getAscensions().size() +
				", \"falaises\": "+getFalaises().size()+"}";
	}
}