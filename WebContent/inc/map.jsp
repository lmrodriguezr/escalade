<%
	String userMapRq = request.getParameter("user");
	String country = request.getParameter("country");
	String city = request.getParameter("city");
	String mapReqData = "{ format: \"json-complete\"";
	if(userMapRq!=null) mapReqData += ", user: \""+userMapRq+"\"";
	if(country!=null) mapReqData += ", country: \""+country+"\"";
	if(city!=null) mapReqData += ", city: \""+city+"\"";
	mapReqData += " }";
%>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script>
var mountains_no = 0;
var mountains = new Array();
var mountains_loc = new Array();
var mountains_loc_no = 0;
var markers = new Array();
var listeners = new Array(); // To prevent garbage-collection of markers
var map;
var infowindow;
var tmp;
function attachInfoWindow(marker, i){
	google.maps.event.addListener(marker, 'click', function(e) {
		if(infowindow) infowindow.close();
		var content = "<div style='font-size:90%;'>"+
				"<b>Mountain</b>: " + mountains[i].nom + "<br/>" +
				"<b>City</b>: "+mountains[i].ville + ", " + mountains[i].pays.nom + "</div>";
				
		infowindow = new google.maps.InfoWindow({
				position: markers[i].getPosition(),
				map: map,
			content: content
		});
		infowindow.open(map, markers[i]);
	});
}

$(function(){
	$.getJSON(
		"MountainsServlet",
		<%= mapReqData %>,
		function(data){
			mountains_no = data.items.length;
			mountains = data.items;
			$.each(data.items, function(i, item){
				var geocoder = new google.maps.Geocoder();
				var address = item.nom+", "+item.ville+", "+item.pays.nom;
				if (geocoder) {
					geocoder.geocode({ 'address': address }, function (results, status) {
						mountains_loc_no++;
						if (status == google.maps.GeocoderStatus.OK) {
							mountains_loc.push(results[0].geometry);
							if(mountains_no == mountains_loc_no){ // Could differ from mountains_loc.length
								var latlng = new google.maps.LatLng(
									mountains_loc[0].location.xa,
									mountains_loc[0].location.za
								);
								var myOpts = {
									zoom: 2,
									minZoom: 2,
									center: latlng,
									mapTypeId: google.maps.MapTypeId.HYBRID
								};
								map = new google.maps.Map(document.getElementById("map-canvas"), myOpts);
								for ( i in mountains_loc ){
									var coord = new google.maps.LatLng(
											mountains_loc[i].location.xa,
											mountains_loc[i].location.za
									);
									marker = new google.maps.Marker({
										position: coord,
										map: map,
										title: mountains[i].nom
									});
									markers[i] = marker;
									attachInfoWindow(marker, i);
								}
							}
						}
					});
				}
			});
		}
	);
});
</script>
<div id='map-canvas' style="width:70%;margin:0 15%;height:25em;border:2px solid black;">
		Loading map...
</div>