package me.thebio.escalade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * @version 1.0
 * @created 03-Nov-2009 16:58:28
 */
@Entity
/* contrainte d'intégrités */
@Table(name = "h_cotation", uniqueConstraints = {
		@UniqueConstraint(columnNames = { "degre", "lettre", "nuance" }),
		@UniqueConstraint(columnNames = { "code" }) })
public class Cotation {

	public enum Nuance {
		PLUS, MOINS, AUCUNE
	}

	public enum Lettre {
		A, B, C
	};

	@Id
	@GeneratedValue
	private Integer id;

	private Integer degre;
	private Lettre lettre;
	private Nuance nuance;

	@Column(nullable = false)
	private String code;

	public Cotation() {
	}
	
	public Cotation(int degre, Lettre lettre) {
		this(degre, lettre, Nuance.AUCUNE);
	}

	public Cotation(int degre, Lettre lettre, Nuance nuance) {
		super();
		this.degre = degre;
		this.lettre = lettre;
		this.nuance = nuance;
		this.code = buildCode();
	}

	protected String buildCode() {
		if (degre == null || lettre == null) {
			return null;
		}

		StringBuilder sb = new StringBuilder();
		sb.append(degre);
		if (lettre == Lettre.A) {
			sb.append("a");
		} else if (lettre.equals(Lettre.B)) {
			sb.append("b");
		} else if (lettre.equals(Lettre.C)) {
			sb.append("c");
		}

		if (nuance != null) {
			if (nuance.equals(Nuance.MOINS)) {
				sb.append("-");
			} else if (nuance.equals(Nuance.PLUS)) {
				sb.append("+");
			}
		}

		return sb.toString();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public int getDegre() {
		return degre;
	}

	public void setDegre(int degre) {
		this.degre = degre;
	}

	public Lettre getLettre() {
		return lettre;
	}

	public void setLettre(Lettre lettre) {
		this.lettre = lettre;
	}

	public Nuance getNuance() {
		return nuance;
	}

	public void setNuance(Nuance nuance) {
		this.nuance = nuance;
	}

	@Override
	public String toString() {
		return getCode();
	}

}