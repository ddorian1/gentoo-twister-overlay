EAPI=5
inherit eutils

COMMIT="adc9e82f3a703920551339ffc4d764849f4a6ecf"

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
	./autotool.sh
	./configure
}

src_prepare() {
	epatch "${FILESDIR}/${PV}-db.h.patch"
}

src_compile() {
	emake
}

src_install() {
	mkdir -p "${D}usr/bin/"
	cp "${S}/twisterd" "${D}usr/bin/twisterd"
}
