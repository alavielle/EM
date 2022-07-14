//%attributes = {}
// Oubli_pwd
// $1 : envoi_lien_OK

C_TEXT:C284($1)
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="oubli_pwd")
If (Records in selection:C76([ModelesHTML:15])>0)
	$contenu:=[ModelesHTML:15]Detail:3
	If ($1="envoi_lien")
		Envoi_lien(1800)  // Lien d'envoi valable pendant 1/2 heure après l'envoi
		$Composant:=HTML_Trouble("S'il existe un compte associé à cette adresse, vous recevrez un e-mail contenant un lien pour définir un nouveau mot de passe.")
		$Contenu:=Replace string:C233($Contenu; "$invisible$"; "hidden")
		$Contenu:=Replace string:C233($Contenu; "$envoi_lien$"; $composant)
	Else 
		$Contenu:=Replace string:C233($Contenu; "$invisible$"; "")
		$Contenu:=Replace string:C233($Contenu; "$envoi_lien$"; "")
	End if 
	WEB SEND TEXT:C677($Contenu; "text/html")
	UNLOAD RECORD:C212([ModelesHTML:15])
End if 