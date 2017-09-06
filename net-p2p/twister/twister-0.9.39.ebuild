EAPI=5
inherit eutils

COMMIT="6b157f10c05f22a1999551746f9dd40980019bce"

DESCRIPTION="Peer-to-peer microblogging"
HOMEPAGE="http://twister.net.co/"
SRC_URI="https://github.com/miguelfreitas/twister-core/archive/${COMMIT}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tk"

RDEPEND="dev-libs/openssl:*[-bindist]
	sys-libs/db:4.8
	dev-libs/boost
	net-libs/miniupnpc
	tk? ( || ( dev-lang/python:2.7[tk] dev-lang/python:2.6[tk] ) )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/twister-core-${COMMIT}"

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
	use tk || rm -fr "${D}/usr/share/applications"

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
