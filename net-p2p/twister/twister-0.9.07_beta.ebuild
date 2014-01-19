EAPI=5
inherit eutils

COMMIT="1df2b24f9088ebcbb1fe39902b4c608677c1462d"

DESCRIPTION="Peer-to-peer microblogging"
HOMEPAGE="http://twister.net.co/"
SRC_URI="https://github.com/miguelfreitas/twister-core/archive/${COMMIT}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl
	sys-libs/db
	dev-libs/boost
	net-libs/miniupnpc"

DEPEND="${RDEPEND}"

S="${WORKDIR}/twister-core-${COMMIT}"

src_configure() {
	cd "${S}/libtorrent"
	./bootstrap.sh
	econf --enable-logging --enable-debug --enable-dht

	cd "${S}"
	qmake BDB_INCLUDE_PATH=/usr/include/db4.8
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-twister-qt.pro.patch"
}

src_compile() {
	emake
}

src_install() {
	mkdir -p "${D}usr/bin/"
	cp "${S}/twisterd" "${D}usr/bin/twisterd"
}
