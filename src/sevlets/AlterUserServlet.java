package sevlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Grimpeur;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;

/**
 * Servlet implementation class CreateUserServlet
 */
public class AlterUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AlterUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Grimpeur gp = (Grimpeur) request.getSession().getAttribute("loggedUser");
		
		String password = request.getParameter("password");
		String password2 = request.getParameter("password2");
		String email = request.getParameter("email");
		String nom = request.getParameter("nom");
		String prenom = request.getParameter("prenom");
		String gender = request.getParameter("gender");
		Integer age = Integer.parseInt("0"+request.getParameter("age"));
		Integer poids = Integer.parseInt("0"+request.getParameter("poids"));
		Integer taille = Integer.parseInt("0"+request.getParameter("taille"));
		String err = "";
		if(password.length()>0 && !password.equals(password2)) err += "The two passwords do not match.<br/>";
		if(nom.length()==0) err += "The surename can not be empty.<br/>";
		if(prenom.length()==0) err += "The forename can not be empty.<br/>";
		
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
			dispatcher = getServletContext().getRequestDispatcher("/settings.jsp");
		}else{
			sessionDB = sessionFactory.openSession();
			if(age>0) gp.setAge(age);
			gp.setNom(nom);
			if(poids>0) gp.setPoids(poids);
			gp.setPrenom(prenom);
			if(password.length()>0) gp.setPassword(password);
			if(email.length()>0) gp.setEmail(email);
			if(taille>0) gp.setTaille(taille);
			if(gender.length()>0) gp.setGender(gender);
			sessionDB.update(gp);
			
			request.getSession().setAttribute("password", gp.getPassword());
			sessionDB.flush();
			
			dispatcher = getServletContext().getRequestDispatcher("/userPage.jsp");
		}
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
