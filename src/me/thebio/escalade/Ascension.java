package me.thebio.escalade;

import java.util.Date;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * @version 1.0
 * @created 03-Nov-2009 16:58:25
 */
@Entity
@Table(name="h_ascension")
public class Ascension {

	@Id
	@GeneratedValue
	private Integer id;
	private Date date;
	private String commentaire;
	private int etoiles;
	private int note;
	private boolean recommande;
	private int ressentiDifficulte;
	private int style;

	@ManyToOne
	private Cotation cotation;
	@ManyToOne
	private Grimpeur grimpeur;
	@ManyToOne
	private Voie voie;

	public Ascension() {

	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getCommentaire() {
		return commentaire;
	}

	public void setCommentaire(String commentaire) {
		this.commentaire = commentaire;
	}

	public int getEtoiles() {
		return etoiles;
	}

	public void setEtoiles(int etoiles) {
		this.etoiles = etoiles;
	}

	public int getNote() {
		return note;
	}

	public void setNote(int note) {
		this.note = note;
	}

	public boolean isRecommande() {
		return recommande;
	}

	public void setRecommande(boolean recommande) {
		this.recommande = recommande;
	}

	public int getRessentiDifficulte() {
		return ressentiDifficulte;
	}

	public void setRessentiDifficulte(int ressentiDifficulte) {
		this.ressentiDifficulte = ressentiDifficulte;
	}

	public int getStyle() {
		return style;
	}

	public void setStyle(int style) {
		this.style = style;
	}

	public Cotation getCotation() {
		return cotation;
	}

	public void setCotation(Cotation cotation) {
		this.cotation = cotation;
	}

	public Grimpeur getGrimpeur() {
		return grimpeur;
	}

	public void setGrimpeur(Grimpeur grimpeur) {
		this.grimpeur = grimpeur;
	}

	public Voie getVoie() {
		return voie;
	}

	public void setVoie(Voie voie) {
		this.voie = voie;
	}
	@Override
	public String toString() {
		StringBuilder sb = new StringBuilder();
		sb.append("ascension(id=" + id + ",date=" + date.toString()
				+ ",etoiles=" + etoiles + ",cotation=" + cotation.toString()
				+ ",grimpeur=" + grimpeur.toString() + ")");
		return sb.toString();
	}

}