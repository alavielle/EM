//%attributes = {}
// SaveAssurance
// $1 : ID_EtatCivil
// $2 :  Collection ID_Assurance


C_COLLECTION:C1488($colAss)
$colAss:=New collection:C1472
$colAss:=$2
If ($colAss#Null:C1517)
	$colActuelle:=ds:C1482.Mutuelle.query("ID_EtatCivil = :1"; $1).extract("ID_Assurance")
	
	For each ($ass; $colAss)
		$mutuelle:=ds:C1482.Mutuelle.query("ID_EtatCivil = :1 & ID_Assurance = :2"; $1; $ass)
		If ($mutuelle.length=0)
			$newMutuelle:=ds:C1482.Mutuelle.new()
			$newMutuelle.ID_EtatCivil:=$1
			$newMutuelle.ID_Assurance:=Num:C11($ass)
			$newMutuelle.save()
		End if 
	End for each 
	For each ($col; $colActuelle)
		If ($colAss.indexOf(String:C10($col))<0)
			ds:C1482.Mutuelle.query("ID_EtatCivil = :1 & ID_Assurance =:2"; $1; $col).drop()
		End if 
	End for each 
End if 