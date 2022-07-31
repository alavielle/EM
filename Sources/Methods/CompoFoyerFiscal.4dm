//%attributes = {}
// CompoFoyerFiscal
// $1 : $UUID WebUser


QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="compo_foyer_fiscal")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
If ($user#Null:C1517)
	If (IsAdmin($1))
		$foyerFiscal:=ds:C1482.FoyerFiscal.all()
	Else 
		If ($user.ID_Equipe>0)
			Case of 
				: ($user.ID_Privilege=3)
					$foyerFiscal:=ds:C1482.FoyerFiscal.query("ID_ASEM = :1"; $user.ID_Equipe)
				: ($user.ID_Privilege=4)
					$foyerFiscal:=ds:C1482.FoyerFiscal.query("ID_ASA = :1"; $user.ID_Equipe)
			End case 
		Else 
			If ($user.ID_CodeFiscal>0)
				$foyerFiscal:=ds:C1482.FoyerFiscal.query("ID = :1"; $user.ID_CodeFiscal)
			End if 
		End if 
	End if 
	
	If ($foyerFiscal#Null:C1517)
		$etatCivil:=$foyerFiscal.membres
		$code:=$etatCivil.query("Type='RESSORTISSANT'").orderBy("CodeDossier")
		$ressort:=$etatCivil.query("Type='RESSORTISSANT'")
		$conjoint:=$etatCivil.query("Type='CONJOINT'")
		$enfant:=$etatCivil.query("Type='ENFANT'")
		
		C_TEXT:C284($Composant)
		C_OBJECT:C1216($ComposantProperties)
		OB SET:C1220($ComposantProperties; "onchange"; "Oui")
		OB SET:C1220($ComposantProperties; "onchangemethod"; "popDossierSelected")
		C_OBJECT:C1216($ParamSelect)
		OB SET:C1220($ParamSelect; "Required"; "Faux")
		OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
		OB SET:C1220($ParamSelect; "LigneChoisir"; " ")
		OB SET:C1220($ParamSelect; "Disabled"; "Faux")
		OB SET:C1220($ParamSelect; "Hidden"; "Faux")
		OB SET:C1220($ParamSelect; "Multiple"; "Faux")
		
		$Composant:=HTML_Select_Collection("Code Dossier"; "dossierSelected"; $code.CodeDossier; $code.CodeDossier; $ComposantProperties; ""; $ParamSelect)
		$Contenu:=Replace string:C233($Contenu; "$optionDossier$"; $Composant)
		
		C_COLLECTION:C1488($myCol)
		ARRAY TEXT:C222($tabCodeEC; 0)
		ARRAY TEXT:C222($tabLibEC; 0)
		For each ($ec; $ressort)
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $ec.ID)[0]
			APPEND TO ARRAY:C911($tabCodeEC; $SharedEC.CodeDossier)
			APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
		End for each 
		$myCol:=New collection:C1472
		ARRAY TO COLLECTION:C1563($myCol; $tabCodeEC; "CodeDossier"; $tabLibEC; "NomPrenom")
		$myCol:=$myCol.orderBy("NomPrenom")
		$Composant:=HTML_Select_Collection("Ressortissant"; "ressortissantSelected"; $myCol.extract("CodeDossier"); $myCol.extract("NomPrenom"); $ComposantProperties; ""; $ParamSelect)
		$Contenu:=Replace string:C233($Contenu; "$optionRessortissant$"; $Composant)
		
		C_COLLECTION:C1488($myCol)
		ARRAY TEXT:C222($tabCodeEC; 0)
		ARRAY TEXT:C222($tabLibEC; 0)
		For each ($ec; $conjoint)
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $ec.ID)[0]
			APPEND TO ARRAY:C911($tabCodeEC; $SharedEC.CodeDossier)
			APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
		End for each 
		$myCol:=New collection:C1472
		ARRAY TO COLLECTION:C1563($myCol; $tabCodeEC; "CodeDossier"; $tabLibEC; "NomPrenom")
		$myCol:=$myCol.orderBy("NomPrenom")
		$Composant:=HTML_Select_Collection("Conjoint"; "conjointSelected"; $myCol.extract("CodeDossier"); $myCol.extract("NomPrenom"); $ComposantProperties; ""; $ParamSelect)
		$Contenu:=Replace string:C233($Contenu; "$optionConjoint$"; $Composant)
		
		C_COLLECTION:C1488($myCol)
		ARRAY TEXT:C222($tabCodeEC; 0)
		ARRAY TEXT:C222($tabLibEC; 0)
		For each ($ec; $enfant)
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $ec.ID)[0]
			APPEND TO ARRAY:C911($tabCodeEC; $SharedEC.CodeDossier)
			APPEND TO ARRAY:C911($tabLibEC; $SharedEC.Nom+" "+$SharedEC.Prenom)
		End for each 
		$myCol:=New collection:C1472
		ARRAY TO COLLECTION:C1563($myCol; $tabCodeEC; "CodeDossier"; $tabLibEC; "NomPrenom")
		$myCol:=$myCol.orderBy("NomPrenom")
		$Composant:=HTML_Select_Collection("Enfant"; "enfantSelected"; $myCol.extract("CodeDossier"); $myCol.extract("NomPrenom"); $ComposantProperties; ""; $ParamSelect)
		$Contenu:=Replace string:C233($Contenu; "$optionEnfant$"; $Composant)
		
	Else 
		$Contenu:=Replace string:C233($Contenu; "$option$"; "Pas de dossier en cours")
	End if 
	
	QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
	$navBar:=[ModelesHTML:15]Detail:3
	UNLOAD RECORD:C212([ModelesHTML:15])
	$prenomNom:=Session:C1714.userName
	$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
	$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)
	WEB SEND TEXT:C677($Contenu; "text/html")
End if 