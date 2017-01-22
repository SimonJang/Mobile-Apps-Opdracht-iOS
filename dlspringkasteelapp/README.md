<h1>iOS applicatie voor reserveren van springkastelen bij DreamLand</h1>
<h2>Inleiding</h2>
<p>Deze applicatie werd ontwikkeld als eindopdracht voor het opleidingsonderdeel Mobile Apps voor iOS. De bedoeling van de app is om springkastelen te reserveren bij Dreamland</p>
<p>Deze opdracht is onafhankelijk gemaakt van DreamLand en dient enkel als examen. Is <b>niet</b> voor productie!</p>
<h2>Infrastructuur</h2>
<p>De applicatie maakt gebruik van een REST API voor de winkels, springkastelen en reservaties te beheren. Deze backend is zelf geschreven en kan je terugvinden op https://iosbackendspringkastelen.herokuapp.com/api en op GitHub op https://github.com/SimonJang/iOS-back-end<p>

<p>Onderstaande API calls worden uitgevoerd in de applicatie</p>
<ul>
<li><b>GET /api/winkels</b> : Voor het opvragen van alle winkels, inclusief springkastelen</li>
<li><b>POST /api/winkels</b> : Opvragen van alle reservaties voor bepaalde winkel en datum</li>
<li><b>GET /api/reservaties/"hash"</b> : Aanvraag van alle reservaties voor klant met e-mail adres hash. Hash is een MD5 hash van het e-mail adres</li>
<li><b>POST /api/reservatie</b> : Voor het aanmaken van een reservatie</li>
</ul>

<h2>Gebruikte frameworks en tools</h2>
<p>Een oplijsting van de gebruikte tools en frameworks</p>
<ul>
<li>CacoaPods</li>
<li>Alamofire voor de REST calls</li>
<li>SwiftyJSON voor verwerken van JSON</li>
</ul>

<h2>Flow van de applicatie</h2>
<p>De applicatie omvat volgende flow</p>
<h3>Reserveren van een springkasteel</h3>
<ul>
<li>Via REST call worden de winkels en hun aantal springkastelen opgevraagd</li>
<li>De klant selecteert een winkel en een datum</li>
<li>Via REST call worden alle reservaties opgehaald voor die dag in die winkel</li>
<li>Applicatie toont in een UITableView aantal beschikare springkastelen</li>
<li>Klant selecteert een beschikbaar springkasteel en vult zijn e-mail adres in</li>
<li>De applicatie verifieert en controleert geldigheid van email adres</li>
<li>Via een REST post wordt de reservatie bewaard in de backend</li>
<li>Applicatie stuurt de gebruiker terug naar beginscherm</li>
</ul>

<h3>Opzoeken van een reservatie</h3>
<ul>
<li>Klant geeft e-mail adres in</li>
<li>Applicatie controleert e-mail, hasht e-mail en stuurt het door naar de REST service voor de reservaties op te halen</li>
<li>Gebruiker krijgt een overzicht van zijn reservaties indien er reservaties zijn anders foutmelding</li>
</ul>

<h3>Bekijken informatie</h3>
<ul>
<li>De gebruiker wenst extra informatie</li>
</ul>


