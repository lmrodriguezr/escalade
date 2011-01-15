package taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class AscentsTag extends TagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String userLogin;

	@Override
	@SuppressWarnings("unchecked")
	public int doStartTag() throws JspException {
		String actions = "";
		try {
			Integer tabId = (int) (Math.random()*1000);
			String req = "format=json-table";
			if(userLogin!=null) req += "&user="+userLogin;
			
			pageContext.getOut().print(
				"<script>\n"+
					"$(function(){\n"+
						"$('#ascents-"+tabId+"').flexigrid({\n"+
							"url: 'AscentsServlet?"+req+"',\n"+
							"dataType: 'json',\n"+
							"method:'get',\n"+
							"colModel: [\n"+
								"{display: 'Date', name: 'date', width: '55', sortable: 'false', align: 'center'},\n"+
								"{display: 'Level', name: 'level', width: '30', sortable: 'false', align: 'center'},\n"+
								"{display: 'Country', name: 'country', width: '70', sortable: 'false', align: 'center'},\n"+
								"{display: 'City', name: 'city', width: '70', sortable: 'false', align: 'center'},\n"+
								"{display: 'Mountain', name: 'mountain', width: '70', sortable: 'false', align: 'center'},\n"+
								"{display: 'Sector', name: 'sector', width: '80', sortable: 'false', align: 'center'},\n"+
								"{display: 'Approach', name: 'approach', width: '80', sortable: 'false', align: 'center'},\n"+
								"{display: 'User', name: 'user', width: '60', sortable: 'false', align: 'center'},\n"+
								"{display: 'Comments', name: 'comments', width: '110', sortable: 'false', align: 'left'},\n"+
								"{display: '&nbsp;', name: 'actions', width: '40', sortable: 'false', align:'left'}\n"+
							"],\n"+
							"title: 'Recent ascents',\n"+
							"height:'auto',\n"+
							"weight: 'auto',\n"+
							"showTableToggleBtn: true,\n"+
						"});\n"+
					"});\n"+
				"</script>\n"+
				"<div style='width:94%; margin: 0 3%'>\n"+
					"<table id=\"ascents-"+tabId+"\" style=\"display:none\"></table>\n"+
				"</div>\n"
			);
			
			// Public actions
			// ToDo: show map
			pageContext.getOut().print(actions);
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
}
