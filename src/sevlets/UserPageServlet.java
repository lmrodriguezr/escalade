package sevlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Utilisateur;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;

/**
 * Servlet implementation class UserPage
 */
public class UserPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserPageServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	doGet(request, response);
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("username");
		Utilisateur user = (Utilisateur)request.getSession().getAttribute("loggedUser");
		SessionFactory sessionFactory = new AnnotationConfiguration().configure(
				Thread.currentThread().getContextClassLoader().getResource("hibernate.mysql.cfg.xml"))
				.buildSessionFactory();
		Session sessionDB = null;
		RequestDispatcher dispatcher;
		try {
			sessionDB = sessionFactory.openSession();
			List<Utilisateur> users = sessionDB.createQuery(
					"from Utilisateur as u where u.login = ?").setString(0, login).list();
			if(users.size()>0) user = users.get(0);
			else if(login!=null) request.getSession().setAttribute("error", "The user does not exist");
			
			if(user!=null) {
				request.getSession().setAttribute("requestedUser", user);
				dispatcher = getServletContext().getRequestDispatcher("/userPage.jsp");
			}else{
				request.getSession().setAttribute("error", "The user does not exist");
				dispatcher = getServletContext().getRequestDispatcher("/peaks.jsp");
			}
			dispatcher.forward(request, response);
			
			sessionDB.flush();
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
