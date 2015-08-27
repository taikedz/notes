SSH Key Generation and Keyless Login
===

These notes assume two machines:

* commander - the machine from which you will connect
* target - the machine to which we are connecting to

## Generate your keys on commander

	$commander> ssh-keygen

Accept the default location, and enter a passphrase (twice)

This creates the identity of the user at this specific machine.

## Create .ssh on target

Create a new .ssh directory on target

	$target> mkdir -p ~/.ssh

We use -p in case the directory already exists.

## Updload keys

	$commander> cat .ssh/id_rsa.pub | ssh user@target 'cat >> .ssh/authorized_keys'

This copies the public signature for the user at the commander achine and adds it to the auth keys database

## Change perms

	$target> chmod 700 .ssh; chmod 640 .ssh/authorized_keys

According to tecmint this is due to SSH versions....?

# Login!

Now you can loogin without needing a password!

The private key is of course resident on the commander machine, the "/home/<user>/.sshd" file

## ToDo

Need to see if we can use different key encryption levels to increase the key level...
