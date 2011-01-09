package taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

public class MapTag extends TagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String userLogin;
	protected String country;
	protected String city;
	protected String ascent;

	@SuppressWarnings("unchecked")
	public int doStartTag() throws JspException {
		String actions = "";
		try {
			Integer mapId = (int) (Math.random()*1000);
			String req = "{ format: \"json-complete\"";
			String zoom ="2";
			if(userLogin!=null) {
				req += ", user: \""+userLogin+"\"";
				zoom = "3";
			}
			if(getCountry()!=null) {
				req += ", country: \""+getCountry()+"\"";
				zoom = "5";
			}
			if(getCity()!=null) {
				req += ", city: \""+getCity()+"\"";
				zoom = "8";
			}
			if(getAscent()!=null) {
				req += ", ascent: \""+getAscent()+"\"";
				zoom = "12";
			}
			req += " }";
			
			pageContext.getOut().print(
					"<script type=\"text/javascript\" src=\"http://maps.google.com/maps/api/js?sensor=false\"></script>\n" + 
					"<script>\n" + 
					"var mountains_no = 0;\n" + 
					"var mountains = new Array();\n" + 
					"var mountains_loc = new Array();\n" + 
					"var mountains_loc_no = 0;\n" + 
					"var markers = new Array();\n" + 
					"var listeners = new Array();\n" + // To prevent garbage-collection of markers 
					"var map;\n" + 
					"var infowindow;\n" + 
					"var tmp;\n" + 
					"function attachInfoWindow(marker, i){\n" + 
						"google.maps.event.addListener(marker, 'click', function(e) {\n" + 
							"if(infowindow) infowindow.close();\n" + 
							"var content = \"<div style='font-size:90%;'>\"+\n" + 
									"\"<b>Mountain</b>: \" + mountains[i].nom + \"<br/>\" +\n" + 
									"\"<b>City</b>: \"+mountains[i].ville + \", \" + mountains[i].pays.nom + \"</div>\";\n" + 
							"infowindow = new google.maps.InfoWindow({\n" + 
								"position: markers[i].getPosition(),\n" + 
								"map: map,\n" + 
								"content: content\n" + 
							"});\n" + 
							"infowindow.open(map, markers[i]);\n" + 
						"});\n" + 
					"}\n" + 
					"\n" + 
					"$(function(){\n" + 
						"$.getJSON(\n" + 
							"\"MountainsServlet\",\n" + 
							req + ",\n" + 
							"function(data){\n" + 
								"mountains_no = data.items.length;\n" + 
								"mountains = data.items;\n" + 
								"if(mountains_no == 0){\n" + 
									"$('#map-canvas-"+mapId+"').html('Oops, no mountains to display');\n" + 
									"$('#map-canvas-"+mapId+"').css('height', '2em');\n" + 
								"}else $.each(data.items, function(i, item){\n" + 
									"var geocoder = new google.maps.Geocoder();\n" + 
									"var address = item.nom+\", \"+item.ville+\", \"+item.pays.nom;\n" + 
									"if (geocoder) {\n" + 
										"geocoder.geocode({ 'address': address }, function (results, status) {\n" + 
											"mountains_loc_no++;\n" + 
											"if (status == google.maps.GeocoderStatus.OK) {\n" + 
												"mountains_loc.push(results[0].geometry);\n" + 
												"if(mountains_no == mountains_loc_no){ // Could differ from mountains_loc.length\n" + 
													"var latlng = new google.maps.LatLng(\n" + 
														"mountains_loc[0].location.xa,\n" + 
														"mountains_loc[0].location.za\n" + 
													");\n" + 
													"var myOpts = {" + 
														"zoom: "+zoom+"," +
														"minZoom: 2," + 
														"center: latlng," + 
														"mapTypeId: google.maps.MapTypeId.HYBRID" + 
													"};\n" + 
													"map = new google.maps.Map(document.getElementById(\"map-canvas-"+mapId+"\"), myOpts);\n" + 
													"for ( i in mountains_loc ){\n" + 
														"var coord = new google.maps.LatLng(\n" + 
																"mountains_loc[i].location.xa,\n" + 
																"mountains_loc[i].location.za\n" + 
														");\n" + 
														"marker = new google.maps.Marker({" + 
															"position: coord," + 
															"map: map," + 
															"title: mountains[i].nom" + 
														"});\n" + 
														"markers[i] = marker;\n" + 
														"attachInfoWindow(marker, i);\n" + 
													"}\n" + 
												"}\n" + 
											"}\n" + 
										"});\n" + 
									"}\n" + 
								"});\n" + 
							"}\n" + 
						");\n" + 
					"});\n" + 
					"</script>\n" + 
					"<div id='map-canvas-"+mapId+"' style=\"width:70%;margin:0 15%;height:25em;border:2px solid black;\">\n" + 
						"Loading map...\n" + 
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
	public void setCountry(String country){
		this.country = country;
	}
	public String getCountry(){
		return country;
	}
	public void setCity(String city){
		this.city = city;
	}
	public String getCity(){
		return city;
	}
	public void setUserLogin(String userLogin){
		this.userLogin = userLogin;
	}
	public String getUserLogin(){
		return userLogin;
	}
	public void setAscent(String ascent){
		this.ascent = ascent;
	}
	public void setAscent(Integer ascent){
		this.ascent = ascent.toString();
	}
	public String getAscent(){
		return ascent;
	}
}
