//%attributes = {}


Case of 
	: ($URL="@apireponse@")
		ARRAY TEXT:C222(tNoms; 0)
		ARRAY TEXT:C222(tvaleurs; 0)
		C_BLOB:C604($requete)
		C_TEXT:C284($texteRequete)
		WEB GET HTTP BODY:C814($requete)
		WEB GET VARIABLES:C683(tNoms; tvaleurs)
		C_TEXT:C284($JsonRecu)
		$JsonRecu:=""
		If (Size of array:C274(tNoms)>0)
			$texteRequete:=BLOB to text:C555($requete; UTF8 texte sans longueur:K22:17)
			ARRAY OBJECT:C1221($sel; 0)
			JSON PARSE ARRAY:C1219(tNoms{1}; $sel)
			C_OBJECT:C1216($Obj)
			For ($i; 1; Size of array:C274($sel))
				$Obj:=$sel{$i}
				$IdSeance:=OB Get:C1224($Obj; "idseance"; Est un entier long:K8:6)
				$IdStagiaire:=OB Get:C1224($Obj; "idstagiaire"; Est un entier long:K8:6)
				$NomPrenom:=OB Get:C1224($Obj; "NomPrenom")
				$Emargement:=OB Get:C1224($Obj; "Emargement")
				$TempsRetard:=OB Get:C1224($Obj; "TempsRetard"; Est un entier long:K8:6)
				$JsonRecu:=$JsonRecu+$NomPrenom+"/"+$Emargement+"/"+String:C10($TempsRetard)
				
			End for 
		Else 
			$JsonRecu:="OK"
		End if 
		ReturnSomething($JsonRecu; $Cookie)
End case 