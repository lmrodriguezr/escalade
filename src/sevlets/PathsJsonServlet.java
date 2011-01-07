package sevlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Voie;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;

import java.io.*;
import java.util.Iterator;
import java.util.List;


/**
 * Servlet implementation class for Servlet: CountriesJsonServlet
 *
 */
 public class PathsJsonServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public PathsJsonServlet() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		SessionFactory sessionFactory = new AnnotationConfiguration().configure(
				Thread.currentThread().getContextClassLoader().getResource("hibernate.mysql.cfg.xml"))
				.buildSessionFactory();
		Session sessionDB = null;
		try {
			sessionDB = sessionFactory.openSession();
			String json = "\""+request.getParameter("term")+"\"";
			List<Voie> paths = sessionDB.createQuery(
					"from Voie as v where v.nom like ? and " +
					"v.secteur.falaise.pays.nom = ? and " +
					"v.secteur.falaise.nom = ? and " +
					"v.secteur.nom = ?").
						setString(0, "%" + request.getParameter("term") + "%").
						setString(1, request.getParameter("country")).
						setString(2, request.getParameter("mountain")).
						setString(3, request.getParameter("sector")).list();
			for(Iterator<Voie> it = paths.iterator(); it.hasNext(); ){
				Voie path = it.next();
				json += ", \"" + path.getNom() + "\"";
			}
			
			
			PrintWriter out = response.getWriter();
		    out.println("["+json+"]");
			
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