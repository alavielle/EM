//%attributes = {}
//DecryptageBlob
//$1 : Ptr BlobDeCryptage

C_OBJECT:C1216($0)  //Objet contenant les etiquettes valeurs décryptées
QUERY:C277([Keys:25]; [Keys:25]TimeStampKeyPair:4#"")
//On decrypte
DECRYPT BLOB:C690($1->; [Keys:25]PublicKey:3)
$Confidential:=BLOB to text:C555($1->; UTF8 texte sans longueur:K22:17)
$0:=JSON Parse:C1218($Confidential)