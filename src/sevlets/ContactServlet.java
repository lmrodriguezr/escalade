package sevlets;

// Copyright © 2001 by Apple Computer, Inc., All Rights Reserved.
//
// You may incorporate this Apple sample code into your own code
// without restriction. This Apple sample code has been provided "AS IS"


// and the responsibility for its operation is yours. You may redistribute
// this code, but you are not permitted to redistribute it as
// "Apple sample code" after having made changes.

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ContactServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request,
                       HttpServletResponse response)
        throws IOException, ServletException
    {
        PrintWriter writer = response.getWriter();


        response.setContentType("text/html");
        writer.println("<html><head><title>Mail Example</title></head>");
        writer.println("<body bgcolor=\"white\">");


        writer.println("<h1>Message received</h1>");

        ///////// set this variable to be your SMTP host
        String mailHost = "smtp.gmail.com";
        int port = 587;
        String username = "peak.website@gmail.com";
        String password = "peaky...";

        ///////// set this variable to be your desired email recipient
        String to = "lmrodriguezr@gmail.com";

        // these variables come from the mail form

        String from = request.getParameter("email");
        String subject = "[Peak] " + request.getParameter("name");
        String body = request.getParameter("message") + "\n\n----\n" + from;

        Properties props = new Properties();
    	props.put("mail.smtp.auth", "true");
    	props.put("mail.smtp.starttls.enable", "true");
 
    	if(1==1){
        try {

        	Session session = Session.getInstance(props);

        	Message message = new MimeMessage(session);
    	    message.setFrom(new InternetAddress(from));
    	    message.setRecipients(Message.RecipientType.TO, 
                            InternetAddress.parse(to));
    	    message.setSubject(subject);
    	    message.setText(body);
     
    	    Transport transport = session.getTransport("smtp");
    	    transport.connect(mailHost, port, username, password);
     
    	    transport.sendMessage(message, message.getAllRecipients());
     
    	    System.out.println("Done");

            // it worked!
            writer.println("<b>Thank you.  Your message was successfully sent.</b>");



        } catch (Throwable t) {

            writer.println("<b>Unable to send message: <br><pre>");
            t.printStackTrace(writer);
            writer.println("</pre></b>");


        }


        }
        else
        {
            // no mail to send. print a blank mail form
            writer.println("<form action=\"/mine/mail\" method=\"POST\">");


            writer.println("<table border=\"0\">");
            writer.println("<tr><td>Message From: </td><td><input type=\"text\" name=\"from\"></td></tr>");


            writer.println("<tr><td>Subject: </td><td><input type=\"text\" name=\"subject\"></td></tr>");
            writer.println("<tr><td valign=\"top\">Message: </td><td><textarea name=\"body\" rows=\"10\" cols\"40\"></textarea></td></tr>");


            writer.println("<tr><td colspan=\"2\" align=\"center\"><input type=\"submit\" value=\"Send\"></td></tr>");
            writer.println("</table>");


            writer.println("</form>");
        }


        writer.println("</body>");
        writer.println("</html>");        

    }
}