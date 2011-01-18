package sevlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Falaise;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;


/**
 * Servlet implementation class for Servlet: CountriesJsonServlet
 *
 */
 public class MountainsServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public MountainsServlet() {
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
			String country = request.getParameter("country");
			if(country==null) country = "%";
			String city = request.getParameter("city");
			if(city==null) city = "%";
			String username = request.getParameter("user");
			if(username==null) username = "%";
			String ascent = request.getParameter("ascent");
			if(ascent==null) ascent = "%";
			
			String json = "";
			String complete = "";
			String html = "<ul>";
			
			List<Falaise> mountains = sessionDB.createQuery(
					"select distinct f " +
					"from Falaise f, Ascension a, Grimpeur g " +
					"where f.nom like ? and " +
					"f.ville like ? and " +
					"f.pays.nom like ? and " +
					"f = a.voie.secteur.falaise and " +
					"a in elements(g.ascensions) and " +
					"g.login like ? and " +
					"a.id like ?").
						setString(0, "%" + term + "%").
						setString(1, city).
						setString(2, country).
						setString(3, username).
						setString(4, ascent).
						setMaxResults(limit).list();
			for(Iterator<Falaise> it = mountains.iterator(); it.hasNext(); ){
				
				Falaise mountain = it.next();
				json += "\"" + mountain.getNom() + "\"" + (it.hasNext()?", ":"");
				html += "<li>" + mountain.getNom() + "</li>";
				complete += mountain.toJson() + (it.hasNext()?", ":"");
			}
			sessionDB.flush();
			
			html += "</ul>";
			json = "[" + json + "]";
			complete = "{\"items\": [" + complete + "]}";
			
			PrintWriter out = response.getWriter();
			if(format.equalsIgnoreCase("html")){
				out.println(html);
			}else if(format.equalsIgnoreCase("json-complete")) {
				out.println(complete);
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