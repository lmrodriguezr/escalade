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
 public class ApproachesServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public ApproachesServlet() {
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

			String format = request.getParameter("format");
			if(format==null) format = "json";
			String term = request.getParameter("term");
			if(term==null) term = "";
			int limit;
			if(request.getParameter("limit")==null) limit = 1000;
			else limit = Integer.parseInt(request.getParameter("limit"));
			
			String json = "";
			String html = "<ul>";
			
			List<Voie> approaches = sessionDB.createQuery(
					"from Voie as v where v.nom like ? and " +
					"v.secteur.falaise.pays.nom = ? and " +
					"v.secteur.falaise.ville = ? and " +
					"v.secteur.falaise.nom = ? and " +
					"v.secteur.nom = ?").
						setString(0, "%" + term + "%").
						setString(1, request.getParameter("country")).
						setString(2, request.getParameter("city")).
						setString(3, request.getParameter("mountain")).
						setString(4, request.getParameter("sector")).
						setMaxResults(limit).list();
			for(Iterator<Voie> it = approaches.iterator(); it.hasNext(); ){
				Voie approach = it.next();
				json += "\"" + approach.getNom() + "\"" + (it.hasNext()?", ":"");
				html += "<li>" + approach.getNom() + "</li>";
			}
			sessionDB.flush();
			
			html += "</ul>";
			json = "[" + json + "]";
			
			PrintWriter out = response.getWriter();
			if(format.equalsIgnoreCase("html")){
				out.println(html);
			}else{
				out.println(json);
			}
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