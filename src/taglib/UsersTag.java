package taglib;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.TagSupport;

public class UsersTag extends TagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String userLogin;
	protected String asUserLogin;
	protected int limit;

	@Override
	@SuppressWarnings("unchecked")
	public int doStartTag() throws JspException {
		try {
			Integer uId = (int) (Math.random()*10000);
			String req = "{ format: \"json-complete\"";
			if(userLogin!=null) req += ", user: \""+userLogin+"\"";
			if(limit!=0) req += ", limit: " + limit;
			req += " }";
			Boolean granted = (userLogin!=null && asUserLogin!=null && userLogin==asUserLogin);
			
			pageContext.getOut().print(
					"<script>\n" + 
					"$(function(){" + 
						"$.getJSON(" + 
							"\"UsersServlet\"," + 
							req + "," + 
							"function(data){" + 
								"if((!data.items) || data.items == 0){" + 
									"$('#user-"+uId+"').html('Oops, no users to display');" + 
								"}else{" +
									"$('#user-"+uId+"').html('');" +
									"$.each(data.items, function(i, item){" +
										"uBox = $('<div>');" +
										"uBox.attr('class', 'uBox');" +
										"uBox.append('<h3>'+item.prenom+' '+item.nom+'</h3>');" +
										"uBody = $('<div>');" +
										(granted ? 
												"uBox.append('<div class=\"subtext\">[<a href=\"settings.jsp\">Edit profile</a>]</div>');"
												: "") +
										"uBody.html('" +
												"<span>Age</span>: '+item.age+' years " +
												"<span>Weight:</span> '+item.poids+' kg " +
												"<span>Height:</span> '+item.taille+' cm " +
												"<span>Activity:</span> <a href=\"userAscents.jsp?user='+item.login+'\">'+item.ascensions+' ascents</a>" +
												" in <a href=\"userMap.jsp?user='+item.login+'\">'+item.falaises+' mountains</a>.');" +
										"uBox.append(uBody);" +
										"$('#user-"+uId+"').append(uBox)" +
									"})" +
								"}" +
							"}" +
						");" + 
					"});\n" + 
					"</script>\n" + 
					"<div id='user-"+uId+"' style=\"width:90%;margin:0 5%;boder: 2px solid black;\">" + 
						"Loading users..." + 
					"</div>\n"
			);
		} catch (Exception e) {
			throw new JspTagException("AscentsTag: " + e.getMessage());
		}
		return SKIP_BODY;
	}
	// Getters / Setters
	public void setUserLogin(String userLogin){
		this.userLogin = userLogin;
	}
	public String getUserLogin(){
		return userLogin;
	}
	public void setAsUserLogin(String asUserLogin){
		this.asUserLogin = asUserLogin;
	}
	public String getAsUserLogin(){
		return asUserLogin;
	}
	public void setLimit(int limit){
		this.limit = limit;
	}
	public void setLimit(String limit){
		this.limit = Integer.parseInt(limit);
	}
	public int getLimit(){
		return limit;
	}
}
