package sevlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.*;

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
 public class AscentsServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public AscentsServlet() {
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
			int limit;
			if(request.getParameter("limit")==null) limit = 1000;
			else limit = Integer.parseInt(request.getParameter("limit"));
			String username = request.getParameter("user");
			if(username==null) username = "%";
			
			
			String json = "";
			String html = "<ul>";
			String table = "<table class='selection'><tr><th>Date</th><th>Country</th>" +
					"<th>Mountain</th><th>Sector</th><th>Path</th><th>User</th>" +
					"<th>Comments</th></tr>";
			
			List<Ascension> ascs = sessionDB.createQuery(
					"from Ascension as a where a.grimpeur.login like ? " +
					"order by a.id desc").
						setString(0, username).
						setMaxResults(limit).list();
			for(Iterator<Ascension> it = ascs.iterator(); it.hasNext(); ){
				Ascension asc = it.next();
				Grimpeur g = asc.getGrimpeur();
				Voie v = asc.getVoie();
				Secteur s = v.getSecteur();
				Falaise f = s.getFalaise();
				json += "" + asc.getId() + (it.hasNext()?", ":"");
				html += "<li>" + asc.getId() + ". At " + asc.getVoie().getNom() + " by " +
						"<a href='UserPageServlet?username=" + g.getLogin() + "'>" +
						g.getLogin() + "</a></li>";
				table += "<tr><td>"+asc.getDate().toString().substring(0, 11).replaceAll("-", "/") + "</td><td>" +
						f.getPays().getNom() + "</td><td>" +
						f.getNom() + "</td><td>" +
						s.getNom() + "</td><td>" +
						v.getNom() + "</td><td>" +
						"<a href='UserPageServlet?username="+g.getLogin()+"'>" +
						g.getLogin() + "</td><td>" +
						asc.getCommentaire() + "</td></tr>";
			}
			sessionDB.flush();
			
			html += "</ul>";
			json = "[" + json + "]";
			
			PrintWriter out = response.getWriter();
			if(format.equalsIgnoreCase("html")){
				out.println(html);
			}else if(format.equalsIgnoreCase("html-table")){
				out.println(table);
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