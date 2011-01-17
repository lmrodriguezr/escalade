<%@ include file="inc/header.jsp" %>




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