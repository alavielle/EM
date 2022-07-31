//%attributes = {}
//GetDossiers
// $1 : UUID

C_TEXT:C284($1)
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="dossiers")
$contenu:=[ModelesHTML:15]Detail:3
UNLOAD RECORD:C212([ModelesHTML:15])

QUERY:C277([WebUser:2]; [WebUser:2]UUID:7=$1)

If ([WebUser:2]ID_Equipe:8>0)
	QUERY:C277([Privilege:4]; [Privilege:4]ID:1=[WebUser:2]ID_Privilege:6)
	QUERY:C277([EquipeSociale:16]; [EquipeSociale:16]ID:1=[WebUser:2]ID_Equipe:8)
	If ([Privilege:4]ID:1<3)
		RELATE MANY SELECTION:C340([FoyerFiscal:3]ID_ASEM:4)
	Else 
		RELATE MANY SELECTION:C340([FoyerFiscal:3]ID_ASA:3)
	End if 
Else 
	QUERY:C277([FoyerFiscal:3]; [FoyerFiscal:3]ID:1=[WebUser:2]ID_CodeFiscal:9)
End if 
If (Records in selection:C76([FoyerFiscal:3])>0)
	ARRAY LONGINT:C221(tabIdDossier; 0)
	ARRAY TEXT:C222(TabLibDossier; 0)
	SELECTION TO ARRAY:C260([FoyerFiscal:3]ID:1; tabIdDossier; [FoyerFiscal:3]CodeFiscal:2; TabLibDossier)
	
	C_TEXT:C284($Composant)
	C_OBJECT:C1216($ComposantProperties)
	OB SET:C1220($ComposantProperties; "onchange"; "Oui")
	OB SET:C1220($ComposantProperties; "onchangemethod"; "popDossierSelected")
	C_OBJECT:C1216($ParamSelect)
	OB SET:C1220($ParamSelect; "Required"; "Faux")
	OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
	OB SET:C1220($ParamSelect; "LigneChoisir"; "Sélectionnez le dossier")
	OB SET:C1220($ParamSelect; "Disabled"; "Faux")
	OB SET:C1220($ParamSelect; "Hidden"; "Faux")
	OB SET:C1220($ParamSelect; "Multiple"; "Vrai")
	$Composant:=HTML_Select("Choisir dans la liste"; "dossierSelected"; ->tabIdDossier; ->TabLibDossier; $ComposantProperties; ""; $ParamSelect)
	
	$Contenu:=Replace string:C233($Contenu; "$option$"; $Composant)
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