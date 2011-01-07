<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="inc/header.jsp"/>
<%@ include file="inc/requireUser.jsp"%>

<h1>Register Ascent</h1>
<form method='post' action='NewAscentServlet'>

<h2>Your experience</h2>
<label>Date*<br />
<input type='text' name='date' class='datepicker' value='' /></label><br />
<br />

Rate*:<br/>
<div class='starsrating'></div>
<br/><br/>

<label>Comments<br />
<textarea cols='50' rows='4'></textarea></label><br />
<br />

<h2>The place</h2>
<script>
$(function(){
	$('#country-selector').autocomplete({source:'CountriesJsonServlet'});
	$('#country-selector').change(function(){
		if($('#country-selector').val()){
			$('#city-selector').attr('readonly', false);
			$('#city-selector').autocomplete({
				source:'CitiesJsonServlet?country='+$('#country-selector').val()
			});
		}else{
			$('#city-selector').attr('readonly', true);
		}
	});
	$('#city-selector').change(function(){
		if($('#city-selector').val()){
			$('#mountain-selector').attr('readonly', false);
			$('#mountain-selector').autocomplete({
				source:'MountainsJsonServlet?country='+$('#country-selector').val() +
					"&city=" + $('#city-selector').val()
			});
		}else{
			$('#mountain-selector').attr('readonly', true);
		}
	});
	$('#mountain-selector').change(function(){
		if($('#mountain-selector').val()){
			$('#sector-selector').attr('readonly', false);
			$('#sector-selector').autocomplete({
				source:'SectorsJsonServlet?mountain='+$('#mountain-selector').val() +
					"&country=" + $('#country-selector').val() +
					"&city=" + $('#city-selector').val()
			});
		}else{
			$('#sector-selector').attr('readonly', true);
		}
	});
	$('#sector-selector').change(function(){
		if($('#sector-selector').val()){
			$('#path-selector').attr('readonly', false);
			$('#path-selector').autocomplete({
				source:'PathsJsonServlet?sector='+$('#sector-selector').val() +
					"&country=" + $('#country-selector').val() +
					"&city=" + $('#city-selector').val() +
					"&mountain=" + $('#mountain-selector').val()
			});
		}else{
			$('#path-selector').attr('readonly', true);
		}
	});
});
</script>
<label>Country:<br/>
<input type='text' name='pays' id='country-selector' /></label><br/><br/>

<label>City:<br/>
<input type='text' name='pays' id='city-selector' readonly="readonly" /></label><br/><br/>

<label>Mountain:<br/>
<input type='text' name='falaise' id='mountain-selector' readonly="readonly" /></label><br/><br/>

<label>Sector:<br/>
<input type='text' name='secteur' id='sector-selector' readonly="readonly" /></label><br/><br/>

<label>Path:<br/>
<input type='text' name='voie' id='path-selector' readonly="readonly" /></label><br/><br/>

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

</form>
<jsp:include page="inc/footer.jsp"/>