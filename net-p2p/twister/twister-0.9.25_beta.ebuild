EAPI=5
inherit eutils

COMMIT="c7e35d86a2e600452427f16f01ccadb955ed8864"

DESCRIPTION="Peer-to-peer microblogging"
HOMEPAGE="http://twister.net.co/"
SRC_URI="https://github.com/miguelfreitas/twister-core/archive/${COMMIT}.tar.gz"
RESTRICT="mirror"

LICENSE="MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/openssl[-bindist]
	sys-libs/db
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
	mkdir -p "${D}usr/bin/"
	cp "${S}/twisterd" "${D}usr/bin/twisterd"
}
