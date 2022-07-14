//%attributes = {}
// RGPD_GenererCleCryptage

ALL RECORDS:C47([Keys:25])
If (Records in table:C83([Keys:25])=0)
	CREATE RECORD:C68([Keys:25])
Else 
	GOTO SELECTED RECORD:C245([Keys:25]; 1)
End if 
If ([Keys:25]TimeStampKeyPair:4="")
	GENERATE ENCRYPTION KEYPAIR:C688([Keys:25]PrivateKey:2; [Keys:25]PublicKey:3)
	[Keys:25]TimeStampKeyPair:4:=String:C10(Current date:C33)+" "+String:C10(Current time:C178)
	SAVE RECORD:C53([Keys:25])
	C_TIME:C306(vDoc)
	ALERT:C41("Document de clé publique")
	vDoc:=Create document:C266(""; ".txt")
	If (OK=1)
		CLOSE DOCUMENT:C267(vDoc)  // Fermer le document
		BLOB TO DOCUMENT:C526(Document; [Keys:25]PublicKey:3)
	End if 
	
	ALERT:C41("Document de clé privée")
	vDoc:=Create document:C266(""; ".txt")
	If (OK=1)
		CLOSE DOCUMENT:C267(vDoc)  // Fermer le document
		BLOB TO DOCUMENT:C526(Document; [Keys:25]PrivateKey:2)
	End if 
	
Else 
	ALERT:C41("Impossible. Certificat déja généré.")
End if 