//%attributes = {}
//FindParent
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
$AnneeSco:=ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214).AnneeSco[0]

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
	$classes:=$enfant.scolarites.query("ID_AnneeSco = :1"; ds:C1482.AnneeScolaire.query("Courante = :1"; True:C214).ID[0]).classe.Classe
	If ($classes.length>0)
		$classe:=$classes[0]
	Else 
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

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="assurance_base")
$assurance_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="scolarite_base")
$scolarite_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

ALL RECORDS:C47([MontantPart:7])
ORDER BY:C49([MontantPart:7]; [MontantPart:7]ID:1; >)
ARRAY LONGINT:C221($TabId; 0)
ARRAY TEXT:C222($TabLib; 0)
SELECTION TO ARRAY:C260([MontantPart:7]ID:1; $TabId; [MontantPart:7]NiveauEtude:2; $TabLib)
C_TEXT:C284($Select)
C_OBJECT:C1216($SelectProperties)
OB SET:C1220($SelectProperties; "onchange"; "Oui")
OB SET:C1220($SelectProperties; "onchangemethod"; "popNeSelected")
C_OBJECT:C1216(ParamSelect)
OB SET:C1220(ParamSelect; "Required"; "Faux")
OB SET:C1220(ParamSelect; "LigneVide"; "Faux")
OB SET:C1220(ParamSelect; "LigneChoisir"; "Choisir")
OB SET:C1220(ParamSelect; "Disabled"; "Faux")
OB SET:C1220(ParamSelect; "Hidden"; "Faux")
OB SET:C1220(ParamSelect; "Multiple"; "Faux")
$SelectNe:=HTML_Select("Niveau d'études *"; "NiveauEtude"; ->$TabId; ->$TabLib; $SelectProperties; ""; ParamSelect)

$scolarite_base:=Replace string:C233($scolarite_base; "$selectNe$"; $SelectNe)


$Contenu:=Replace string:C233($Contenu; "$Data$"; $Data)
$Contenu:=Replace string:C233($Contenu; "$DataEnfant$"; $DataEnfant)
$Contenu:=Replace string:C233($Contenu; "$DataAutre$"; $DataAutre)
$Contenu:=Replace string:C233($Contenu; "$UUID_boursier$"; $uuid)
$Contenu:=Replace string:C233($Contenu; "$BourseID$"; $BourseID)
$Contenu:=Replace string:C233($Contenu; "$etat_civil_base$"; $etatCivil_base)
$Contenu:=Replace string:C233($Contenu; "$scolarite_base$"; $scolarite_base)
$Contenu:=Replace string:C233($Contenu; "$AnneeSco$"; $AnneeSco)

WEB SEND TEXT:C677($Contenu; "text/html")
