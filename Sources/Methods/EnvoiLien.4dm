//%attributes = {}
// EnvoiLien
// $1 : delai d'expiration (en secondes)

C_LONGINT:C283($1)
var $Email : Text
var $user : Object
$return:=""

WEB GET HTTP BODY:C814($Receivedtexte)
C_OBJECT:C1216($ReceivedObject)
$ReceivedObject:=JSON Parse:C1218($Receivedtexte)
$Email:=$ReceivedObject.Email
If ($Email#"")
	If ($ReceivedObject.ObjetMail="reinit-pwd")
		$ObjetMail:="Réinitialisation du mot de passe de votre compte Entraid'Union"
		$ContenuMail:="Bonjour $PrenomNom$ <br><br>"
		$ContenuMail:=$ContenuMail+"Voici le lien à suivre pour réinitialiser votre mot de passe. Il est valide "+String:C10($1/60; "00")+" minutes.<br><br>"
		$ContenuMail:=$ContenuMail+"$lien$"+"<br><br>"
		$ContenuMail:=$ContenuMail+"N’hésitez pas à contacter l'Entraide Marine pour toute information complémentaire."
	Else 
		$ObjetMail:=$ReceivedObject.ObjetMail
		$ContenuMail:=$ReceivedObject.ContenuMail
		$ContenuMail:=Replace string:C233($ContenuMail; "\n"; "<br>")
	End if 
	
	//look for a user with the entered name in the users table
	$user:=ds:C1482.WebUser.query("Email = :1"; $Email).first()
	
	If ($user#Null:C1517)  //a user was found
		
		// créer un token unique
		$token:=Generate UUID:C1066+String:C10(DateToEpoch(Timestamp:C1445))
		$lien:="https://entraidemarine.ecollage.eu/reinit_pwd/"+$user.UUID+"/"+$token
		// sauvegarder le token et le delai d'expiration
		$user.Expiration:=DateToEpoch(Timestamp:C1445)+$1
		$user.Token:=$token
		$user.save()
		// Envoyer le mail
		
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="mail")
		If (Records in selection:C76([ModelesHTML:15])>0)
			$contenu:=[ModelesHTML:15]Detail:3
			$ContenuMail:=Replace string:C233($ContenuMail; "$PrenomNom$"; $user.Prenom+" "+$user.Nom)
			$ContenuMail:=Replace string:C233($ContenuMail; "$lien$"; $lien)
			$Contenu:=Replace string:C233($Contenu; "$ContenuMail$"; $ContenuMail)
			$Contenu:=Replace string:C233($Contenu; "\r"; "")
			$from:=$user.equipe.Email
			$reponse:=SendMail($from; $objetMail; $contenu; $Email; $user.Prenom+" "+$user.Nom)
			If ($reponse=200)
				$return:="Mail envoyé avec success"
			Else 
				$return:="Une erreur est survenue à l'envoi du mail"
			End if 
			//$return:=SendeMail_OnMandrill($from; $objetMail; $contenu; $Email)
		End if 
	Else 
		$return:="Erreur : l'adresse email n'est pas valide"
	End if 
Else 
	$return:="Erreur : Veuillez saisir une adresse email"
End if 
$0:=$return