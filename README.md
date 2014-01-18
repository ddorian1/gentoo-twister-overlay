Unofficial gentoo-twister-overlay
================================

A gentoo overlay for twister.
This overlay fetches the source from github, builds the twisterd and copies it to /usr/bin.

You can add the overlay to portage with:
	
	# layman -o https://raw.github.com/ddorian1/gentoo-twister-overlay/master/gentoo-twister-overlay.xml -a twister

And than install twister (and dependencies) with:

	# emerge -a twister

I only tested on amd64, but it should work on other platforms too.
