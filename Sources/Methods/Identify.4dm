//%attributes = {}
// Identify : Teste à chaque appel si l'utilisateur est authentifié et connecté

// Contenu de l’en-tête Cookie
$0:=False:C215
$cookHTTP:=GetHTTPField("cookie")
Use (Session:C1714.storage)
	$cookSession:=Session:C1714.storage.clientUuid.value
End use 
If ($cookSession#Null:C1517)
	If ($cookHTTP%$cookSession)
		$user:=ds:C1482.WebUser.query("UUID = :1"; $cookSession).first()
		If (DateToEpoch($user.TimeStamp)+3600>DateToEpoch(Timestamp:C1445))
			$user.TimeStamp:=Timestamp:C1445
			$user.save()
			$0:=True:C214
		End if 
	End if 
End if 

