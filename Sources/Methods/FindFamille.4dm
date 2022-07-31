//%attributes = {}
//FindFamille
//$1 : BourseID/Famille/UUID EtatCivil 

C_COLLECTION:C1488($param)
$param:=New collection:C1472
$param:=Split string:C1554($1; "/")
$bourseID:=$param[1]
$uuid:=$param[3]

$etatCivil:=ds:C1482.EtatCivil.query("UUID = :1"; $uuid)
If ($etatCivil.length=1)
	$id_ressortissant:=$etatCivil.ID_Ressortissant[0]
	$id_conjoint:=$etatCivil.ID_Conjoint[0]
End if 

$enfantsDuRessortissant:=ds:C1482.EtatCivil.query("ID = :1"; $id_ressortissant).ayantDroits.query("Type = ENFANT | Type = AUTRE")
$AnneeSco:=ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].AnneeSco

ARRAY OBJECT:C1221($tabObjE; 0)
ARRAY OBJECT:C1221($tabObj; 0)
For each ($enfant; $enfantsDuRessortissant)
	$objEC:=$enfant.toObject()
	OB REMOVE:C1226($objEC; "BlobCrypted")
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $enfant.ID)[0]
	If ($SharedEC#Null:C1517)
		OB SET:C1220($objEC; "Nom"; $SharedEC.Nom)
		OB SET:C1220($objEC; "NomNaissance"; $SharedEC.NomNaissance)
		OB SET:C1220($objEC; "DateNaissance"; $SharedEC.DateNaissance)
		OB SET:C1220($objEC; "CP"; $SharedEC.CP)
		OB SET:C1220($objEC; "Ville"; $SharedEC.Ville)
		OB SET:C1220($objEC; "Tel"; $SharedEC.Tel)
		OB SET:C1220($objEC; "Email"; $SharedEC.Email)
	End if 
	
	If (($enfant.ID_CodeFiscal=$enfant.ressortissant.ID_CodeFiscal) | ($enfant.ID_CodeFiscal=$enfant.conjoint.ID_CodeFiscal))
		$aCharge:=True:C214
	Else 
		$aCharge:=False:C215
	End if 
	$scolarite:=$enfant.scolarites.query("ID_AnneeSco = :1"; ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214)[0].ID)
	$classes:=$scolarite.classe.Classe
	If ($classes.length>0)
		$classe:=$classes[0]
		OB SET:C1220($objEC; "ID_NiveauEtude"; $scolarite[0].classe.niveau.ID)
		OB SET:C1220($objEC; "ID_Classe"; $scolarite[0].classe.ID)
		OB SET:C1220($objEC; "Filiere"; $scolarite[0].Filiere)
	Else 
		OB SET:C1220($objEC; "ID_Classe"; 0)
		OB SET:C1220($objEC; "ID_NiveauEtude"; 0)
		$classe:=""
	End if 
	APPEND TO ARRAY:C911($tabObjE; New object:C1471("ID"; $enfant.ID; "Nom"; $SharedEC.Nom; "Prenom"; $SharedEC.Prenom; "DateNaissance"; $SharedEC.DateNaissance; "SituationProfessionnelle"; $enfant.SituationProfessionnelle; "Classe"; $classe; "ACharge"; $aCharge))
	APPEND TO ARRAY:C911($tabObj; $objEC)
End for each 
$DataEnfant:=JSON Stringify array:C1228($tabObjE)

$autres:=ds:C1482.EtatCivil.query("ID = :1"; $id_conjoint).enfants.query("Type = ENFANT | Type = AUTRE").query("ID_Ressortissant # :1"; $id_ressortissant)

ARRAY OBJECT:C1221($tabObjA; 0)
For each ($enfant; $autres)
	$objEC:=$enfant.toObject()
	OB REMOVE:C1226($objEC; "BlobCrypted")
	$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $enfant.ID)[0]
	If ($SharedEC#Null:C1517)
		OB SET:C1220($objEC; "Nom"; $SharedEC.Nom)
		OB SET:C1220($objEC; "NomNaissance"; $SharedEC.NomNaissance)
		OB SET:C1220($objEC; "DateNaissance"; $SharedEC.DateNaissance)
		OB SET:C1220($objEC; "CP"; $SharedEC.CP)
		OB SET:C1220($objEC; "Ville"; $SharedEC.Ville)
		OB SET:C1220($objEC; "Tel"; $SharedEC.Tel)
		OB SET:C1220($objEC; "Email"; $SharedEC.Email)
	End if 
	
	If ($enfant.ID_CodeFiscal=$enfant.conjoint.ID_CodeFiscal)
		$aCharge:=True:C214
	Else 
		$aCharge:=False:C215
	End if 
	APPEND TO ARRAY:C911($tabObjA; New object:C1471("ID"; $enfant.ID; "Nom"; $SharedEC.Nom; "Prenom"; $SharedEC.Prenom; "DateNaissance"; $SharedEC.DateNaissance; "Parente"; $enfant.Parente; "TauxHandicap"; $enfant.TauxHandicap; "Situation"; $enfant.SituationProfessionnelle))
	APPEND TO ARRAY:C911($tabObj; $objEC)
	
End for each 
$DataAutre:=JSON Stringify array:C1228($tabObjA)
$Data:=JSON Stringify array:C1228($tabObj)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="dossier_famille")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="etat_civil_base")
$etatCivil_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

$scolarite_base:=SelectScolarite($objEC.ID_Classe; $objEC.ID_NiveauEtude)


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

$Contenu:=Replace string:C233($Contenu; "$Data$"; $Data)
$Contenu:=Replace string:C233($Contenu; "$DataEnfant$"; $DataEnfant)
$Contenu:=Replace string:C233($Contenu; "$DataAutre$"; $DataAutre)
$Contenu:=Replace string:C233($Contenu; "$UUID_boursier$"; $uuid)
$Contenu:=Replace string:C233($Contenu; "$BourseID$"; $BourseID)
$Contenu:=Replace string:C233($Contenu; "$etat_civil_base$"; $etatCivil_base)
$Contenu:=Replace string:C233($Contenu; "$scolarite_base$"; $scolarite_base)
$Contenu:=Replace string:C233($Contenu; "$AnneeSco$"; $AnneeSco)

WEB SEND TEXT:C677($Contenu; "text/html")
