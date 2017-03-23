EAPI=5
inherit eutils git-r3

DESCRIPTION="Peer-to-peer microblogging"
HOMEPAGE="http://twister.net.co/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/miguelfreitas/twister-core.git"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS=""
IUSE="tk"

RDEPEND="dev-libs/openssl:*[-bindist]
	sys-libs/db:4.8
	dev-libs/boost
	net-libs/miniupnpc
	tk? ( || ( dev-lang/python:2.7[tk] dev-lang/python:2.6[tk] ) )"

DEPEND="${RDEPEND}"

src_configure() {
	./bootstrap.sh CPPFLAGS="-fpermissive"
}

src_compile() {
	emake
}

src_install() {
	einstall

	rm -f "${D}/usr/share/applications/mimeinfo.cache"
	use tk || rm -fr "${D}/usr/share/pixmaps"
	use tk || rm -f "${D}/usr/bin/twister-control"
	use tk || rm -f "${D}/usr/share/applications/twister.desktop"

	exeinto "/usr/bin/"
	doexe "${FILESDIR}/twister-html-install"
	doexe "${FILESDIR}/twister-html-update"
}

pkg_postinst() {
	elog "Befor running twister, each user must set up twister's HTML files"
	elog "in ~/.twister/html and the configs in ~/.twister/twister.conf."
	elog "They can do this by running twister-html-install."
	elog ""
	elog "To keep the HTML files up to date, run twister-html-update."
}
