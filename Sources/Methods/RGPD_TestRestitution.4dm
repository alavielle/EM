//%attributes = {}
// RGPD_TestREstitution

//TOUT SÉLECTIONNER([EtatCivil])
//CHERCHER DANS SÉLECTION([EtatCivil]; [EtatCivil]ID=14)
//Boucle ($i; 1; Enregistrements trouvés([EtatCivil]))
//ALLER DANS SÉLECTION([EtatCivil]; $i)
//RGPD_RestituerTable(Table(->[EtatCivil]); ->[EtatCivil]BlobCrypted)
//STOCKER ENREGISTREMENT([EtatCivil])
//Fin de boucle 