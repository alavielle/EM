//%attributes = {}
//DepotDossier
//$1 : UUID
//$2 : bourseID

C_TEXT:C284($1)
C_LONGINT:C283($2; $BourseID)
C_OBJECT:C1216($Obj)
C_TEXT:C284($Composant; $bugetMensuel; $selectRepresLegal; $selectClasse)
If ($1="")
	GetBoursiers(Session:C1714.storage.clientUuid.value)
Else 
	$etatcivil:=ds:C1482.EtatCivil.query("UUID = :1"; $1).first()
	If ($etatcivil#Null:C1517)
		$Obj:=$etatcivil.toObject()
		OB REMOVE:C1226($obj; "BlobCrypted")
		$SharedEC:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID)[0]
		If ($SharedEC#Null:C1517)
			OB SET:C1220($Obj; "Nom"; $SharedEC.Nom)
			OB SET:C1220($Obj; "NomNaissance"; $SharedEC.NomNaissance)
			OB SET:C1220($Obj; "DateNaissance"; $SharedEC.DateNaissance)
			OB SET:C1220($Obj; "CP"; $SharedEC.CP)
			OB SET:C1220($Obj; "Ville"; $SharedEC.Ville)
			OB SET:C1220($Obj; "Tel"; $SharedEC.Tel)
			OB SET:C1220($Obj; "Email"; $SharedEC.Email)
		End if 
		
		//  On fixe l'année scolaire à l'année courante
		QUERY:C277([AnneeScolaire:21]; [AnneeScolaire:21]Courante:3=True:C214)
		$AnneeSco:=[AnneeScolaire:21]AnneeSco:2
		$id_AnneeSco:=[AnneeScolaire:21]ID:1
		OB SET:C1220($Obj; "AnneeSco"; $AnneeSco)
		
		// On commence à 3 pour ne pas insérer l'ID ni l'année scolaire (conflit sur les étiquettes) 
		GET FIELD TITLES:C804([Bourse:12]; $titresChamps; $numChamps)
		For ($i; 3; Size of array:C274($titresChamps))
			OB SET:C1220($Obj; $titresChamps{$i}; "")
		End for 
		
		$scolarite:=ds:C1482.Scolarite.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $etatcivil.ID; $id_anneeSco)
		If ($scolarite.length>0)
			OB SET:C1220($Obj; "ID_NiveauEtude"; $scolarite[0].classe.niveau.ID)
			OB SET:C1220($Obj; "ID_Classe"; $scolarite[0].classe.ID)
			OB SET:C1220($Obj; "Filiere"; $scolarite[0].Filiere)
		Else 
			OB SET:C1220($obj; "ID_Classe"; 0)
			OB SET:C1220($obj; "ID_NiveauEtude"; 0)
		End if 
		
		//Pour la table assurance
		$mutuelles:=ds:C1482.Mutuelle.query("ID_EtatCivil = :1 "; $etatcivil.ID)
		
		If ($mutuelles.length>0)
			C_COLLECTION:C1488($col)
			$col:=New collection:C1472()
			For each ($mutuelle; $mutuelles)
				$col.push($mutuelle.ID_Assurance)
			End for each 
			OB SET:C1220($Obj; "Assurances"; $col)
		End if 
		
		//Pour les frais de scolarité
		$frais:=ds:C1482.Frais.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $etatcivil.ID; $id_anneeSco)
		If ($frais.length>0)
			For each ($ligne; $frais)
				OB SET:C1220($Obj; "Frais"+String:C10($ligne.ID_Ligne; "00"); $ligne.Montant)
			End for each 
		End if 
		
		//Pour le budget mensuel
		$budget:=ds:C1482.Budget.query("ID_EtatCivil = :1 & ID_AnneeSco = :2"; $etatcivil.ID; $id_anneeSco)
		If ($budget.length>0)
			For each ($ligne; $budget)
				OB SET:C1220($Obj; "Budget"+String:C10($ligne.ID_Ligne; "00"); $ligne.Montant)
			End for each 
		End if 
		
		//On crée un nouvel enregistrement ds la table bourse s'il n'existe pas
		If (Count parameters:C259=2)
			$BourseID:=$2
		Else 
			QUERY:C277([Bourse:12]; [Bourse:12]ID_Boursier:8=$EtatCivil.ID; *)
			QUERY:C277([Bourse:12];  & ; [Bourse:12]ID_AnneeSco:2=$id_AnneeSco)
			If (Records in selection:C76([Bourse:12])=1)
				$BourseID:=[Bourse:12]ID:1
			Else 
				$BourseID:=NewBourse($EtatCivil.ID; $id_AnneeSco)
			End if 
		End if 
		$bourse:=ds:C1482.Bourse.query("ID = :1"; $BourseID).first()
		If ($bourse.Renouvellement=True:C214)
			OB SET:C1220($Obj; "RenouvellementVrai"; $bourse.Renouvellement)
		Else 
			OB SET:C1220($Obj; "RenouvellementFaux"; True:C214)
		End if 
		
		$Composant:=JSON Stringify:C1217($obj)
		
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="dossier_candidat")
		$contenu:=[ModelesHTML:15]Detail:3
		UNLOAD RECORD:C212([ModelesHTML:15])
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="etat_civil_base")
		$etatCivil_base:=[ModelesHTML:15]Detail:3
		UNLOAD RECORD:C212([ModelesHTML:15])
		$assurance_base:=SelectAssurance()
		$scolarite_base:=SelectScolarite($obj.ID_Classe; $obj.ID_NiveauEtude)
		
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="frais_scolarite_base")
		$frais_scolarite_base:=[ModelesHTML:15]Detail:3
		UNLOAD RECORD:C212([ModelesHTML:15])
		
		$ComposantFrais:=HTML_LigneFrais()
		$frais_scolarite_base:=Replace string:C233($frais_scolarite_base; "$LignesFrais$"; $ComposantFrais)
		
		//Si ($etatcivil.IndependantFiscal=Vrai)
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="budget_mensuel")
		$budgetMensuel:=[ModelesHTML:15]Detail:3
		UNLOAD RECORD:C212([ModelesHTML:15])
		$ComposantBudget:=HTML_LigneBudget()
		$budgetMensuel:=Replace string:C233($budgetMensuel; "$Lignes_budget_mensuel$"; $ComposantBudget)
		//Sinon
		
		C_COLLECTION:C1488($myCol)
		ARRAY LONGINT:C221($tabIdEC; 0)
		ARRAY TEXT:C222($tabLibEC; 0)
		If ($etatcivil.ressortissant.Decede=False:C215)
			$ressort:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID_Ressortissant)[0]
			APPEND TO ARRAY:C911($tabIdEC; $ressort.ID)
			APPEND TO ARRAY:C911($tabLibEC; $ressort.Nom+" "+$ressort.Prenom)
		End if 
		If ($etatcivil.conjoint.Decede=False:C215)
			$conjoint:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID_Conjoint)[0]
			APPEND TO ARRAY:C911($tabIdEC; $conjoint.ID)
			APPEND TO ARRAY:C911($tabLibEC; $conjoint.Nom+" "+$conjoint.Prenom)
		End if 
		If ($etatcivil.ID_Tuteur>0)
			$tuteur:=Storage:C1525.SharedEtatCivil.query("ID = :1"; $etatcivil.ID_Tuteur)[0]
			APPEND TO ARRAY:C911($tabIdEC; $tuteur.ID)
			APPEND TO ARRAY:C911($tabLibEC; $tuteur.Nom+" "+$tuteur.Prenom)
		End if 
		APPEND TO ARRAY:C911($tabIdEC; 0)
		APPEND TO ARRAY:C911($tabLibEC; "Autre")
		$myCol:=New collection:C1472
		ARRAY TO COLLECTION:C1563($myCol; $tabIdEC; "ID"; $tabLibEC; "NomPrenom")
		
		C_OBJECT:C1216($ComposantProperties)
		OB SET:C1220($ComposantProperties; "onchange"; "Oui")
		OB SET:C1220($ComposantProperties; "onchangemethod"; "popRepresLegalSelected")
		C_OBJECT:C1216($ParamSelect)
		OB SET:C1220($ParamSelect; "Required"; "Faux")
		OB SET:C1220($ParamSelect; "LigneVide"; "Faux")
		OB SET:C1220($ParamSelect; "LigneChoisir"; " ")
		OB SET:C1220($ParamSelect; "Disabled"; "Faux")
		OB SET:C1220($ParamSelect; "Hidden"; "Faux")
		OB SET:C1220($ParamSelect; "Multiple"; "Faux")
		$composantRepresLegal:=HTML_Select_Collection(""; "ID_RepresLegal"; $myCol.extract("ID"); $myCol.extract("NomPrenom"); $ComposantProperties; ""; $ParamSelect)
		
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="representant_legal")
		$selectRepresLegal:=[ModelesHTML:15]Detail:3
		UNLOAD RECORD:C212([ModelesHTML:15])
		$selectRepresLegal:=Replace string:C233($selectRepresLegal; "$selectRepresLegal$"; $composantRepresLegal)
		//Fin de si 
		
		QUERY:C277([ModelesHTML:15]; [ModelesHTML:15]Titre:2="navBar")
		$navBar:=[ModelesHTML:15]Detail:3
		UNLOAD RECORD:C212([ModelesHTML:15])
		$prenomNom:=Session:C1714.userName
		$navBar:=Replace string:C233($navBar; "$prenomNom$"; $prenomNom)
		$Contenu:=Replace string:C233($Contenu; "$navBar$"; $navBar)
		
		$Contenu:=Replace string:C233($Contenu; "$etat_civil_base$"; $etatCivil_base)
		$Contenu:=Replace string:C233($Contenu; "$assurance_base$"; $assurance_base)
		$Contenu:=Replace string:C233($Contenu; "$scolarite_base$"; $scolarite_base)
		$Contenu:=Replace string:C233($Contenu; "$frais_scolarite_base$"; $frais_scolarite_base)
		$Contenu:=Replace string:C233($Contenu; "$budget_mensuel$"; $budgetMensuel)
		$Contenu:=Replace string:C233($Contenu; "$selectRepresLegal$"; $selectRepresLegal)
		$Contenu:=Replace string:C233($Contenu; "$AnneeSco$"; $AnneeSco)
		$Contenu:=Replace string:C233($Contenu; "$Data$"; $Composant)
		$Contenu:=Replace string:C233($Contenu; "$BourseID$"; String:C10($BourseID))
		
		WEB SEND TEXT:C677($Contenu; "text/html")
		
	End if 
End if 