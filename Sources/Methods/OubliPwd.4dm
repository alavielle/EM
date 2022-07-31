//%attributes = {}
// OubliPwd
// $1 : envoi_lien_OK

C_TEXT:C284($1)
QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="oubli_pwd")
If (Records in selection:C76([ModelesHTML:15])>0)
	$contenu:=[ModelesHTML:15]Detail:3
	If ($1="envoi_lien")
		$return:=EnvoiLien(1800)  // Lien d'envoi valable pendant 1/2 heure après l'envoi
		If (Position:C15("erreur"; $return)=0)
			$return:="S'il existe un compte associé à cette adresse, <br>vous recevrez un e-mail contenant un lien pour définir un nouveau mot de passe."
		End if 
		ReturnSomething($return)
		//$Composant:=HTML_Trouble("S'il existe un compte associé à cette adresse, vous recevrez un e-mail contenant un lien pour définir un nouveau mot de passe.")
		//$Contenu:=Remplacer chaîne($Contenu; "$invisible$"; "hidden")
		//$Contenu:=Remplacer chaîne($Contenu; "$envoi_lien$"; $composant)
	Else 
		$Contenu:=Replace string:C233($Contenu; "$invisible$"; "")
		$Contenu:=Replace string:C233($Contenu; "$envoi_lien$"; "")
		WEB SEND TEXT:C677($Contenu; "text/html")
		UNLOAD RECORD:C212([ModelesHTML:15])
	End if 
	
End if 