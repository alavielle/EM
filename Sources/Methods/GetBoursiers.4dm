//%attributes = {}
//GetBoursiers
//$1 : UUID WebUser

C_TEXT:C284($1)
C_TEXT:C284($Composant)
$Composant:=""

$user:=ds:C1482.WebUser.query("UUID = :1"; $1).first()
If ($user#Null:C1517)
	SelectionEtatCivilSelonProfil($1)
	
	QUERY SELECTION:C341([EtatCivil:14]; [EtatCivil:14]Type:3="Enfant")
	CREATE SET:C116([EtatCivil:14]; "$NonBoursiers")
	RELATE MANY SELECTION:C340([Bourse:12]ID_Boursier:8)
	QUERY:C277([AnneeScolaire:21]; [AnneeScolaire:21]Courante:3=True:C214)
	QUERY SELECTION:C341([Bourse:12]; [Bourse:12]ID_AnneeSco:2=[AnneeScolaire:21]ID:1)
	RELATE ONE SELECTION:C349([Bourse:12]; [EtatCivil:14])
	CREATE SET:C116([EtatCivil:14]; "$DejaBoursiers")
	DIFFERENCE:C122("$NonBoursiers"; "$DejaBoursiers"; "$NonBoursiers")
	USE SET:C118("$NonBoursiers")
	CLEAR SET:C117("$NonBoursiers")
	
	If (Records in selection:C76([EtatCivil:14])>0)
		ARRAY TEXT:C222($TabUuid; 0)
		ARRAY TEXT:C222($TabLib; 0)
		ARRAY OBJECT:C1221($tabObj; 0)
		For ($i; 1; Records in selection:C76([EtatCivil:14]))
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; [EtatCivil:14]ID:1)[0]
			$NomPrenom:=$SharedEC.Nom+" "+$SharedEC.Prenom
			APPEND TO ARRAY:C911($TabUuid; [EtatCivil:14]UUID:34)
			APPEND TO ARRAY:C911($TabLib; $NomPrenom)
			NEXT RECORD:C51([EtatCivil:14])
		End for 
		SORT ARRAY:C229($TabLib; $TabUuid; >)
		C_COLLECTION:C1488($col)
		$col:=New collection:C1472
		ARRAY TO COLLECTION:C1563($col; $tabUuid; "UUID"; $tabLib; "NomPrenom")
		$return:=JSON Stringify:C1217($col)
		C_TEXT:C284($Select)
		C_OBJECT:C1216($SelectProperties)
		C_OBJECT:C1216($ParamSelect)
		OB SET:C1220($SelectProperties; "onchange"; "Oui")
		OB SET:C1220($SelectProperties; "onchangemethod"; "popNeSelected")
		OB SET:C1220($ParamSelect; "Required"; "Faux")
		OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
		OB SET:C1220($ParamSelect; "LigneChoisir"; "")
		OB SET:C1220($ParamSelect; "Disabled"; "Faux")
		OB SET:C1220($ParamSelect; "Hidden"; "Faux")
		OB SET:C1220($ParamSelect; "Multiple"; "Faux")
		C_OBJECT:C1216($ComposantProperties)
		OB SET:C1220($ComposantProperties; "onchange"; "Oui")
		OB SET:C1220($ComposantProperties; "onchangemethod"; "visible")
		$Composant:=HTML_Select_Collection("Choisir le bénéficiaire"; "beneficiaire"; $col.extract("UUID"); $col.extract("NomPrenom"); $ComposantProperties; Null:C1517; $ParamSelect)
	Else 
		$return:="NoDossier"
		$Composant:=HTML_Trouble("Pas de dossier à déposer pour cette année scolaire")
	End if 
	If ($user.ID_Privilege>3)
		ReturnSomething($return)
	Else 
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="dossier_new")
		If (Records in selection:C76([ModelesHTML:15])>0)
			$contenu:=[ModelesHTML:15]Detail:3
			UNLOAD RECORD:C212([ModelesHTML:15])
			QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
			$navBar:=[ModelesHTML:15]Detail:3
			UNLOAD RECORD:C212([ModelesHTML:15])
			$prenomNom:=Session:C1714.userName
			$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
			$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)
			$Contenu:=Replace string:C233($Contenu; "$SelectBoursiers$"; $Composant)
			WEB SEND TEXT:C677($Contenu; "text/html")
		Else 
			WEB SEND HTTP REDIRECT:C659("/404.shtml")
		End if 
	End if 
End if 