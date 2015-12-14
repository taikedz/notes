mkdir gpg-tests
cd gpg-tests/
gpg2 --gen-key
gpg2 --armor --export $EMAIL
gpg2 --gen-revoke $EMAIL
vim revocation_tkedziersk_secureworkscom
gpg2 --keyserver pgp.mit.edu --searchkeys search_params
gpg2 --import $THEM
gpg2 --fingerprint $THEM
vim testemail
gpg2 --encrypt --sign --armor -r $THEM -r $EMAIL testemail 
mkdir recipient
mv testemail.asc recipient/
cd recipient/
gpg2 testemail.asc 
vim testemail
gpg2 --armor --export $EMAIL
gpg2 --sign-key $THEM ; gpg2 --armor --export $THEM
