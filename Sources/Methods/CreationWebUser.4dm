//%attributes = {}
// CreationWebUser


C_OBJECT:C1216($objEC)
C_TEXT:C284($Composant)
$Composant:=""
ARRAY TEXT:C222(tNoms; 0)
ARRAY TEXT:C222(tvaleurs; 0)
C_BLOB:C604($requete)
C_TEXT:C284($texteRequete)
WEB GET HTTP BODY:C814($requete)
WEB GET VARIABLES:C683(tNoms; tvaleurs)
If (Size of array:C274(tNoms)>0)
	$texteRequete:=BLOB to text:C555($requete; UTF8 texte sans longueur:K22:17)
	ARRAY OBJECT:C1221($sel; 0)
	JSON PARSE ARRAY:C1219(tNoms{1}; $sel)
	C_OBJECT:C1216($Obj)
	For ($i; 1; Size of array:C274($sel))
		$Obj:=$sel{$i}
		$vnom:=OB Get:C1224($Obj; "vnom"; Est un texte:K8:3)
		$vprenom:=OB Get:C1224($Obj; "vprenom"; Est un texte:K8:3)
		$vmail:=OB Get:C1224($Obj; "vmail"; Est un texte:K8:3)
		$type:=OB Get:C1224($Obj; "typeSelected"; Est un texte:K8:3)
		$IdRessort:=OB Get:C1224($Obj; "ressortSelected"; Est un entier long:K8:6)
		$IdConjoint:=OB Get:C1224($Obj; "conjointSelected"; Est un entier long:K8:6)
	End for 
	
	If ($vnom="")
		FindEmail($vmail)
	Else 
		$SharedEC:=Storage:C1525.SharedEtatCivil.query("Nom =:1 & Prenom =:2 & Type =:3"; $vnom; $vprenom; $type)
		If ($sharedEC#Null:C1517)
			Case of 
				: ($sharedEC.length>1)
					$Composant:="<div class="+Char:C90(34)+"alert alert-danger text-center my-3"+Char:C90(34)+">"
					$Composant:=$Composant+"Il existe plusieurs "+Lowercase:C14($type)+"s ayant les mêmes noms et prénoms</div>"
					ReturnSomething($Composant)
				: ($sharedEC.length=1)
					If ($sharedEC[0].Email="")
						Use (Storage:C1525.SharedEtatCivil)
							$sharedEC[0].Email:=$vemail
						End use 
					End if 
					QUERY:C277([EtatCivil:14]; [EtatCivil:14]ID:1=$sharedEC[0].ID)
					$codeDossier:=[EtatCivil:14]CodeDossier:30
					$codeFiscal:=[EtatCivil:14]ID_CodeFiscal:31
					If ($codeDossier="")
						$Composant:="<div class="+Char:C90(34)+"alert alert-danger text-center my-3"+Char:C90(34)+">"
						$Composant:=$Composant+"Il manque le code dossier ! L'identifiant n'a pas été crée.</div>"
						ReturnSomething($Composant)
					Else 
						If ($codeFiscal=0)
							$codeFiscal:=FoyerFiscalVerif($codeDossier)
						End if 
						NewWebUser($vmail; $vnom; $vprenom; 5; 0; $codeFiscal)
						ReturnSomething("OK")
					End if 
				Else 
					$Composant:="<div class="+Char:C90(34)+"alert alert-danger text-center my-3"+Char:C90(34)+">"
					$Composant:=$Composant+"Aucun "+Lowercase:C14($type)+" trouvé avec ces paramètres</div>"
					ReturnSomething($Composant)
			End case 
		End if 
	End if 
End if 