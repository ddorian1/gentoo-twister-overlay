EAPI=5
inherit eutils

COMMIT="9d3b0744ff2694f7d50981731d01ff3e0d86c3b1"

DESCRIPTION="Peer-to-peer microblogging"
HOMEPAGE="http://twister.net.co/"
SRC_URI="https://github.com/miguelfreitas/twister-core/archive/${COMMIT}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl[-bindist]
	sys-libs/db:4.8
	dev-libs/boost
	net-libs/miniupnpc"

DEPEND="${RDEPEND}"

S="${WORKDIR}/twister-core-${COMMIT}"

src_configure() {
	./bootstrap.sh
}

src_compile() {
	emake
}

src_install() {
	dodir "/usr/bin/"

	exeinto "/usr/bin"
	doexe "${S}/twisterd" 
	doexe "${FILESDIR}/twister-html-install"
	doexe "${FILESDIR}/twister-html-update"

	dodoc "${S}/README.md"
}

pkg_postinst() {
	elog "Befor running twister, each user must set up twister's HTML files"
	elog "in ~/.twister/html and the configs in ~/.twister/twister.conf."
	elog "They can do this by running twister-html-install."
	elog ""
	elog "To keep the HTML files up to date, run twister-html-update."
}
