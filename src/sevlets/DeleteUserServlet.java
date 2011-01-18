package sevlets;

import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashSet;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import me.thebio.escalade.Ascension;
import me.thebio.escalade.Falaise;
import me.thebio.escalade.Grimpeur;

import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.classic.Session;

/**
 * Servlet implementation class for Servlet: DeleteUserServlet
 *
 */
public class DeleteUserServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	static final long serialVersionUID = 1L;

	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public DeleteUserServlet() {
		super();
	}

	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/");
		String code = request.getParameter("code");
		String uidStr = request.getParameter("uid");

		String err = "";

		if(uidStr==null || uidStr.length()==0) {
			err = "Any user selected.";
			request.getSession().setAttribute("error", err);
			dispatcher.forward(request, response);
			return;
		}
		int uid = Integer.parseInt(uidStr);
		
		String pswdPath = request.getRealPath("WEB-INF") + "/classes/pswd";
		FileInputStream fstream = new FileInputStream(pswdPath);
		DataInputStream in = new DataInputStream(fstream);
        BufferedReader br = new BufferedReader(new InputStreamReader(in));
        String strLine = br.readLine();
        Boolean codeOk = false;
        try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			md.update(code.getBytes());
			byte byteData[] = md.digest();
			//convert the byte to hex format method 1
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {
				sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
			}
			codeOk = (strLine!=null && sb.toString().equals(strLine));
		} catch (NoSuchAlgorithmException e1) {
			request.getSession().setAttribute("error", 
					"Error crypting the code: "+
					e1.getStackTrace().toString());
			dispatcher.forward(request, response);
			return;
		}
		
		if(!codeOk){
			request.getSession().setAttribute("error", 
					"Something went wrong with the code");
			dispatcher.forward(request, response);
			return;
		}
		SessionFactory sessionFactory = new AnnotationConfiguration()
		.configure(
				Thread.currentThread().getContextClassLoader()
				.getResource("hibernate.mysql.cfg.xml"))
				.buildSessionFactory();
		Session sessionDB = null;
		try {
			sessionDB = sessionFactory.openSession();
			Grimpeur grimpeur = (Grimpeur) sessionDB.load(Grimpeur.class, uid);
			for(Iterator<Ascension> it = grimpeur.getAscensions().iterator(); it.hasNext(); ){
				sessionDB.delete(it.next());
			}
			grimpeur.setFalaises(new HashSet<Falaise>());
			sessionDB.delete(grimpeur);
			sessionDB.flush();
			request.getSession().setAttribute("message","User removed successfully");
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