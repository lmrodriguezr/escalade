<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="inc/header.jsp"/>
<%@ include file="inc/requireUser.jsp"%>

<h1>Register Ascent</h1>
<form method='post' action='CreateAscentServlet'>

<h2>Your experience</h2>
<label>Date*<br />
<input type='text' name='date' class='datepicker' /></label><br />
<br />

Rate*:<br/>
<div class='starsrating'></div>
<br/><br/>

<label>Comments<br />
<textarea cols='50' rows='4' name='comment'></textarea></label><br />
<br />

<h2>The place</h2>
<script>
$(function(){
	$('#country-selector').autocomplete({
				source:'CountriesServlet?format=json',
				minLength:0,
				close: function(event,ui){ $('#country-selector').change() }
	});
	$('#country-selector').change(function(){
		$('#city-selector').val("");
		if($('#country-selector').val()){
			$('#city-selector').attr('readonly', false);
			$('#city-selector').autocomplete({
				source:'CitiesServlet?format=json&country='+$('#country-selector').val(),
				minLength:0,
				close: function(event,ui){ $('#city-selector').change() }
			});
		}else{
			$('#city-selector').attr('readonly', true);
		}
	});
	$('#city-selector').change(function(){
		$('#mountain-selector').val("");
		if($('#city-selector').val()){
			$('#mountain-selector').autocomplete({
				source:'MountainsServlet?format=json&country='+$('#country-selector').val() +
					"&city=" + $('#city-selector').val(),
				minLength:0,
				close: function(event,ui){ $('#mountain-selector').change() }
			});
		}
	});
	$('#mountain-selector').change(function(){
		$('#sector-selector').val("");
		if($('#mountain-selector').val()){
			$('#sector-selector').autocomplete({
				source:'SectorsServlet?format=json&mountain='+$('#mountain-selector').val() +
					"&country=" + $('#country-selector').val() +
					"&city=" + $('#city-selector').val(),
				minLength:0,
				close: function(event,ui){ $('#sector-selector').change() }
			});
		}
	});
	$('#sector-selector').change(function(){
		$('#approach-selector').val("");
		if($('#sector-selector').val()){
			$('#approach-selector').autocomplete({
				source:'ApproachesServlet?format=json&sector='+$('#sector-selector').val() +
					"&country=" + $('#country-selector').val() +
					"&city=" + $('#city-selector').val() +
					"&mountain=" + $('#mountain-selector').val(),
				minLength:0
			});
		}
	});
});
</script>
<label>Country*:<br/>
<input type='text' name='pays' id='country-selector' /></label><br/><br/>

<label>City*:<br/>
<input type='text' name='ville' id='city-selector' /></label><br/><br/>

<label>Mountain*:<br/>
<input type='text' name='falaise' id='mountain-selector' /></label><br/><br/>

<label>Sector*:<br/>
<input type='text' name='secteur' id='sector-selector' /></label><br/><br/>

<label>Approach*:<br/>
<input type='text' name='voie' id='approach-selector' /></label><br/><br/>

<h2>Difficulty</h2>
<script>
function setDifficulty() {
	$( "#difficulty" ).html(
		$( "#degree-value" ).val() +
		$( "#letter-selector" ).val() +
		$( "#grade-selector" ).val()
	);
}
$(function(){
	$('#degree-selector').slider({
		value: 3,
		min: 1,
		max: 7,
		slide: function( event, ui ) {
				$( "#degree-value" ).val( ui.value );
				setDifficulty();
		}
	});
	$( "#difficulty" ).val( "no" );
 	$( "#letter-selector" ).change(function() {setDifficulty();});
 	$( "#grade-selector" ).change(function() {setDifficulty();});
});
</script>
Category: <b id='difficulty'>3A</b><br/><br/>

<div id='degree-selector' style='width:30%; margin:0 35%'></div>
<input type='hidden' name='degree' id='degree-value' value='3' /><br/>

<select name='letter' id='letter-selector'>
	<option value='A' selected="selected">A</option>
	<option value='B'>B</option>
	<option value='C'>C</option>
</select>

<select name='grade' id='grade-selector'>
	<option value='+'>+</option>
	<option value='' selected="selected"> </option>
	<option value='-'>-</option>
</select><br/>
<br/><br/>
<input type='submit' value='Register' />
</form>
<jsp:include page="inc/footer.jsp"/>