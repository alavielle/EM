//%attributes = {}
// RGPD_CryptageChamp

//Si (Taille BLOB($1->)>0)
//CHERCHER([Keys]; [Keys]TimeStampKeyPair#"")
//Si ($2)
//CRYPTER BLOB($1->; [Keys]PrivateKey)  //On crypte le blob
//Sinon 
//DECRYPTER BLOB($1->; [Keys]PublicKey)
//Fin de si 
//LIBÉRER ENREGISTREMENT([Keys])
//Fin de si 