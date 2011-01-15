package sevlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.*;
import me.thebio.escalade.Cotation.*;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;

/**
 * Servlet implementation class CreateUserServlet
 */
public class CreateAscentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreateAscentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @throws ParseException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String commentaire = request.getParameter("comment");
		String cotation_degre_str = request.getParameter("degree");
		String cotation_lettre_str = request.getParameter("letter");
		String cotation_nuance_str = request.getParameter("grade");
		String date_str = request.getParameter("date");
		String etoiles_str = request.getParameter("score");
		String voie_str = request.getParameter("voie");
		String secteur_str = request.getParameter("secteur");
		String falaise_str = request.getParameter("falaise");
		String ville = request.getParameter("ville");
		String pays_str = request.getParameter("pays");
		Grimpeur grimpeur = (Grimpeur) request.getSession().getAttribute("loggedUser");
		
		String err = "";
		
		if(commentaire==null) commentaire = "";
		if(etoiles_str==null || etoiles_str.length()==0) err += "You must rank the ascent.<br/>";
		if(date_str==null || date_str.length()==0) err += "The date can not be empty.<br/>";
		if(voie_str==null || voie_str.length()==0) err += "The approach can not be empty.<br/>";
		if(secteur_str==null || secteur_str.length()==0) err += "The sector can not be empty.<br/>";
		if(falaise_str==null || falaise_str.length()==0) err += "The mountain can not be empty.<br/>";
		if(ville==null || ville.length()==0) err += "The city can not be empty.<br/>";
		if(pays_str==null || pays_str.length()==0) err += "The country can not be empty.<br/>";
		if(grimpeur==null) err += "You must log in to access this page.<br/>";
		
		SessionFactory sessionFactory = new AnnotationConfiguration()
			.configure(
					Thread.currentThread().getContextClassLoader()
						.getResource("hibernate.mysql.cfg.xml"))
			.buildSessionFactory();
		Session sessionDB = null;
	try {
		RequestDispatcher dispatcher;
		if(err.length()>0){
			request.getSession().setAttribute("error", err.substring(0,err.length()-5));
			dispatcher = getServletContext().getRequestDispatcher("/newAscent.jsp");
		}else{
			sessionDB = sessionFactory.openSession();
			// Cotation
			int cotation_degre = Integer.parseInt(cotation_degre_str);
			Lettre cotation_lettre = Lettre.valueOf(cotation_lettre_str);
			Nuance cotation_nuance = Nuance.AUCUNE;
			if(cotation_nuance_str.equals("+")) cotation_nuance = Nuance.PLUS;
			if(cotation_nuance_str.equals("-")) cotation_nuance = Nuance.MOINS;
			
			List<Cotation> categories = sessionDB.createQuery(
					"from Cotation as c where " +
					"c.degre = ? and " +
					"c.lettre = ? and " +
					"c.nuance = ?").
					setInteger(0, cotation_degre).
					setInteger(1, cotation_lettre.ordinal()).
					setInteger(2, cotation_nuance.ordinal()).
					list();
			Cotation cotation;
			if(categories.size()==0){
				cotation = new Cotation(cotation_degre, cotation_lettre, cotation_nuance);
				sessionDB.save(cotation);
			}else{
				cotation = categories.get(0);
			}
			
			// Pays
			Pays pays;
			List<Pays> countries = sessionDB.createQuery(
					"from Pays as p where p.nom = ?").
					setString(0, pays_str).list();
			if(countries.size()==0){
				pays = new Pays();
				pays.setNom(pays_str);
				sessionDB.save(pays);
			}else{
				pays = countries.get(0);
			}
			
			// Falaise
			Falaise falaise;
			List<Falaise> mountains = sessionDB.createQuery(
					"from Falaise as f where f.nom = ? and f.pays = ?").
					setString(0, falaise_str).
					setEntity(1, pays).list();
			if(mountains.size()==0){
				falaise = new Falaise();
				falaise.setNom(falaise_str);
				falaise.setPays(pays);
				falaise.setVille(ville);
				sessionDB.save(falaise);
			}else{
				falaise = mountains.get(0);
			}
			
			// Secteur
			Secteur secteur;
			List<Secteur> sectors = sessionDB.createQuery(
					"from Secteur as s where s.nom = ? and s.falaise = ?").
					setString(0, secteur_str).
					setEntity(1, falaise).list();
			if(sectors.size()==0){
				secteur = new Secteur();
				secteur.setFalaise(falaise);
				secteur.setNom(secteur_str);
				sessionDB.save(secteur);
			}else{
				secteur = sectors.get(0);
			}
			
			// Voie
			Voie voie;
			List<Voie> approaches = sessionDB.createQuery(
					"from Voie as v where v.nom = ? and v.secteur = ?").
					setString(0, voie_str).
					setEntity(1, secteur).list();
			if(approaches.size()==0){
				voie = new Voie();
				voie.setSecteur(secteur);
				voie.setNom(voie_str);
				voie.setCotation(cotation);
				sessionDB.save(voie);
			}else{
				voie = approaches.get(0);
			}
			
			// Ascension
			DateFormat formatter = new SimpleDateFormat("MM/dd/yy");
		    Date date = formatter.parse(date_str);
		    int etoiles = Integer.parseInt(etoiles_str);
			Ascension ascension = new Ascension();
			ascension.setCommentaire(commentaire);
			ascension.setCotation(cotation);
			ascension.setDate(date);
			ascension.setEtoiles(etoiles);
			ascension.setGrimpeur(grimpeur);
			ascension.setRecommande(etoiles>=4);
			ascension.setVoie(voie);
			sessionDB.save(ascension);
			
			// Grimpeurs - Falaises
			grimpeur.updateFalaises(sessionFactory);
			
			sessionDB.flush();
			
			dispatcher = getServletContext().getRequestDispatcher("/userAscents.jsp");
		}
		dispatcher.forward(request, response);
	} catch(ParseException e){
		e.printStackTrace();
	} finally {
		if (sessionDB != null) {
			// silent close session
			try {
				sessionDB.close();
			} catch (HibernateException e) {
				throw e;
			}
		}
		// silent close session factory
		if (sessionFactory != null) {
			try {
				sessionFactory.close();
			} catch (HibernateException e) {
				throw e;
			}
		}

	}
	}

}
