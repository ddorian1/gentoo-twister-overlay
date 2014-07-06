Unofficial gentoo-twister-overlay
=================================

A gentoo overlay for twister.
This overlay fetches the source from github, builds the twisterd and copies it to /usr/bin.

First install layman if you don't have already:

	# emerge -a layman
	# echo "source /var/lib/layman/make.conf" >> /etc/portage/make.conf

(See http://wiki.gentoo.org/wiki/Layman for further instructions.)

Then you can activate the overlay with:
	
	# layman -a twister

And install twister (and dependencies) with:

	# emerge -a twister

I only tested on amd64, but it should work on other platforms too.
