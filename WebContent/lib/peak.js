
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

//function for contact form dropdown
function contact() {
	if ($("#contactForm").is(":hidden")){
		$("#contactForm").slideDown("slow");
		$("#backgroundPopup").css({"opacity": "0.7"});
		$("#backgroundPopup").fadeIn("slow"); 
	}
	else{
		$("#contactForm").slideUp("slow");
		$("#backgroundPopup").fadeOut("slow");  
	}
}
$(function() {
	//run contact form when any contact link is clicked
	$(".contact").click(function(){contact()});
	//submission scripts
  	$('.contactForm').submit( function(){
		//statements to validate the form	
		var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
		var email = document.getElementById('e-mail');
		if (!filter.test(email.value)) {
			$('.email-missing').show();
		} else {$('.email-missing').hide();}
		if (document.cform.name.value == "") {
			$('.name-missing').show();
		} else {$('.name-missing').hide();}	
		if (document.cform.message.value == "") {
			$('.message-missing').show();
		} else {$('.message-missing').hide();}		
		if ((document.cform.name.value == "") || (!filter.test(email.value)) || (document.cform.message.value == "")){
			return false;
		} 
		
		if ((document.cform.name.value != "") && (filter.test(email.value)) && (document.cform.message.value != "")) {
			//hide the form
			$('.contactForm').hide();
		
			//show the loading bar
			$('.loader').append($('.bar'));
			$('.bar').css({display:'block'});
		
			//send the ajax request
			$.post('ContactServlet',{name:$('#name').val(),
							  email:$('#e-mail').val(),
							  message:$('#message').val()},
		
			//return the data
			function(data){
			  //hide the graphic
			  $('.bar').css({display:'none'});
			  $('.loader').append(data);
			});
			
			//waits 2000, then closes the form and fades out
			setTimeout('$("#backgroundPopup").fadeOut("slow"); $("#contactForm").slideUp("slow")', 2000);
			
			//stay on the page
			return false;
		} 
 	});
});