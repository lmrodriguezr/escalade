package sevlets;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Utilisateur;
import me.thebio.escalade.Grimpeur;

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
 public class UsersServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
   static final long serialVersionUID = 1L;
   
    /* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public UsersServlet() {
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
			String username = request.getParameter("user");
			if(username==null) username = "%";
			int limit;
			if(request.getParameter("limit")==null) limit = 1000;
			else limit = Integer.parseInt(request.getParameter("limit"));
			
			String json = "";
			String html = "<ul>";
			String h_table = "<table class='selection'><tr><th>Username</th>" +
					"<th>Name</th><th>Ascents</th></tr>\n";
			String j_complete = "";
			
			List<Utilisateur> users = sessionDB.createQuery(
					"from Utilisateur as u where u.nom like ? " +
					"and u.login like ?" +
					"order by u.id desc").
						setString(0, "%"+term+"%").
						setString(1, username).
						setMaxResults(limit).list();
			for(Iterator<Utilisateur> it = users.iterator(); it.hasNext(); ){
				Utilisateur user = it.next();
				Grimpeur g = (Grimpeur) user;
				json += "\"" + user.getLogin() + "\"" + (it.hasNext()?", ":"");
				html += "<li><a href='UserPageServlet?username=" +
					user.getLogin()+"'>" + user.getLogin() + "</a></li>";
				h_table += "<tr><td><a href='UserPageServlet?username="+user.getLogin()+"'>" +
						user.getLogin() + "</a></td><td>" +
						user.getNom() + " " + user.getPrenom() + "</td><td>" +
						g.getAscensions().size() + "</td></tr>";
				j_complete += g.toJson() + (it.hasNext()?", ":"");
			}
			sessionDB.flush();
			
			html += "</ul>";
			json = "[" + json + "]";
			h_table += "</table>";
			j_complete = "{\"items\": ["+j_complete+"]}";
			
			PrintWriter out = response.getWriter();
			if(format.equalsIgnoreCase("html")){
				out.println(html);
			}else if(format.equalsIgnoreCase("html-table")){
				out.println(h_table);
			}else if(format.equalsIgnoreCase("json-complete")){
				out.println(j_complete);
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