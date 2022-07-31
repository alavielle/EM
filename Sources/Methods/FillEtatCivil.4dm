//%attributes = {}
//FillEtatCivil
//$1 Type/id

C_TEXT:C284($composant; $hideIfNew; $SelectFiscal; $SelectRessortissant; $SelectAyantDroits; $SelectConjoint; $SelectEnfants; $SelectTutelles; $autre; $activite_marine)
C_OBJECT:C1216($objEC)
$position:=Position:C15("/"; $1)
$type:=Substring:C12($1; 1; $position-1)
$uuid:=Substring:C12($1; $position+1; Length:C16($1))

If ($type="AUTRE")
	$autre:="PERSONNE A CHARGE"
End if 

If (Length:C16($uuid)>0)
	$objEC:=FindEtatCivilByUUID($uuid)
	$composant:=JSON Stringify:C1217($objEC)
	$SelectFiscal:=FindAutresFoyers($uuid)
	$SelectAyantDroits:=FindAyantDroits($uuid)
	$SelectEnfants:=FindEnfants($uuid)
	$SelectTutelles:=FindTutelles($uuid)
	$etatCivil:=ds:C1482.EtatCivil.query("UUID = :1"; $uuid).first()
	C_COLLECTION:C1488($myCol)
	$myCol:=New collection:C1472
	If ($etatCivil.ID_Ressortissant>0)
		$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatCivil.ID_Ressortissant)[0]
		ARRAY LONGINT:C221($tabIdEC; 0)
		ARRAY TEXT:C222($tabLibEC; 0)
		APPEND TO ARRAY:C911($tabIdEC; $SharedEC.ID)
		APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
		ARRAY TO COLLECTION:C1563($myCol; $tabIdEC; "ID"; $tabLibEC; "NomPrenom")
		$SelectRessortissant:=HTML_Select_Collection("Ressortissant"; "ID_Ressortissant"; $myCol.extract("ID"); $myCol.extract("NomPrenom"); Null:C1517; "")
	Else 
		$SelectRessortissant:=HTML_Select_Collection("Ressortissant"; "ID_Ressortissant"; $mycol; $mycol; Null:C1517; "")
	End if 
	C_COLLECTION:C1488($myCol)
	$myCol:=New collection:C1472
	If ($etatCivil.ID_Conjoint>0)
		$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatCivil.ID_Conjoint)[0]
		ARRAY LONGINT:C221($tabIdEC; 0)
		ARRAY TEXT:C222($tabLibEC; 0)
		APPEND TO ARRAY:C911($tabIdEC; $SharedEC.ID)
		APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
		ARRAY TO COLLECTION:C1563($myCol; $tabIdEC; "ID"; $tabLibEC; "NomPrenom")
		$SelectConjoint:=HTML_Select_Collection("Conjoint"; "ID_Conjoint"; $myCol.extract("ID"); $myCol.extract("NomPrenom"); Null:C1517; "")
	Else 
		$SelectConjoint:=HTML_Select_Collection("Conjoint"; "ID_Conjoint"; $myCol; $myCol; Null:C1517; "")
	End if 
Else 
	C_OBJECT:C1216($obj)
	C_OBJECT:C1216($ParamSelect)
	OB SET:C1220($ParamSelect; "Required"; "Faux")
	OB SET:C1220($ParamSelect; "LigneVide"; "Vrai")
	OB SET:C1220($ParamSelect; "LigneChoisir"; " ")
	OB SET:C1220($ParamSelect; "Disabled"; "Faux")
	OB SET:C1220($ParamSelect; "Hidden"; "Faux")
	OB SET:C1220($ParamSelect; "Multiple"; "Faux")
	If ($type="RESSORTISSANT")
		OB SET:C1220($obj; "CodeDossier"; NewCodeDossier)
		
	Else 
		$hideIfNew:="style='display:none'"
		$ressortissants:=ds:C1482.EtatCivil.query("Type='RESSORTISSANT'")
		
		C_COLLECTION:C1488($myCol)
		ARRAY LONGINT:C221($tabIdEC; 0)
		ARRAY TEXT:C222($tabLibEC; 0)
		For each ($ressortissant; $ressortissants)
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $ressortissant.ID)[0]
			APPEND TO ARRAY:C911($tabIdEC; $SharedEC.ID)
			APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
		End for each 
		$myCol:=New collection:C1472
		ARRAY TO COLLECTION:C1563($myCol; $tabIdEC; "ID"; $tabLibEC; "NomPrenom")
		$myCol:=$myCol.orderBy("NomPrenom")
		$SelectRessortissant:=HTML_Select_Collection("Ressortissant"; "ID_Ressortissant"; $myCol.extract("ID"); $myCol.extract("NomPrenom"); Null:C1517; ""; $ParamSelect)
		
		If (($type="ENFANT") | ($type="AUTRE"))
			$conjoints:=ds:C1482.EtatCivil.query("Type='CONJOINT'")
			
			C_COLLECTION:C1488($myCol)
			ARRAY LONGINT:C221($tabIdEC; 0)
			ARRAY TEXT:C222($tabLibEC; 0)
			For each ($conjoint; $conjoints)
				$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $conjoint.ID)[0]
				APPEND TO ARRAY:C911($tabIdEC; $SharedEC.ID)
				APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
			End for each 
			$myCol:=New collection:C1472
			ARRAY TO COLLECTION:C1563($myCol; $tabIdEC; "ID"; $tabLibEC; "NomPrenom")
			$myCol:=$myCol.orderBy("NomPrenom")
			$SelectConjoint:=HTML_Select_Collection("Conjoint"; "ID_Conjoint"; $myCol.extract("ID"); $myCol.extract("NomPrenom"); Null:C1517; ""; $ParamSelect)
		End if 
	End if 
	OB SET:C1220($obj; "Type"; $type)
	$composant:=JSON Stringify:C1217($obj)
End if 

$SelectTuteur:=SelectTuteur()

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="etat_civil")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="etat_civil_base")
$contenu_base:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$assurance_base:=SelectAssurance()

If ($type="RESSORTISSANT")
	$activite_marine:=SelectActiviteMarine()
End if 
If ($type="ENFANT")
	$scolarite_base:=SelectScolarite($objEC.ID_Classe; $objEC.ID_NiveauEtude)
End if 

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
$navBar:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])
$prenomNom:=Session:C1714.userName
$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)

$Contenu:=Replace string:C233($Contenu; "$hideIfNew$"; $hideIfNew)
$Contenu:=Replace string:C233($Contenu; "$etat_civil_base$"; $contenu_base)
$Contenu:=Replace string:C233($Contenu; "$assurance_base$"; $assurance_base)
$Contenu:=Replace string:C233($Contenu; "$scolarite_base$"; $scolarite_base)
$Contenu:=Replace string:C233($Contenu; "$activite_marine$"; $activite_marine)
$Contenu:=Replace string:C233($Contenu; "$selectFiscal$"; $SelectFiscal)
$Contenu:=Replace string:C233($Contenu; "$SelectAyantDroits$"; $SelectAyantDroits)
$Contenu:=Replace string:C233($Contenu; "$SelectEnfants$"; $SelectEnfants)
$Contenu:=Replace string:C233($Contenu; "$SelectTutelles$"; $SelectTutelles)
$Contenu:=Replace string:C233($Contenu; "$SelectRessortissant$"; $SelectRessortissant)
$Contenu:=Replace string:C233($Contenu; "$SelectConjoint$"; $SelectConjoint)
$Contenu:=Replace string:C233($Contenu; "$SelectTuteur$"; $SelectTuteur)
$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
$Contenu:=Replace string:C233($Contenu; "$Type$"; $type)
$Contenu:=Replace string:C233($Contenu; "$autre$"; $autre)
$Contenu:=Replace string:C233($Contenu; "$UUID$"; $uuid)
WEB SEND TEXT:C677($Contenu; "text/html")
