<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.io.*"%>
<%@ taglib uri="/WEB-INF/peak.tld" prefix="peak"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="inc/libs.jsp"%>
<title>Peak - Setup</title>
</head>
<body>
<div id='header'>
<h1><a href='peaks.jsp'>Peak</a></h1>
<h2>The climbers web site</h2>
</div>
<div id='climber-top'>&nbsp;</div>
<%
	String e = "";
	Object err = request.getSession().getAttribute("error");
	if (err != null) {
		e = "<script>\n"
				+ "setTimeout(function () { $('#ErrId').fadeOut('slow'); }, 1000*12);\n"
				+ "</script><div class='error' id='ErrId'><h1>Error</h1>"
				+ err + "</div>";
		request.getSession().removeAttribute("error");
	}
%>
<div id='user_box'>&nbsp;</div>
<%=e%>
<table id='wrapper'>
	<tr>
		<td id='content'><script>
		function help_with_mysql(){
			var cf = $("<div>");
			cf.html("<p style='text-align:left'>" +
				"<span class='ui-icon ui-icon-info' style='float:left; margin:0 7px 20px 0;'></span>"+
				"First, you must have a MySQL server running.  If you do not have one, please go to " +
				"the <a href='http://www.mysql.com/downloads/mysql/' target='_blank'>MySQL Server site</a>." +
				"</p><p style='text-align:left'>" +
				"Once you have your server up and running, you have to create a user.  To do so, just " +
				"go to your mysql client terminal and type " +
				"(changing <code>secretPassword</code> by your own secret password):"+
				"<pre>CREATE USER 'peakrunner'@'localhost' IDENTIFIED BY 'secretPassword';</pre> " +
				"</p><p style='text-align:left'>" +
				"Now, you must create the database and grant privileges to the user you just created:" +
				"<pre>CREATE DATABASE 'peak';\nGRANT ALL ON 'peak'.* TO 'peakrunner'@'localhost';</pre>" +
				"</p><p style='text-align:left'>" +
				"Remember, the code above creates the user <code>peakrunner</code> and the database "+
				"<code>peak</code> on the server <code>localhost</code>.  You can change these values "+
				" for any values you prefer. " +
				"And that's it!" +
				"</p>");
			cf.attr('title', 'Delete ascent?');
			cf.dialog({
				modal: true,
				width: 700,
			});
		}
		</script>
		<h3>Welcome to Peak!</h3>
		<p style='margin: 0 5em; text-align: left;'>All you need to do for
		setting up Peak in your server is to fill the amazingly short
		following form. The fully automated set up process of Peak will do the
		rest for you. Please, remember that the MySQL user should be able to
		access and modify the database. <a class="anchor_button"
			href="javascript:void(0)" onclick="help_with_mysql()">Help&nbsp;with&nbsp;MySQL</a></p>
		<p style='margin: 0 7em; text-align: right;'>Enjoy!,<br />
		The Peak team</p>
		<form action="InstallServlet" method="post">
		<h2>Server data</h2>
		<label>MySQL server:<br />
		<input type="text" name="mysql_server" value="localhost" /></label><br />
		<br />
		<label>MySQL database:<br />
		<input type="text" name="mysql_database" value="peak" /></label><br />
		<br />
		<label>MySQL user:<br />
		<input type="text" name="mysql_user" value="peakrunner" /></label><br />
		<br />
		<label>MySQL password:<br />
		<input type="password" name="mysql_passwd" /></label><br />
		<br />
		<input type="submit" value="Submit" /></form>
		</td>
	</tr>
</table>
<div id='climber-bottom'>&nbsp;</div>
<div id='footer'>&copy; 2010-2011 Nadia Znassi &amp; Luis M.
Rodriguez-R</div>
</body>
</html>
