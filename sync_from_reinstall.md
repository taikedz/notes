# Sync from a reinstall

I recently had to reinstall a VM I had a fair bit of user data on, encrypted with LUKS and using LVM; these are some notes on the gotchas I encountered

After creating a new Ubuntu MATE 16.04 machine (the same distro as I had previosuly on the old VM), I wanted to copy over the contents from the old one. Both had been set up to be encrypted, and per this setting LVM is used.

After connecting the old disk to the new machine, I was faced with an interesting issue - after decrypting the sdb5 drive with

	cryptsetup luksOpen /dev/sdb5 sdb5_crypt

I noticed that both my new disk and my old disk had logical volumes named exactly the same .... dang.

I had to rename one of them - the procedure was as follows:

* poweroff, and re-insert the install DVD
* boot to "Try Ubuntu MATE" and open a terminal, `su` to root
* LUKS decrypt the old drive as above, and see that it was still using a VOlume Group called `ubuntu-mate-vg` (running `vgscan`)
* Rename the group: `vgrename ubuntu-mate-vg old-mate-vg`

The rename at this point is succesful - all that needs doing now is copying over the data:

	# remember, we are root
	mkdir oldbuntu newbuntu

	mount /dev/mapper/old-mate-vg/root oldbuntu

	cryptsetup luksOpen /dev/sda5 sda5_crypt
	mount /dev/mapper/ubuntu-mate-vg/root newbuntu

	# The final slash is important here !
	rsync --delete -av {old,new}buntu/home/username/

	# done !
	reboot

And at this point, I was able to remove the DVD and boot into my new system.... with all my old data retained !
