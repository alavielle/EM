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
	QUERY SELECTION:C341([Bourse:12]; [Bourse:12]AnneeSco:2=[AnneeScolaire:21]AnneeSco:2)
	RELATE ONE SELECTION:C349([Bourse:12]; [EtatCivil:14])
	CREATE SET:C116([EtatCivil:14]; "$DejaBoursiers")
	DIFFERENCE:C122("$NonBoursiers"; "$DejaBoursiers"; "$NonBoursiers")
	USE SET:C118("$NonBoursiers")
	CLEAR SET:C117("$NonBoursiers")
	
	If (Records in selection:C76([EtatCivil:14])>0)
		ARRAY OBJECT:C1221($tabObj; 0)
		For ($i; 1; Records in selection:C76([EtatCivil:14]))
			$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; [EtatCivil:14]ID:1)[0]
			$NomPrenom:=$SharedEC.Nom+" "+$SharedEC.Prenom
			APPEND TO ARRAY:C911($tabObj; New object:C1471("UUID"; [EtatCivil:14]UUID:34; "NomPrenom"; $NomPrenom))
			NEXT RECORD:C51([EtatCivil:14])
		End for 
		$Composant:=JSON Stringify array:C1228($tabObj)
	End if 
	ReturnSomething($composant)
End if 