<%@ include file="inc/header.jsp" %>

<script type="text/javascript">
$(function () {

  // Chercher les elements a etirer
  $('div.jimgMenu ul li.jimginto a').hover(function() {
    // Si l'element est anime
    if ($(this).is(':animated')) {
      $(this).stop().animate({width: "15em"}, {duration: 450, easing:"easeOutQuad"});
    } else {
      // l'etirer vite
      $(this).stop().animate({width: "15em"}, {duration: 400, easing:"easeOutQuad"});
    }
  }, function () {
    // le ramener
    if ($(this).is(':animated')) {
      $(this).stop().animate({width: "4em"}, {duration: 400, easing:"easeInOutQuad"})
    } else {
      // le ramener doucement
      $(this).stop('animated:').animate({width: "4em"}, {duration: 450, easing:"easeInOutQuad"});
    }
  });
  $('div.jimgMenu ul li.forum a').animate({width: "22em"}, {duration: 450, easing:"easeInOutQuad"});
});
</script>

<div class="jimgMenu">
	<ul>
		<li class="jimginto home"><a href="peaks.jsp">Home</a></li>
		<li class="jimginto news"><a href="news.jsp">News</a></li>
		<li class="jimginto events"><a href="events.jsp">Events Calendar</a></li>
		<li class="jimginto members"><a href="users.jsp">Members</a></li>
		<li class="jimginto photo"><a href="Photo.html">Photo Gallery</a></li>
		<li class="jimginto video"><a href="videos.jsp">Video Gallery</a></li>
		<li class="jimginto weather"><a href="weather.jsps">Weather</a></li>
		<li class="forum"><a href="Forum.html">Forum</a></li>
	</ul>
</div>

<h2>Registered mountains</h2>
<peak:map/>

<h2>Recent users</h2>
<peak:users/>

<h2>Recent ascents</h2>
<peak:ascents/>
<br><br><br><br><br><br>

<div>
<script type="text/javascript" src="http://widgets.amung.us/map.js"></script><script type="text/javascript">WAU_map('kebed80no3ix', 420, 210, 'neosat', 'target-blue')</script>
</div>

<div>
<script type="text/javascript">
  addthis_url    = location.href;   
  addthis_title  = document.title;  
  addthis_pub    = 'digitalalchemy';     
</script><script type="text/javascript" src="http://s7.addthis.com/js/addthis_widget.php?v=12" ></script>
</div>


<jsp:include page="inc/footer.jsp" />