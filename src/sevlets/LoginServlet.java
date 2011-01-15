package sevlets;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;

import me.thebio.escalade.*;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String login = request.getParameter("login");
		String password = request.getParameter("password");

		request.getSession().setAttribute("login", login);
		request.getSession().setAttribute("password", password);
		
		SessionFactory sessionFactory = new AnnotationConfiguration().configure(
				Thread.currentThread().getContextClassLoader().getResource("hibernate.mysql.cfg.xml"))
				.buildSessionFactory();
		Session sessionDB = null;
		try {
			sessionDB = sessionFactory.openSession();
			// TODO Check number of results
			List res = sessionDB.createQuery(
						"from Utilisateur as u where u.login = ?").
					setString(0, login).
					list();
			RequestDispatcher dispatcher;
			if(res.isEmpty()){
				request.getSession().setAttribute("error", "Wrong username or password");
				dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
			}else{
				Utilisateur user = (Utilisateur) res.get(0);
				
				if(user == null || !user.getPassword().equals(password)){
					request.getSession().setAttribute("error", "Wrong username or password");
					dispatcher = getServletContext().getRequestDispatcher("/login.jsp");
				}else{
					request.getSession().setAttribute("loggedUser", user);
					dispatcher = getServletContext().getRequestDispatcher("/userPage.jsp");
				}
			}
			sessionDB.flush();
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
