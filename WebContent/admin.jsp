<%@ include file="inc/header.jsp"  %>

<script>
	var skt;
	function adminDeleteUser(uid){
		$("#admin-delete-user input#uid-u").val(uid);
		$("#admin-delete-user input:last").val(skt);
		$("#admin-delete-user").submit();
    	/*
		$.post(
			'DeleteUserServlet',
			{uid:uid, code:skt},
			function(data){
				alert(data);
			}
		);*/
	}
	$(function(){
		var box = $("<div>");
		box.html("<p>Please provide the application's secret code:</p><input type='password' id='skt_in' />");
		box.attr('title', 'Secret code');
		box.dialog({
			modal: true,
			width: 350,
			buttons: {
				Confirm: function() {
					skt = $('#skt_in').val();
					$.getJSON('UsersServlet', {format:"json-complete"}, function(data){
						if(data.items && data.items.length > 0){
							for(i in data.items){
								var i = '<img title="delete" alt="delete" src="lib/img/cancel-on.png" ' +
								 	'onclick="adminDeleteUser('+data.items[i].id+')" ' +
									'style="cursor:pointer" /> | <b>' + data.items[i].login + ':</b> ' +
									data.items[i].prenom + ' ' + data.items[i].nom+' (<a '+
									'href="userPage.jsp?user='+data.items[i].login+'">profile</a>)';
								var p = $('<p style="background:#eee;text-align:left;width:90%;margin:1em 5%;border:1px solid #666;padding:0.6em">').html(i);
								$('#users-admin-box').append(p);
							}
							form = $("<form method='post' action='DeleteUserServlet' id='admin-delete-user'>"+
										"<input type='hidden' name='uid' value='' id='uid-u'/>"+
										"<input type='hidden' name='code' value=''/></form>");
							$('#users-admin-box').append(form);
						}
					});
					$( this ).dialog( "close" );
				},
				Cancel: function() {
					location.href = '.';
				}
			}
		});
	});
</script>

<div id='users-admin-box'></div>

<%@ include file="inc/footer.jsp" %>