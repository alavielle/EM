//%attributes = {}
//FillRessource
//$1 : BourseID/UUID Etat civil

C_COLLECTION:C1488($param; $toutesRessources; $autresRessources)
$param:=New collection:C1472
$toutesRessources:=New collection:C1472
$autresRessources:=New collection:C1472
$param:=Split string:C1554($1; "/")
$bourseID:=$param[1]
$uuid:=$param[2]

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="ressource")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([WebUser:2]; [WebUser:2]UUID:7=Session:C1714.storage.clientUuid.value)
QUERY:C277([EquipeSociale:16]; [EquipeSociale:16]ID:1=[WebUser:2]ID_Equipe:8)
QUERY:C277([EtatCivil:14]; [EtatCivil:14]UUID:34=$uuid)
$id_CodeFiscal:=[EtatCivil:14]ID_CodeFiscal:31
Case of 
	: ([Privilege:4]ID:1<3)
		//CHERCHER([Ressource]; [Ressource]ID_CodeFiscal=$id_CodeFiscal)
		$ressources:=ds:C1482.Ressource.query("ID_CodeFiscal= :1"; $id_CodeFiscal)
	: ([Privilege:4]ID:1=5)
		If ([WebUser:2]ID_CodeFiscal:9#$id_CodeFiscal)
			WEB SEND HTTP REDIRECT:C659("/403.shtml")
		Else 
			//CHERCHER([Ressource]; [Ressource]ID_CodeFiscal=$id_CodeFiscal)
			$ressources:=ds:C1482.Ressource.query("ID_CodeFiscal= :1"; $id_CodeFiscal)
		End if 
	Else 
		Case of 
			: ([Privilege:4]ID:1=3)
				QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]ID_ASEM:4=[WebUser:2]ID_Equipe:8)
			: ([Privilege:4]ID:1=4)
				QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]ID_ASA:3=[WebUser:2]ID_Equipe:8)
		End case 
		QUERY SELECTION:C341([FoyerFiscal:3]; [FoyerFiscal:3]ID:1=$id_CodeFiscal)
		If (Records in selection:C76([FoyerFiscal:3])=1)
			//CHERCHER([Ressource]; [Ressource]ID_CodeFiscal=$id_CodeFiscal)
			$ressources:=ds:C1482.Ressource.query("ID_CodeFiscal= :1"; $id_CodeFiscal)
		Else 
			WEB SEND HTTP REDIRECT:C659("/403.shtml")
		End if 
End case 

QUERY:C277([AnneeScolaire:21]; [AnneeScolaire:21]Courante:3=True:C214)
$annee:=Substring:C12([AnneeScolaire:21]AnneeSco:2; 1; 4)
//CHERCHER DANS SÉLECTION([Ressource]; [Ressource]Annee=$annee)
$ressource:=$ressources.query("Annee = :1"; $annee)
//Si (Enregistrements trouvés([Ressource])>0)
C_OBJECT:C1216($obj; 0)
If ($ressource.length>0)
	C_TEXT:C284($composant; $composant1)
	$autres:=$ressource.autresRessources
	$toutesRessources:=$ressource.toCollection()
	For each ($autre; $autres)
		OB SET:C1220($obj; "Autre"+String:C10($autre.ID_Ligne; "00"); $autre.Valeur)
	End for each 
	$toutesRessources.push($obj)
	$composant:=JSON Stringify:C1217($toutesRessources)
Else 
	OB SET:C1220($obj; "ID_CodeFiscal"; $id_CodeFiscal; "Annee"; $annee)
	$composant:=JSON Stringify:C1217($obj)
End if 

$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
$Composant:=HTML_LigneRessource()
$Composant:=Replace string:C233($Composant; "$AnneeSco$"; [AnneeScolaire:21]AnneeSco:2)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

$Contenu:=Replace string:C233($Contenu; "$LignesRessources$"; $Composant)
$Contenu:=Replace string:C233($Contenu; "$BourseID$"; $BourseID)
$Contenu:=Replace string:C233($Contenu; "$UUID_boursier$"; $uuid)

WEB SEND TEXT:C677($Contenu; "text/html")