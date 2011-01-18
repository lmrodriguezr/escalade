package sevlets;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Writer;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class for Servlet: InstallServlet
 *
 */
public class InstallServlet extends javax.servlet.http.HttpServlet implements javax.servlet.Servlet {
	static final long serialVersionUID = 1L;

	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#HttpServlet()
	 */
	public InstallServlet() {
		super();
	}

	/* (non-Java-doc)
	 * @see javax.servlet.http.HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String server = request.getParameter("mysql_server");
		String database = request.getParameter("mysql_database");
		String user = request.getParameter("mysql_user");
		String passwd = request.getParameter("mysql_passwd");
		String code = request.getParameter("app_code");
		
		String e = "";
		
		if(server==null || server.length()==0) e+= "The server can not be empty.<br/>";
		if(database==null || database.length()==0) e+= "The database can not be empty.<br/>";
		if(user==null) user="";
		if(passwd==null) passwd="";
		if(code==null || code.length()==0) e+= "The code can not be empty.<br/>"; 
		RequestDispatcher dispatcher;
		
		if(e.length()>0){
			request.getSession().setAttribute("error", e.substring(0,e.length()-5));
			dispatcher = getServletContext().getRequestDispatcher("/install.jsp");
		} else {
			String pswd = request.getRealPath("WEB-INF") + "/classes/pswd";
			try {
				MessageDigest md = MessageDigest.getInstance("MD5");
				md.update(code.getBytes());
				byte byteData[] = md.digest();
				//convert the byte to hex format method 1
				StringBuffer sb = new StringBuffer();
				for (int i = 0; i < byteData.length; i++) {
					sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
				}
				File pswdFl = new File(pswd);
		        Writer pswdO = new BufferedWriter(new FileWriter(pswdFl));
		        pswdO.write(sb.toString());
		        pswdO.close();
			} catch (NoSuchAlgorithmException e1) {
				request.getSession().setAttribute("error", 
						"Error saving the code: "+
						e1.getStackTrace().toString());
				dispatcher = getServletContext().getRequestDispatcher("/install.jsp");
				dispatcher.forward(request, response);
				return;
			}
			
			String xml = request.getRealPath("WEB-INF") + "/classes/hibernate.mysql.cfg.xml";
			FileInputStream fstream = new FileInputStream(xml + ".tpl");
			DataInputStream in = new DataInputStream(fstream);
	        BufferedReader br = new BufferedReader(new InputStreamReader(in));
	        String strLine;
	        
	        File file = new File(xml);
	        Writer output = new BufferedWriter(new FileWriter(file));
	        
		    while ((strLine = br.readLine()) != null)   {
		    	strLine = strLine.replaceAll("__mysql_server", server);
		    	strLine = strLine.replaceAll("__mysql_database", database);
		    	strLine = strLine.replaceAll("__mysql_user", user);
		    	strLine = strLine.replaceAll("__mysql_passwd", passwd);
		    	output.write(strLine + "\n");
		    }
		    output.close();
			
			dispatcher = getServletContext().getRequestDispatcher("/");
		}
		
		dispatcher.forward(request, response);
		
	}   	  	    
}