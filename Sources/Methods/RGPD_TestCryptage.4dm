//%attributes = {}
// RGPD_TestCryptage

//TOUT SÉLECTIONNER([EtatCivil])
//CHERCHER DANS SÉLECTION([EtatCivil]; [EtatCivil]ID<4)
//Boucle ($i; 1; Enregistrements trouvés([EtatCivil]))
//ALLER DANS SÉLECTION([EtatCivil]; $i)
//RGPD_AnonymiserTable(Table(->[EtatCivil]); ->[EtatCivil]BlobCrypted)
//STOCKER ENREGISTREMENT([EtatCivil])
//Fin de boucle 
