//%attributes = {}
// ReinitPwd
// $1 : "UUID/token"

// interdit l'accès à la page si:
// le token associé au membre est null
// le token enregistré en base et le token présent dans l'url ne sont pas égaux
// le delai d'expiration est dépassé

C_OBJECT:C1216($user)
C_LONGINT:C283($position)
C_TEXT:C284($UUID; $token; $1)

$position:=Position:C15("/"; $1)
$UUID:=Substring:C12($1; 1; $position-1)
$token:=Substring:C12($1; $position+1)

QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="reinit_pwd")
If (Records in selection:C76([ModelesHTML:15])>0)
	$contenu:=[ModelesHTML:15]Detail:3
	$user:=ds:C1482.WebUser.query("UUID = :1"; $UUID).first()
	If ($user#Null:C1517)  //a user was found
		$intervalle:=$user.Expiration-DateToEpoch(Timestamp:C1445)
		If ($intervalle>0)
			If (($user.Token#"") & ($user.Token=$token))
				$Contenu:=Replace string:C233($Contenu; "$UUID$"; $UUID)
				$Contenu:=Replace string:C233($Contenu; "$token$"; $token)
				$composant:=""
				$invisible:=""
			Else 
				$Composant:=HTML_Trouble("Le lien n'est pas valide.")
				$invisible:="hidden"
			End if 
		Else 
			$Composant:=HTML_Trouble("Le lien a expiré ou a déjà été utilisé.")
			$invisible:="hidden"
		End if 
	Else 
		$Composant:=HTML_Trouble("Le lien n'est pas valide.")
		$invisible:="hidden"
	End if 
	$Contenu:=Replace string:C233($Contenu; "$id$"; $user.UUID)
	$Contenu:=Replace string:C233($Contenu; "$invisible$"; $invisible)
	$Contenu:=Replace string:C233($Contenu; "$envoi_lien$"; $composant)
	WEB SEND TEXT:C677($Contenu; "text/html")
	UNLOAD RECORD:C212([ModelesHTML:15])
Else 
	WEB SEND HTTP REDIRECT:C659("/404.shtml")
End if 
