package sevlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Pays;

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
 public class CountriesServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public CountriesServlet() {
		super();
	}   	
	
	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
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
			
			List<Pays> countries = sessionDB.createQuery(
					"from Pays as p where p.nom like ?").
						setString(0, "%"+term+"%").
						setMaxResults(limit).list();
			for(Iterator<Pays> it = countries.iterator(); it.hasNext(); ){
				Pays country = it.next();
				json += "\"" + country.getNom() + "\"" + (it.hasNext()?", ":"");
				html += "<li>" + country.getNom() + "</li>";
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