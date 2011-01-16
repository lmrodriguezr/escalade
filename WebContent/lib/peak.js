
function deleteAscent(idAscent){
	if(!idAscent) return;
	var cf = $("<div>");
	cf.html("<p style='text-align:left'><span class='ui-icon ui-icon-alert' style='float:left; margin:0 7px 20px 0;'></span>The ascent will be permanently deleted.  Are you sure?</p>");
	cf.attr('title', 'Delete ascent?');
	cf.dialog({
			modal: true,
			width: 350,
			buttons: {
				"Delete ascent": function() {
					$.get('DeleteAscentServlet', {id:idAscent}, function(){
						//$(location).attr('href',"userAscents.jsp");
						location.reload();
					});
					$( this ).dialog( "close" );
				},
				Cancel: function() {
					$( this ).dialog( "close" );
				}
			}
	});
}