<%@ page pageEncoding="UTF-8" %>
<%@ include file="inc/header.jsp" %>

<script language="javascript" type="text/javascript">

function paysspotajax(f, l1, l2, what)
{
var index = l1.selectedIndex;
if(index < 1)
{
   l2.options.length = 0;
}
else {
   var xhr_object = null;

   if(window.XMLHttpRequest) // Firefox
      xhr_object = new XMLHttpRequest();
   else if(window.ActiveXObject) // Internet Explorer
      xhr_object = new ActiveXObject("Microsoft.XMLHTTP");
   else { // XMLHttpRequest non support� par le navigateur
      alert("Votre navigateur ne supporte pas les objets XMLHTTPRequest...");
      return;
   }

   xhr_object.open("POST", "http://www.allosurf.net/ajax/species.php", true);

   xhr_object.onreadystatechange = function() {
      if(xhr_object.readyState == 4)
	  {
        eval(xhr_object.responseText);
		document.getElementById('generalbody').style.cursor="default";
		l1.style.cursor="default";
		l2.style.cursor="default";
	  }
   }
   document.getElementById('generalbody').style.cursor="wait";
   l1.style.cursor="wait";
   l2.style.cursor="wait";
   
   xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
   var data = "what="+what+"&family="+escape(l1.options[index].value.substring(0,6))+"&form="+f.name+"&select="+l2.id;

   xhr_object.send(data);
   //xhr_object = null;
}
}

</script>

<script type="text/javascript">
var coller1 = '<!-- (c) allosurf.net START -->\n';
coller1 = coller1 + '<script type="text/javascript" src="http://www.allosurf.net/extern/mb1js.php?id=';
var coller2 = '">\n';
coller2 = coller2 +'\<\/script\>\n';
coller2 = coller2 + '<!-- (c) allosurf.net END -->';

var coller1b = '<!-- (c) allosurf.net START -->\n';
coller1b = coller1b + '<script type="text/javascript" src="http://www.allosurf.net/extern/mb2js.php?houle=';
var coller2b = '">\n';
coller2b = coller2b +'_<\/script\>\n';
coller2b = coller2b + '<!-- (c) allosurf.net END -->';

var ventunite="nd";
var spotid=1;

function file(fichier)
     {
     if(window.XMLHttpRequest) // FIREFOX
          xhr_object = new XMLHttpRequest();
     else if(window.ActiveXObject) // IE
          xhr_object = new ActiveXObject("Microsoft.XMLHTTP");
     else
          return(false);
     xhr_object.open("GET", fichier, false);
     xhr_object.send(null);
     if(xhr_object.readyState == 4) return(xhr_object.responseText);
     else return(false);
     }

</script>
<h1 style="font-size: 30px; font-weight: bold;">Weather Information</h1>

<div id="tabs">

<div id="tabs-2">

<div id="example" style="margin: auto; width:80%;">

		<div class="shadow" style="border: 1px solid #aaaaaa; padding: 3px;">
			<b>
			This Weather report gives the temperature and the wind speed in different areas in the world.
			<br><br>
            Select your country and your city to check the weather in your location.
            
            <br><br>
            <a href="peaks.jsp">Back Home</a>
			</b>
		</div>

<div class="shadow" style="border: 1px solid #aaaaaa; padding: 3px;">


				    <table width="100%" border="0" cellspacing="2" cellpadding="2">

                      <tr>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td><span style="font-weight: bold">SPOTS MAP</span></td>

                      </tr>
                      
                      <tr>
                        <td>
<form class="CenteredForm" name="form_selects2beach2" id="form_selects2beach2" action="" method="post" onsubmit="return false;">
		            <table width="48%" border="0"  cellspacing="0" cellpadding="0">
                      
                        <tr>
                        
                          <td><select name="spotbeach1" id="spotbeach1"   class="deroulDivers"  onchange="paysspotajax(this.form, document.getElementById('spotbeach1'), document.getElementById('spotbeach2'), 'typespot12externe');">
                              <option value="0">Select a country :</option>

                              <option selected="selected" value="1">France</option>

                              <option  value="247">Afrique du Sud</option>

                              <option  value="77">Algérie</option>
                              							

                              <option  value="10">Allemagne</option>
                              							

                              <option  value="33">Australie</option>
                              							

                              <option  value="37">Barbade</option>

                              							

                              <option  value="48">Brésil</option>
                              							

                              <option  value="54">Canada</option>
                              							

                              <option  value="68">Cap-Vert</option>
                              							

                              <option  value="62">Chili</option>
                              							

                              <option  value="70">Chypre</option>
                              							

                              <option  value="65">Colombie</option>

                              							

                              <option  value="58">Congo</option>
                              							

                              <option  value="66">Costa Rica</option>
                              							

                              <option  value="80">Égypte</option>
                              							

                              <option  value="78">Équateur</option>
                              							

                              <option  value="2">Espagne</option>
                              							

                              <option  value="236">États-Unis</option>

                              							

                              <option  value="96">Ghana</option>
                              							

                              <option  value="103">Grèce</option>
                              							

                              <option  value="101">Guadeloupe</option>
                              							

                              <option  value="117">Inde</option>
                              							

                              <option  value="113">Indonésie</option>
                              							

                              <option  value="114">Irlande</option>

                              							

                              <option  value="115">Israël</option>
                              							

                              <option  value="122">Italie</option>
                              							

                              <option  value="152">Madagascar</option>
                              							

                              <option  value="4">Maroc</option>
                              							

                              <option  value="160">Martinique</option>
                              							

                              <option  value="164">Maurice</option>

                              							

                              <option  value="167">Mexique</option>
                              							

                              <option  value="175">Nicaragua</option>
                              							

                              <option  value="171">Nouvelle-Calédonie</option>
                              							

                              <option  value="181">Nouvelle-Zélande</option>
                              							

                              <option  value="183">Panama</option>
                              							

                              <option  value="176">Pays-Bas</option>

                              							

                              <option  value="185">Polynésie Française</option>
                              							

                              <option  value="194">Portugal</option>
                              							

                              <option  value="76">République Dominicaine</option>
                              							

                              <option  value="198">Réunion</option>
                              							

                              <option  value="92">Royaume-Uni</option>
                              							

                              <option  value="214">Sénégal</option>

                              							

                              <option  value="59">Suisse</option>
                              							

                              <option  value="224">Thaïlande</option>
                              							

                              <option  value="228">Tunisie</option>
                          </select></td>
                        </tr>
                        <tr> 
                         
                          <td><select name="spotbeach2" id="spotbeach2"   class="deroulDivers" onchange="document.getElementById('mb1').src='http://www.allosurf.net/extern/mb1.php?qui=&id='+this.value+'&ventunite='+ventunite;  spotid=this.value;  document.getElementById('textacoller1').value=coller1+this.value+'&ventunite='+ventunite+coller2;  ; document.getElementById('addtogoogle').href='http://www.google.fr/ig/adde?moduleurl=http://www.allosurf.net/extern/gadget.php?id='+this.value; ">
                                                            <option value="">Sélect among the 456 spots</option>

                                                            <option  value="723">05 - Lac de Serre-Ponçon</option>
                                                            <option  value="373">05 - Plan d'eau du Riou</option>
                                                            <option  value="100045">06 - Beaulieu sur Mer (Niven)</option>
                                                            <option  value="1413">06 - Cap 3000</option>
                                                            <option  value="30118">06 - Iles de Lérins</option>
                                                            <option  value="100017">06 - L'annexe</option>

                                                            <option  value="100042">06 - L'Hippodrome</option>
                                                            <option  value="30117">06 - Mandelieu l'Aérospatiale</option>
                                                            <option  value="1062350">06 - Paillon</option>
                                                            <option  value="1430">06 - Palm Beach</option>
                                                            <option  value="1445">06 - Saint-Laurent du Var</option>
                                                            <option  value="584">06 - St Laurent du Var</option>

                                                            <option  value="583">06 - Villefranche sur Mer</option>
                                                            <option  value="1453">11 - Cap Coudalère </option>
                                                            <option  value="30170">11 - Etang de La Palme</option>
                                                            <option  value="768">11 - Etang de Leucate (IKR)</option>
                                                            <option  value="1081">11 - Etang de Mateille</option>
                                                            <option  value="721">11 - Gruissan-Plage</option>

                                                            <option  value="741">11 - Ile des pêcheurs - Leucate</option>
                                                            <option  value="267">11 - La Franqui</option>
                                                            <option  value="1213">11 - La Ganguise</option>
                                                            <option  value="1082">11 - La Nautique</option>
                                                            <option  value="1515">11 - Lac de Jouarres</option>
                                                            <option  value="1314">11 - Le téléski</option>

                                                            <option  value="1452">11 - Vieille Nouvelle</option>
                                                            <option  value="1200">12 - Lac de Pareloup</option>
                                                            <option  value="259">13 - Beauduc</option>
                                                            <option  value="402">13 - Boutofolle</option>
                                                            <option  value="1581">13 - Carro</option>
                                                            <option  value="431">13 - Carteau</option>

                                                            <option  value="396">13 - Colombet</option>
                                                            <option  value="759">13 - Escale Borély</option>
                                                            <option  value="125">13 - Fos sur Mer</option>
                                                            <option  value="1454">13 - La Ciotat</option>
                                                            <option  value="647">13 - La Couronne</option>
                                                            <option  value="154">13 - La Verrerie</option>

                                                            <option  value="1210">13 - Le Jaï</option>
                                                            <option  value="49">13 - Le Prado</option>
                                                            <option  value="183">13 - L'Arquet</option>
                                                            <option  value="644">13 - L'Hermitage</option>
                                                            <option  value="610">13 - Piemanson</option>
                                                            <option  value="30100">13 - Plage du Verdon</option>

                                                            <option  value="461">13 - Plage Napoleon</option>
                                                            <option  value="476">13 - Sausset les Pins</option>
                                                            <option  value="997">14 - Arromanches</option>
                                                            <option  value="552">14 - Asnelles</option>
                                                            <option  value="961">14 - Bénerville</option>
                                                            <option  value="365">14 - Deauville</option>

                                                            <option  value="387">14 - Franceville</option>
                                                            <option  value="30032">14 - Houlgate</option>
                                                            <option  value="429">14 - Langrune-sur-Mer</option>
                                                            <option  value="781">14 - Le Menhir</option>
                                                            <option  value="30190">14 - Ouistreham</option>
                                                            <option  value="100020">14 - Pennedepie</option>

                                                            <option  value="366">14 - Ver-sur-Mer</option>
                                                            <option  value="30105">16 - Mas-Chaban</option>
                                                            <option  value="1062231">17 - Anse du Fourneau</option>
                                                            <option  value="740">17 - Aytré</option>
                                                            <option  value="1216">17 - Aytré</option>
                                                            <option  value="1062232">17 - Banc du Bûcheron</option>

                                                            <option  value="1298">17 - Chassiron</option>
                                                            <option  value="92">17 - Châtelaillon-Plage</option>
                                                            <option  value="211">17 - Chef de Baie</option>
                                                            <option  value="145">17 - Diamon Head</option>
                                                            <option  value="30026">17 - Fouras</option>
                                                            <option  value="100053">17 - Gouillaud</option>

                                                            <option  value="274">17 - Grand Village</option>
                                                            <option  value="1302">17 - Grand-Village</option>
                                                            <option  value="1062233">17 - Grande Jetée</option>
                                                            <option  value="498">17 - Gros Jonc</option>
                                                            <option  value="207">17 - La Couarde</option>
                                                            <option  value="1062230">17 - La Loge</option>

                                                            <option  value="107">17 - La Palmyre</option>
                                                            <option  value="713">17 - La Palmyre - Phare Coubre</option>
                                                            <option  value="679">17 - La Perroche</option>
                                                            <option  value="1062234">17 - Le Boutillon</option>
                                                            <option  value="85">17 - Le Ptit Bec</option>
                                                            <option  value="1099">17 - Les Boulassiers</option>

                                                            <option  value="30114">17 - Les Gouillauds</option>
                                                            <option  value="210">17 - Les Grenettes</option>
                                                            <option  value="678">17 - Les Huttes</option>
                                                            <option  value="732">17 - Les Huttes (surf)</option>
                                                            <option  value="1217">17 - Les Minimes</option>
                                                            <option  value="1062342">17 - Les Vergnes</option>

                                                            <option  value="73">17 - Lizay</option>
                                                            <option  value="30101">17 - Plage du Douhet</option>
                                                            <option  value="1257">17 - Plage du Galon d'Or</option>
                                                            <option  value="97">17 - Plaisance</option>
                                                            <option  value="209">17 - Rivedoux</option>
                                                            <option  value="103">17 - Royan</option>

                                                            <option  value="1178">17 - Royan Grande Plage</option>
                                                            <option  value="784">17 - Royan Pontaillac</option>
                                                            <option  value="195">17 - Sablanceaux</option>
                                                            <option  value="1062367">17 - Saint-Georges-de-Didonne</option>
                                                            <option  value="785">17 - Vert Bois</option>
                                                            <option  value="1064">22 - Baie de St Efflam</option>

                                                            <option  value="620">22 - Baie des Ebihens</option>
                                                            <option  value="640">22 - Binic City Harbour</option>
                                                            <option  value="752">22 - Cap Frehel (Poori)</option>
                                                            <option  value="639">22 - Ile Grande</option>
                                                            <option  value="467">22 - La Tortue</option>
                                                            <option  value="641">22 - Les Godelins</option>

                                                            <option  value="766">22 - Les Rosaires</option>
                                                            <option  value="156">22 - Perros-Guirec</option>
                                                            <option  value="1405">22 - Plage Bonaparte</option>
                                                            <option  value="160">22 - Pors-Nevez</option>
                                                            <option  value="638">22 - Port Blanc </option>
                                                            <option  value="592">22 - Tresmeur</option>

                                                            <option  value="992">22 - Trestel</option>
                                                            <option  value="30070">26 - Cruas</option>
                                                            <option  value="30036">26 - Lac de Pierrelatte</option>
                                                            <option  value="30068">26 - Portes Les Valence</option>
                                                            <option  value="682">27 - Léry-Poses</option>
                                                            <option  value="218">29 - Archipel des glénan</option>

                                                            <option  value="1173">29 - Blancs Sablons</option>
                                                            <option  value="1062198">29 - Boutrouille</option>
                                                            <option  value="100051">29 - Cap-Coz</option>
                                                            <option  value="100040">29 - Crac'h zu</option>
                                                            <option  value="1247">29 - Dossen</option>
                                                            <option  value="1062368">29 - Dourveil</option>

                                                            <option  value="449">29 - Gwendrez</option>
                                                            <option  value="922">29 - Keremma</option>
                                                            <option  value="100012">29 - Kerfissien</option>
                                                            <option  value="1466">29 - Kermabec</option>
                                                            <option  value="212">29 - Kervel</option>
                                                            <option  value="816">29 - La Baie des Trépassés</option>

                                                            <option  value="414">29 - La Mauvaise Grève</option>
                                                            <option  value="217">29 - La Palue</option>
                                                            <option  value="47">29 - La Torche</option>
                                                            <option  value="1478">29 - Le kérou</option>
                                                            <option  value="222">29 - Le Letty</option>
                                                            <option  value="216">29 - Le Steir</option>

                                                            <option  value="394">29 - Le Vougot</option>
                                                            <option  value="100032">29 - Le Wedge</option>
                                                            <option  value="247">29 - Lostmarc'h</option>
                                                            <option  value="220">29 - L'ïle aux Vaches</option>
                                                            <option  value="538">29 - L'Ile aux Vaches</option>
                                                            <option  value="224">29 - L'ïle Tudy</option>

                                                            <option  value="30113">29 - Moulin Blanc</option>
                                                            <option  value="223">29 - Mousterlin</option>
                                                            <option  value="662">29 - Pen-Had</option>
                                                            <option  value="1026">29 - Penfoul</option>
                                                            <option  value="443">29 - Penhors</option>
                                                            <option  value="204">29 - Pentrez</option>

                                                            <option  value="342">29 - Petit Minou</option>
                                                            <option  value="221">29 - Plage de Goulien</option>
                                                            <option  value="227">29 - Plage de Mesperleuc</option>
                                                            <option  value="228">29 - Plage des Abers</option>
                                                            <option  value="1406">29 - Plage Sables Blancs</option>
                                                            <option  value="1295">29 - Pors Ar Vag</option>

                                                            <option  value="1514">29 - Pors ar Villiec</option>
                                                            <option  value="219">29 - Pors Carn</option>
                                                            <option  value="213">29 - Sables Blancs</option>
                                                            <option  value="990">29 - Sables Blancs (Loctudy)</option>
                                                            <option  value="1538">29 - Saint Tugen</option>
                                                            <option  value="395">29 - Sainte Marguerite</option>

                                                            <option  value="1438">29 - Sainte-Anne La Palud</option>
                                                            <option  value="1275">29 - St Gué</option>
                                                            <option  value="226">29 - Tronoën</option>
                                                            <option  value="299">29 - Tronoën</option>
                                                            <option  value="1014">2A - Balistra</option>
                                                            <option  value="282">2A - Capo di Feno</option>

                                                            <option  value="425">2A - Figari</option>
                                                            <option  value="528">2A - Golfe de Ventilègne</option>
                                                            <option  value="1062181">2A - La Liscia</option>
                                                            <option  value="1015">2A - La Tonnara</option>
                                                            <option  value="1330">2A - Le Phare</option>
                                                            <option  value="1224">2A - Le Rupione</option>

                                                            <option  value="284">2A - Les C.R.S</option>
                                                            <option  value="1016">2A - Piantarella</option>
                                                            <option  value="582">2B - Algajola</option>
                                                            <option  value="1327">2B - Arinella</option>
                                                            <option  value="1606">2B - Calvi</option>
                                                            <option  value="1265">2B - Farinole</option>

                                                            <option  value="1266">2B - Giotani</option>
                                                            <option  value="100076">2B - Marana</option>
                                                            <option  value="1062179">2B - Port de Taverna</option>
                                                            <option  value="158">30 - Le Boucanet</option>
                                                            <option  value="381">30 - L'Espiguette</option>
                                                            <option  value="1548">30 - Phenix</option>

                                                            <option  value="157">30 - Port Camargue - sud</option>
                                                            <option  value="1078">31 - Lac de la Ramée</option>
                                                            <option  value="62003">33 - Arcachon - Le Port</option>
                                                            <option  value="100043">33 - Banc d'Arguin</option>
                                                            <option  value="94">33 - Bobby Spot</option>
                                                            <option  value="264">33 - Cap-Ferret</option>

                                                            <option  value="71">33 - Carcans Océan</option>
                                                            <option  value="155">33 - Cazaux</option>
                                                            <option  value="231">33 - Claouey</option>
                                                            <option  value="99">33 - Hourtin Lac (port)</option>
                                                            <option  value="659">33 - Hourtin-Plage</option>
                                                            <option  value="1317">33 - Hourtin-Plage</option>

                                                            <option  value="1568">33 - île aux Oiseaux</option>
                                                            <option  value="1497">33 - La Chambrette</option>
                                                            <option  value="627">33 - La Hume</option>
                                                            <option  value="30022">33 - La Lagune</option>
                                                            <option  value="170">33 - La Salie</option>
                                                            <option  value="42">33 - Lacanau Lac</option>

                                                            <option selected="selected" value="1">33 - Lacanau Océan</option>
                                                            <option  value="74">33 - Lacanau Plage Sud</option>
                                                            <option  value="48">33 - Lachanau Lac Hourtin</option>
                                                            <option  value="302">33 - Le Betey</option>
                                                            <option  value="118">33 - Le Grand Crohot</option>
                                                            <option  value="857">33 - Le Gurp</option>

                                                            <option  value="83">33 - Le Porge</option>
                                                            <option  value="669">33 - Le Truc vert</option>
                                                            <option  value="162">33 - Les Arbousiers</option>
                                                            <option  value="1412">33 - L'Amélie</option>
                                                            <option  value="1585">33 - L'Observatoire </option>
                                                            <option  value="693">33 - Mascaret de Cadillac</option>

                                                            <option  value="215">33 - Mascaret de Saint-Pardon</option>
                                                            <option  value="166">33 - Montalivet</option>
                                                            <option  value="575">33 - Pointe du Verdon </option>
                                                            <option  value="1056">33 - Pyla-sur-Mer</option>
                                                            <option  value="100041">33 - Pyla-sur-Mer</option>
                                                            <option  value="1569">33 - Saint-Brice</option>

                                                            <option  value="138">33 - Soulac Sud</option>
                                                            <option  value="129">33 - Soulac sur Mer</option>
                                                            <option  value="368">33 - Tatabeach</option>
                                                            <option  value="383">34 - Arresquiers</option>
                                                            <option  value="339">34 - Etang des moures</option>
                                                            <option  value="147">34 - Grand Travers</option>

                                                            <option  value="382">34 - Ingrill</option>
                                                            <option  value="263">34 - La Chapelle</option>
                                                            <option  value="491">34 - La Grande Motte</option>
                                                            <option  value="424">34 - La Mairie</option>
                                                            <option  value="256">34 - La Séche</option>
                                                            <option  value="255">34 - Les Dunes </option>

                                                            <option  value="416">34 - Les Roquilles</option>
                                                            <option  value="276">34 - Maguelone</option>
                                                            <option  value="250">34 - Maldormir</option>
                                                            <option  value="410">34 - Octon Salagou</option>
                                                            <option  value="261">34 - Palavas-les-Flots</option>
                                                            <option  value="253">34 - Richelieu</option>

                                                            <option  value="30047">35 - Le Sillon</option>
                                                            <option  value="62011">35 - Le Sillon</option>
                                                            <option  value="100038">35 - Le Verger</option>
                                                            <option  value="1222">35 - Longchamp</option>
                                                            <option  value="1291">35 - Saint-Suliac</option>
                                                            <option  value="736">35 - St Enogat</option>

                                                            <option  value="714">36 - Lac de Chambon</option>
                                                            <option  value="100010">37 - Lac de Bourgueil</option>
                                                            <option  value="100030">38 - Lac de Laffrey</option>
                                                            <option  value="706">38 - Lac du Monteynard</option>
                                                            <option  value="100016">38 - Lac du Sautet</option>
                                                            <option  value="116">40 - Biscarrosse Plage</option>

                                                            <option  value="123">40 - Cap de l'Homy</option>
                                                            <option  value="1244">40 - Capbreton -  les digues</option>
                                                            <option  value="30009">40 - Capbreton - La Centrale</option>
                                                            <option  value="718">40 - Capbreton - le Santosha</option>
                                                            <option  value="126">40 - Contis Plage</option>
                                                            <option  value="136">40 - Hossegor - La Gravière</option>

                                                            <option  value="273">40 - Hossegor - La Nord</option>
                                                            <option  value="30008">40 - Hossegor - Les Culs Nus</option>
                                                            <option  value="30077">40 - Hossegor - Sud</option>
                                                            <option  value="30045">40 - Ispe</option>
                                                            <option  value="106">40 - La Piste / V.V.F</option>
                                                            <option  value="291">40 - Labenne - la chapelle</option>

                                                            <option  value="1093">40 - Labenne Casanova</option>
                                                            <option  value="30006">40 - Le Prévent</option>
                                                            <option  value="1069">40 - Les Aigrettes</option>
                                                            <option  value="1062369">40 - Lespecier</option>
                                                            <option  value="999">40 - Messanges</option>
                                                            <option  value="161">40 - Mimizan</option>

                                                            <option  value="280">40 - Mimizan</option>
                                                            <option  value="991">40 - Moliets</option>
                                                            <option  value="56">40 - Navarrosse</option>
                                                            <option  value="30057">40 - Notre Dame</option>
                                                            <option  value="199">40 - Saint-Girons</option>
                                                            <option  value="248">40 - Sanguinet</option>

                                                            <option  value="328">40 - Seignosse - Le Penon</option>
                                                            <option  value="892">40 - Seignosse - Les Bourdaines</option>
                                                            <option  value="1095">40 - Seignosse - Les Casernes</option>
                                                            <option  value="720">40 - Seignosse - Les Estagnots</option>
                                                            <option  value="786">40 - Soustons Plage</option>
                                                            <option  value="293">40 - Tarnos Digue</option>

                                                            <option  value="913">40 - Vieux Boucau</option>
                                                            <option  value="730">44 - Bonne Source</option>
                                                            <option  value="371">44 - Gohaud</option>
                                                            <option  value="309">44 - Grand-Traict</option>
                                                            <option  value="503">44 - Kerlédé</option>
                                                            <option  value="663">44 - La Baule</option>

                                                            <option  value="130">44 - La Courance </option>
                                                            <option  value="389">44 - La Govelle</option>
                                                            <option  value="131">44 - La Turballe </option>
                                                            <option  value="290">44 - Lanseria</option>
                                                            <option  value="1176">44 - Le Fier</option>
                                                            <option  value="537">44 - Le Pointeau</option>

                                                            <option  value="411">44 - L'Anse du Sud</option>
                                                            <option  value="1284">44 - L'ermitage</option>
                                                            <option  value="729">44 - M.hulot</option>
                                                            <option  value="409">44 - Margaret plage</option>
                                                            <option  value="289">44 - Plage St Michel</option>
                                                            <option  value="664">44 - Plage Valentin</option>

                                                            <option  value="96">44 - Pont-Mahé</option>
                                                            <option  value="1198">44 - Pornic</option>
                                                            <option  value="266">44 - Pornichet</option>
                                                            <option  value="547">44 - Sainte-Marguerite</option>
                                                            <option  value="384">44 - St Brévin</option>
                                                            <option  value="549">44 - Tharon - Digue</option>

                                                            <option  value="712">48 - Naussac</option>
                                                            <option  value="814">49 - Lac du Maine </option>
                                                            <option  value="1103">49 - Lac du verdon</option>
                                                            <option  value="1541">50 - Anneville</option>
                                                            <option  value="30027">50 - Anneville</option>
                                                            <option  value="30024">50 - Barneville Carteret</option>

                                                            <option  value="1058">50 - Barneville Plage</option>
                                                            <option  value="1119">50 - Biville</option>
                                                            <option  value="30074">50 - Bretteville</option>
                                                            <option  value="30129">50 - Carolles</option>
                                                            <option  value="1062188">50 - Collignon</option>
                                                            <option  value="1240">50 - Jullouville</option>

                                                            <option  value="434">50 - La Vallée</option>
                                                            <option  value="404">50 - La Vanlée</option>
                                                            <option  value="976">50 - Le Rozel</option>
                                                            <option  value="677">50 - L'anse du brick</option>
                                                            <option  value="596">50 - Pointe de Jonville</option>
                                                            <option  value="1062337">50 - Portbail</option>

                                                            <option  value="30001">50 - Sciotot</option>
                                                            <option  value="93">50 - Siouville</option>
                                                            <option  value="100073">50 - Siouville</option>
                                                            <option  value="1075">50 - Vauville</option>
                                                            <option  value="62010">51 - Lac du Der</option>
                                                            <option  value="1062189">56 -  Saint-Pierre</option>

                                                            <option  value="815">56 - Barre d'Etel</option>
                                                            <option  value="78">56 - Donnant</option>
                                                            <option  value="117">56 - Guidel-Plage</option>
                                                            <option  value="1062341">56 - Ile aux Moines</option>
                                                            <option  value="1474">56 - Kerguelen</option>
                                                            <option  value="1062348">56 - Kerhillio</option>

                                                            <option  value="1472">56 - Kipu</option>
                                                            <option  value="1118">56 - La Tourelle</option>
                                                            <option  value="715">56 - Les sables blancs</option>
                                                            <option  value="984">56 - Lines</option>
                                                            <option  value="973">56 - Penthièvre</option>
                                                            <option  value="1062356">56 - Petite mer de Gâvres</option>

                                                            <option  value="146">56 - Pointe de Penvins</option>
                                                            <option  value="980">56 - Pointe des Kaolin</option>
                                                            <option  value="57">56 - Quiberon</option>
                                                            <option  value="344">56 - Sainte Barbe</option>
                                                            <option  value="1460">59 - Gravelines</option>
                                                            <option  value="629">59 - Malo les Bains</option>

                                                            <option  value="667">62 - Audresselles</option>
                                                            <option  value="105">62 - Berck</option>
                                                            <option  value="642">62 - Berck</option>
                                                            <option  value="1040">62 - Calais</option>
                                                            <option  value="935">62 - Hardelot-Plage</option>
                                                            <option  value="435">62 - La Pointe aux Oies</option>

                                                            <option  value="30092">62 - La sirène</option>
                                                            <option  value="275">62 - Le Touquet</option>
                                                            <option  value="548">62 - Les Hemmes</option>
                                                            <option  value="1062345">62 - Saint-Gabriel</option>
                                                            <option  value="349">62 - Wimereux</option>
                                                            <option  value="426">62 - Wimereux</option>

                                                            <option  value="285">62 - Wissant</option>
                                                            <option  value="240">64 - Anglet Corsaires</option>
                                                            <option  value="167">64 - Anglet La Barre</option>
                                                            <option  value="272">64 - Anglet La Madrague</option>
                                                            <option  value="168">64 - Anglet Les Cavaliers</option>
                                                            <option  value="30054">64 - Anglet Marinella</option>

                                                            <option  value="30028">64 - Anglet Plage de l'Océan</option>
                                                            <option  value="789">64 - Anglet Sables d'Or</option>
                                                            <option  value="1311">64 - Anglet Surf Club</option>
                                                            <option  value="148">64 - Anglet VVF</option>
                                                            <option  value="1411">64 - Avalanche</option>
                                                            <option  value="121">64 - Belharra</option>

                                                            <option  value="249">64 - Biarritz - Grande Plage</option>
                                                            <option  value="70">64 - Bidart Centre</option>
                                                            <option  value="1084">64 - Bidart Erretegia</option>
                                                            <option  value="86">64 - Côte des Basques</option>
                                                            <option  value="495">64 - Erromardie - Acotz</option>
                                                            <option  value="58">64 - Guethary Parlementia</option>

                                                            <option  value="127">64 - Hendaye</option>
                                                            <option  value="303">64 - Ilbaritz</option>
                                                            <option  value="31">64 - Lafiténia</option>
                                                            <option  value="967">64 - Le Furoncle</option>
                                                            <option  value="5">64 - Les Alcyons</option>
                                                            <option  value="1574">64 - L'Uhabia</option>

                                                            <option  value="1584">64 - Marbella</option>
                                                            <option  value="1428">64 - Mayarco</option>
                                                            <option  value="30020">64 - Milady</option>
                                                            <option  value="295">64 - Pavillon Royal</option>
                                                            <option  value="149">64 - Sainte Barbe</option>
                                                            <option  value="186">64 - Socoa</option>

                                                            <option  value="717">64 - Vanthrax</option>
                                                            <option  value="1277">66 - Banyuls</option>
                                                            <option  value="262">66 - Canet Sud - Pont des Basses</option>
                                                            <option  value="550">66 - Canet-Plage</option>
                                                            <option  value="417">66 - Le Racou</option>
                                                            <option  value="600">66 - Le Racou</option>

                                                            <option  value="260">66 - Saint Cyprien</option>
                                                            <option  value="437">66 - Saint-Cyprien</option>
                                                            <option  value="100027">69 - Lac du Colombier</option>
                                                            <option  value="1123">69 - Miribel</option>
                                                            <option  value="369">72 - Lac de la Gémerie</option>
                                                            <option  value="769">72 - Lac des Varennes </option>

                                                            <option  value="1073">73 - Lac du Bourget</option>
                                                            <option  value="30025">74 - Lac de Passy</option>
                                                            <option  value="527">76 - Antifer</option>
                                                            <option  value="30016">76 - Criel-Plage</option>
                                                            <option  value="237">76 - Etretat</option>
                                                            <option  value="301">76 - Le Havre</option>

                                                            <option  value="391">76 - Le Havre</option>
                                                            <option  value="1596">76 - Pourville</option>
                                                            <option  value="278">76 - Saint-Aubin</option>
                                                            <option  value="165">76 - Vaucottes</option>
                                                            <option  value="243">76 - Yport</option>
                                                            <option  value="100050">77 - La Grande Paroisse</option>

                                                            <option  value="657">78 - Etang de Saint-Quentin</option>
                                                            <option  value="691">78 - Etang Moisson - Lavacourt</option>
                                                            <option  value="1062193">80 - Ault Onival</option>
                                                            <option  value="30099">80 - Brighton</option>
                                                            <option  value="1062366">80 - Fort-Mahon</option>
                                                            <option  value="277">80 - Le Crotoy</option>

                                                            <option  value="279">80 - Mers-les-Bains</option>
                                                            <option  value="415">80 - Mers-les-Bains</option>
                                                            <option  value="1062213">80 - Quend-Plage</option>
                                                            <option  value="1062365">80 - Quend-Plage</option>
                                                            <option  value="755">83 - Almanarre</option>
                                                            <option  value="649">83 - Cap Saint-Louis</option>

                                                            <option  value="726">83 - Gigaro</option>
                                                            <option  value="1062256">83 - La Bergerie</option>
                                                            <option  value="756">83 - La Madrague</option>
                                                            <option  value="1062190">83 - Le Brusc</option>
                                                            <option  value="30169">83 - Le Lido</option>
                                                            <option  value="198">83 - Le Mourillon</option>

                                                            <option  value="30031">83 - Les Sablettes</option>
                                                            <option  value="1062247">83 - L'Ayegade</option>
                                                            <option  value="1535">83 - Portissol</option>
                                                            <option  value="270">83 - St Aygulf</option>
                                                            <option  value="1293">85 - Barbâtre</option>
                                                            <option  value="91">85 - Bud Bud</option>

                                                            <option  value="974">85 - Fromentine</option>
                                                            <option  value="673">85 - La Gachère</option>
                                                            <option  value="1114">85 - La Mine</option>
                                                            <option  value="30064">85 - La pulantes</option>
                                                            <option  value="1033">85 - La Sauzaie</option>
                                                            <option  value="1153">85 - La Térrière</option>

                                                            <option  value="1486">85 - La Tranche sur Mer</option>
                                                            <option  value="265">85 - La Tranche-sur-Mer</option>
                                                            <option  value="1062275">85 - Les Boucholeurs</option>
                                                            <option  value="1062276">85 - Les Sableaux</option>
                                                            <option  value="188">85 - Les Sables d'Olonne</option>
                                                            <option  value="1268">85 - Les Sables d'Olonne</option>

                                                            <option  value="685">85 - Les Vieilles</option>
                                                            <option  value="119">85 - l'Epine</option>
                                                            <option  value="407">85 - Plage des Dunes</option>
                                                            <option  value="178">85 - Plage du Veillon</option>
                                                            <option  value="30033">85 - Saint-Jean-de-Monts</option>
                                                            <option  value="100046">85 - Saint-Jean-de-Monts</option>

                                                            <option  value="380">85 - Sauveterre</option>
                                                            <option  value="406">85 - St Gilles-Croix-de-Vie</option>
                                                            <option  value="754">85 - Tanchet</option>
                                                            <option  value="100057">86 - Lac de Saint-Cyr</option>
                                                            <option  value="817">95 - Etang de Cergy</option>
                                                            <option  value="1571">95 - Hérouville</option>

                              


                            </select>
                            
                            
 <select name="select" class="deroulDivers" onchange="document.getElementById('mb1').src='http://www.allosurf.net/extern/mb1.php?qui=&id='+spotid+'&ventunite='+this.value; ventunite=this.value;  document.getElementById('textacoller1').value=coller1+spotid+'&ventunite='+this.value+coller2;  ; ">
 <option value="nd">vent en noeuds</option>
 <option value="bft">vent en beauforts</option>
 <option value="kmh">vent en km/h</option>
</select>			    </td>
                        </tr>

                    </table> 
</form>
                  </td>
                      </tr>
                      <tr>
                        <td align="center"><img id="mb1" src="http://www.allosurf.net/extern/mb1.php?qui=&id=1" alt="meteo surf report" width="500" height="250"></td>
                      </tr>

                      <tr>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>&nbsp;		</td>
                      </tr>

                      <tr>
                        <td align="left">&nbsp;</td>
                      </tr>
                      <tr>
                        <td align="left"><span style="font-weight: bold">WIND MAP</span></td>
                      </tr>
                      <tr>

                        <td align="left">
                        
          <table width="48%" border="0"  cellspacing="0" cellpadding="0">
          <tr>
          <td>              
                        <select name="regionmembresXX"  class="deroulDivers"  onchange="houle = this.value; document.getElementById('mb2').src = 'http://www.allosurf.net/extern/mb2.php?qui=&houle='+houle+'&vent=' + vent;   document.getElementById('textacoller2').value=coller1b+houle+'&vent='+vent+coller2b;  ">
<option value="">Prévisions houle choisir zone</option>
<option value="2">Golfe de Gascogne</option>
<option value="4">Bretagne et Manche</option>
<option value="5">Portugal Maroc</option>

<option value="1">Océan Atlantique (évolution cyclones)</option>
</select>

<select name="regionmembres"  class="deroulDivers"  onchange="vent = this.value; document.getElementById('mb2').src = 'http://www.allosurf.net/extern/mb2.php?qui=&houle='+houle+'&vent=' + vent;    document.getElementById('textacoller2').value=coller1b+houle+'&vent='+vent+coller2b;    ">
<option value="">Prévisions vent à afficher</option>
<option value="1">Golfe de Gascogne</option>
<option value="3">Bretagne et Manche</option>
<option value="2">Méditerranée</option>
<option value="4">Portugal Maroc</option>
</select></td>
                        </tr>

                    </table></td>
                      </tr>
                      <tr>
                        <td align="left">
	<script>
	var vent=1;
	var houle=2;
	</script>


     </td>
                      </tr>
                      <tr>

                        <td height="100" align="center"><img id="mb2" src="http://www.allosurf.net/extern/mb2.php?qui=" alt="meteo report" width="500" height="250"></td>
                      </tr>
<tr>
<td>
                    </table>
                
                
<p><b>Share this weather report on social networks.</b></p>
<div>
<script type="text/javascript">
  addthis_url    = location.href;   
  addthis_title  = document.title;  
  addthis_pub    = 'digitalalchemy';     
</script><script type="text/javascript" src="http://s7.addthis.com/js/addthis_widget.php?v=12" ></script>
</div>
</div>
                
			</div>
		</div>
		<div class="blockbas block644bas"></div>
	</div>


<%@ include file="inc/footer.jsp" %>