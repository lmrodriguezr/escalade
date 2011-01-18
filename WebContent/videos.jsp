<%@ include file="inc/header.jsp" %>

<script src="https://www.google.com/jsapi?key=ABQIAAAALtFTgG8ih0k11ThyyCofphQ2BgO7Te7B7zZ3pz5lK2R7hi1TrhQPa5lAtFxAsR8OtiUL5zGKBA8uAw"></script>
<script>
google.load('search','1');

function gVideosOnLoad() {
	// Create a search control
  var searchControl = new google.search.SearchControl();

  // So the results are expanded by default
  options = new google.search.SearcherOptions();
  options.setExpandMode(google.search.SearchControl.EXPAND_MODE_OPEN);

  // Create a video searcher
  var videoSearch = new google.search.VideoSearch();

  // Set the result order of the search - check docs for other orders
  videoSearch.setResultOrder(google.search.Search.ORDER_BY_DATE);

  // Add our searcher to the control
  searchControl.addSearcher(videoSearch, options);

  // Draw the control onto the page
  searchControl.draw(document.getElementById("content"));

  // Because laughing is healthy.
  searchControl.execute("Climbing or mountaineering");
}

google.setOnLoadCallback(gVideosOnLoad);

</script>

<div id='videos-box'>Loading videos...</div>

<%@ include file="inc/footer.jsp" %>