package sevlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Ascension;
import me.thebio.escalade.Falaise;
import me.thebio.escalade.Grimpeur;
import me.thebio.escalade.Secteur;
import me.thebio.escalade.Utilisateur;
import me.thebio.escalade.Voie;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;


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
			int limit;
			if(request.getParameter("limit")==null) limit = 1000;
			else limit = Integer.parseInt(request.getParameter("limit"));
			String username = request.getParameter("user");
			if(username==null) username = "%";
			
			
			String json = "";
			String html = "<ul>";
			String h_table = "<table class='selection'><tr><th>Date</th><th>Country</th>" +
					"<th>City</th><th>Mountain</th><th>Sector</th><th>Path</th><th>User</th>" +
					"<th>Comments</th><th>&nbsp;</th></tr>";
			String complete = "";
			String j_table = "";
			Utilisateur loggedUser = ((Utilisateur)request.getSession().getAttribute("loggedUser"));
			
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
				String actions = "<img onclick='location.href=\"map.jsp?ascent="+asc.getId()+"\"' " +
						"style='cursor:pointer' " +
						"src='lib/img/world.png' alt='map' /> ";
				if(loggedUser!=null && asc.getGrimpeur().getLogin().equals(loggedUser.getLogin())){
					actions += "<img onclick='deleteAscent(" + asc.getId() + ");' " +
								"style='cursor:pointer' title='delete ascent' " +
								"src='lib/img/cancel-on.png' alt='delete' /> ";
				}
				json += "" + asc.getId() + (it.hasNext()?", ":"");
				html += "<li>" + asc.getId() + ". At " + asc.getVoie().getNom() + " by " +
						"<a href='userPage.jsp?user=" + g.getLogin() + "'>" +
						g.getLogin() + "</a></li>";
				h_table += "<tr><td>"+asc.getDate().toString().substring(0, 11).replaceAll("-", "/") + "</td><td>" +
						asc.getCotation().getCode() + "</td><td>" +
						f.getPays().getNom() + "</td><td>" +
						f.getVille() + "</td><td>" +
						f.getNom() + "</td><td>" +
						s.getNom() + "</td><td>" +
						v.getNom() + "</td><td>" +
						"<a href='userPage.jsp?user="+g.getLogin()+"'>" +
						g.getLogin() + "</td><td>" +
						asc.getCommentaire() + "</td><td>" +
						actions + "</td></tr>";
				complete += asc.toJson() + (it.hasNext()?", ":"");
				j_table += "{\"id\": "+asc.getId()+", \"cell\": [" +
						"\""+asc.getDate().toString().substring(0,11).replaceAll("-","/")+"\", \"" +
						asc.getCotation().getCode()+"\", \"" +
						f.getPays().getNom()+"\", \"" +
						f.getVille() + "\", \"" +
						f.getNom() + "\", \"" +
						s.getNom() + "\", \"" +
						v.getNom() + "\", \"" +
						"<a href='userPage.jsp?user="+g.getLogin()+"'>" +
						g.getLogin() + "</a>\", \"" +
						asc.getCommentaire() + "\", \"" +
						actions.replaceAll("\"", "&quot;") + "\"]}" +
						(it.hasNext()?", ":"");
			}
			sessionDB.flush();
			
			html += "</ul>";
			json = "[" + json + "]";
			complete = "{ \"items\": [" + complete + "]}";
			j_table = "{ \"rows\": ["+j_table+"]}";
			
			PrintWriter out = response.getWriter();
			if(format.equalsIgnoreCase("html")){
				out.println(html);
			}else if(format.equalsIgnoreCase("html-table")){
				out.println(h_table);
			}else if(format.equalsIgnoreCase("json-complete")){
				out.println(complete);
			}else if(format.equalsIgnoreCase("json-table")){
				out.println(j_table);
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