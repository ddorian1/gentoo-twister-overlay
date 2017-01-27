EAPI=5
inherit eutils

COMMIT="54b1d9e9a3865462257944f5010abd6d42ea28bd"

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
	dev-libs/boost:0/1.56.0
	net-libs/miniupnpc
	tk? ( || ( dev-lang/python:2.7[tk] dev-lang/python:2.6[tk] ) )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/twister-core-${COMMIT}"

src_configure() {
	./bootstrap.sh
}

src_compile() {
	emake
}

src_install() {
	einstall

	use tk || rm -f "${D}/usr/bin/twister-control"
	use tk || rm -f "${D}/usr/share/applications/twister-control.desktop"

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
