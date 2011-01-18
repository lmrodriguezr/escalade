package sevlets;

import java.io.IOException;
import java.text.ParseException;
import java.util.HashSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Ascension;
import me.thebio.escalade.Falaise;
import me.thebio.escalade.Grimpeur;
import me.thebio.escalade.Pays;
import me.thebio.escalade.Secteur;
import me.thebio.escalade.Utilisateur;
import me.thebio.escalade.Voie;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;

/**
 * Servlet implementation class CreateUserServlet
 */
public class DeleteAscentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteAscentServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    /**
	 * @throws ParseException 
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @throws ParseException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/userAscents.jsp");
		String idStr = request.getParameter("id");
		
		String err = "";
		
		if(idStr==null || idStr.length()==0) {
			err = "Any ascent selected.";
			request.getSession().setAttribute("error", err);
			dispatcher.forward(request, response);
			return;
		}
		int id = Integer.parseInt(idStr);
		
		SessionFactory sessionFactory = new AnnotationConfiguration()
			.configure(
					Thread.currentThread().getContextClassLoader()
						.getResource("hibernate.mysql.cfg.xml"))
			.buildSessionFactory();
		Session sessionDB = null;
	try {
		sessionDB = sessionFactory.openSession();
		// Ascension
		Ascension ascension = (Ascension) sessionDB.load(Ascension.class, id);
		if(ascension == null){
			err = "Ascent does not exist.";
			request.getSession().setAttribute("error", err);
			dispatcher.forward(request, response);
			return;
		}
		// Granted access?
		Utilisateur user = (Utilisateur) request.getSession().getAttribute("loggedUser");
		Grimpeur grimpeur = ascension.getGrimpeur();
		if(user==null || ! user.getLogin().equals(grimpeur.getLogin())){
			err = "You must log in as the owner climber to delete this ascent.";
			request.getSession().setAttribute("error", err);
			dispatcher.forward(request, response);
			return;
		}
		// Sanitize
		Voie voie = ascension.getVoie();
		Secteur secteur = voie.getSecteur();
		Falaise falaise = secteur.getFalaise();
		if(voie.getAscensions().size()==1){
				if(secteur.getVoies().size()==1){
					if(falaise.getSecteurs().size()==1){
						Pays pays = falaise.getPays();
						if(pays.getFalaises().size()==1){
							sessionDB.delete(pays);
						}
						sessionDB.delete(secteur);
					}
					sessionDB.delete(falaise);
				}
				sessionDB.delete(voie);
		}
		
		// Delete ascent
		grimpeur.setFalaises(new HashSet<Falaise>());
		sessionDB.update(grimpeur); //<- to avoid constrainst restrictions
		sessionDB.delete(ascension);
		sessionDB.flush();
		sessionDB.close();
		sessionDB = null;
		
		// And update user
		grimpeur.updateFalaises(sessionFactory);
		
		dispatcher.forward(request, response);
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
