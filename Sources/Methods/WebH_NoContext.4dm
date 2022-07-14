//%attributes = {}
//WebH_NoContext

C_TEXT:C284($1; $2; $3; $4; $5; $6)
$URL:=$1
$Browser:=$2
$BrowserIP:=$3
$ServerIP:=$4
$name:=$5
$password:=$6
var $cookie : Text
$Cookie:="Access-Control-Allow-Headers: Access-Control-Allow-Origin"
WEB SET HTTP HEADER:C660($Cookie)  //Allow Cross Domain

$Cookie:="Access-Control-Allow-Headers: X-Requested-With, X-Prototype-Version, Content-Disposition, Cache-Control, Content-Type"
WEB SET HTTP HEADER:C660($Cookie)  //Allow Cross Domain

$Cookie:="Access-Control-Allow-Origin: *"
WEB SET HTTP HEADER:C660($Cookie)  //Allow Cross Domain

ARRAY TEXT:C222(tabNoms; 0)
ARRAY TEXT:C222(tabValeurs; 0)
C_TEXT:C284($index)
C_LONGINT:C283($id)
// Enregistre toutes les connections
WebDebugger($URL; False:C215)
READ ONLY:C145(*)
//L'utilisateur est-il connecté ?
// A-t-il la permission ?

If (Identify)
	Case of 
		: ($URL="/deconnexion")
			Connexion("")
			
		: ($URL="/menu")
			$ptrPermission:=->[Privilege:4]Menu:3
			$index:=Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)
			QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2=$index)
			If (Records in selection:C76([ModelesHTML:15])>0)
				$contenu:=[ModelesHTML:15]Detail:3
				If (IsAdmin(Session:C1714.storage.clientUuid.value))
					$display:=""
				Else 
					$display:="hidden"
				End if 
				$Contenu:=Replace string:C233($Contenu; "$display$"; $display)
				WEB SEND TEXT:C677($Contenu; "text/html")
				UNLOAD RECORD:C212([ModelesHTML:15])
			Else 
				WEB SEND HTTP REDIRECT:C659("/404.shtml")
			End if 
			
		: ($URL="/Gestion")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="menu_gestion")
				$contenu:=[ModelesHTML:15]Detail:3
				WEB SEND TEXT:C677($Contenu; "text/html")
				UNLOAD RECORD:C212([ModelesHTML:15])
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Compte")
			FindCompte(Session:C1714.storage.clientUuid.value)
			
		: ($URL="/Bourse")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				GetBourses(Session:C1714.storage.clientUuid.value)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="@/Parent/@")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "Parent/"; "")
				FindParent($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="@/Famille/@")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "Parent/"; "")
				FindFamille($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="@/Ressource/@")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "Ressource/"; "")
				FillRessource($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
			
		: ($URL="@/Justificatif/@")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "Justificatif/"; "")
				FillJustificatif($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
			
		: ($URL="/Bourse/@")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$id:=Num:C11(Replace string:C233($URL; "/Bourse/"; ""))
				FindBourse($id)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Dossier/Saisie")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="dossier_saisie")
				If (Records in selection:C76([ModelesHTML:15])>0)
					$contenu:=[ModelesHTML:15]Detail:3
					WEB SEND TEXT:C677($Contenu; "text/html")
					UNLOAD RECORD:C212([ModelesHTML:15])
				Else 
					WEB SEND HTTP REDIRECT:C659("/404.shtml")
				End if 
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Dossier/Depot")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				GetBoursiers(Session:C1714.storage.clientUuid.value)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Dossier/Depot/@")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Dossier/Depot/"; "")
				DepotDossier($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Classe/@")
			$id:=Num:C11(Replace string:C233($URL; "/Classe/"; ""))
			GetClasses($id)
			
		: ($URL="/Dossiers")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				GetDossiers(Session:C1714.storage.clientUuid.value)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/WebUtilisateur/Nouveau")
			If (IsAdmin(Session:C1714.storage.clientUuid.value))
				GetWebUser
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/CreationWebUtilisateur")
			If (IsAdmin(Session:C1714.storage.clientUuid.value))
				CreationWebUser
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/FindEtatCivil/@")
			$ptrPermission:=->[Privilege:4]Zone_EtatCivil:5
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/FindTheEtatCivil/"; "")
				$composant:=FindPartOfEtatCivilById($index)
				ReturnSomething($composant)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Received/EtatCivil/@")
			$ptrPermission:=->[Privilege:4]Zone_EtatCivil:5
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$id:=Num:C11(Replace string:C233($URL; "/Received/EtatCivil/"; ""))
				$Composant:=SauvegarderEtatCivil($id)
				ReturnSomething($composant)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/FoyerFiscal")
			$ptrPermission:=->[Privilege:4]Zone_Bourse:6
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				CompoFoyerFiscal(Session:C1714.storage.clientUuid.value)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/FindFoyerFiscal/@")
			$ptrPermission:=->[Privilege:4]Zone_EtatCivil:5
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/FindFoyerFiscal/"; "")
				FindFoyerFiscal($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: (($URL="/Ressortissant") | ($URL="/Conjoint") | ($URL="/Enfant") | ($URL="/Tuteur") | ($URL="/Autre") | ($URL="/Asso"))
			$ptrPermission:=->[Privilege:4]Zone_EtatCivil:5
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/"; "")
				GetBeneficiaires($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: (($URL="/Ressortissant/@") | ($URL="/Conjoint/@") | ($URL="/Enfant/@") | ($URL="/Tuteur/@") | ($URL="/Autre/@") | ($URL="/Asso/@"))
			$ptrPermission:=->[Privilege:4]Zone_EtatCivil:5
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Substring:C12($URL; 2; Length:C16($URL))
				FillEtatCivil($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Assurances/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Assurances/"; "")
				CrudAssurance($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Documents/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Documents/"; "")
				CrudDocument($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/LignesRessources/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/LignesRessources/"; "")
				CrudLigneRessource($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/LigneBudget/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/LigneBudget/"; "")
				CrudLigneBudget($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/LignesFrais/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/LignesFrais/"; "")
				CrudLigneFrais($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
			
		: ($URL="/AutresRessources/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/AutresRessources/"; "")
				CrudAutreRessource($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Grades/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Grades/"; "")
				CrudGrade($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Secteurs/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Secteurs/"; "")
				CrudSecteur($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/CED/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/CED/"; "")
				CrudCED($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Classes/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Classes/"; "")
				CrudClasse($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/MontantsParts/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/MontantsParts/"; "")
				CrudMontantPart($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/AnneesScolaires/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/AnneesScolaires/"; "")
				CrudAnneeSco($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Compta/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Compta/"; "")
				CrudCompta($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Poles/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Poles/"; "")
				CrudPoleSocial($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/AffectationDept/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/AffectationDept/"; "")
				CrudAffectationDept($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Privileges/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Privileges/"; "")
				CrudPrivilege($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/EquipesSociales/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/EquipesSociales/"; "")
				CrudEquipeSociale($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Paliers/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Paliers/"; "")
				CrudPalier($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/Seuil/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/Seuil/"; "")
				CalculNvSeuils($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		: ($URL="/WebUsers/@")
			$ptrPermission:=->[Privilege:4]Zone_Parametre:4
			If (Permission(Session:C1714.storage.clientUuid.value; $ptrPermission)#"NoAccess")
				$index:=Replace string:C233($URL; "/WebUsers/"; "")
				CrudWebUser($index)
			Else 
				WEB SEND HTTP REDIRECT:C659("/403.shtml")
			End if 
			
		Else 
			WEB SEND HTTP REDIRECT:C659("/404.shtml")
	End case 
Else 
	Case of 
		: ($URL="/login")
			Login
			
		: ($URL="/oubli_pwd/@")
			$index:=Replace string:C233($URL; "/oubli_pwd/"; "")
			Oubli_pwd($index)
			
		: ($URL="/reinit_pwd/@")
			$index:=Replace string:C233($1; "/reinit_pwd/"; "")
			Reinit_pwd($index)
			
		: ($URL="/NewPassword")
			NewPassword
			
		Else 
			Connexion("")
			
	End case 
End if 
