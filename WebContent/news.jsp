<%@ include file="inc/header.jsp" %>

<script src="https://www.google.com/jsapi?key=ABQIAAAALtFTgG8ih0k11ThyyCofphQ2BgO7Te7B7zZ3pz5lK2R7hi1TrhQPa5lAtFxAsR8OtiUL5zGKBA8uAw"></script>
<script>
google.load('search','1');

var newsSearch;

function gNewsSearchComplete() {
	o = $('#news-box');
	o.css('text-align','left');
	o.css('margin','2em 4em 0 4em');
	
	if(newsSearch.results && newsSearch.results.length > 0){
		o.html('<dl>');
		for(var i=0; i<newsSearch.results.length; i++){
			dt = $('<dt style="margin-top:1em;">').append($('<a>').attr('href', newsSearch.results[i].unescapedUrl).html(newsSearch.results[i].title));
			dd = $('<dd style="border-bottom:1px solid #666">').append(newsSearch.results[i].content);
			dd.append('<div style="text-align:right;color:#666">'+newsSearch.results[i].publisher+'</div>');
			o.append(dt);
			o.append(dd);
		}
	}else{
		o.html('Oops, no news to display.');
	}
}

function gNewsOnLoad() {
	newsSearch = new google.search.NewsSearch();
	newsSearch.setSearchCompleteCallback(newsSearch, gNewsSearchComplete, null);
	newsSearch.execute('Climbing or mountaineering');
	$('#news-branding').append(google.search.Search.getBranding());
}

google.setOnLoadCallback(gNewsOnLoad);

</script>

<div id='news-box'>Loading news...</div>
<div id='news-branding'>&nbsp;</div>

<%@ include file="inc/footer.jsp" %>