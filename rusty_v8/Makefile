PORTNAME=	rusty_v8
DISTVERSIONPREFIX=	v
DISTVERSION=	135.0.0
CATEGORIES=	devel
MASTER_SITES=	LOCAL/mikael/rusty_v8/:abseil \
		LOCAL/mikael/rusty_v8/:buildtools \
		LOCAL/mikael/rusty_v8/:fastfloat \
		LOCAL/mikael/rusty_v8/:highway \
		LOCAL/mikael/rusty_v8/:icu \
		LOCAL/mikael/rusty_v8/:partition \
		LOCAL/mikael/rusty_v8/:simdutf
DISTFILES=	abseil-${ABSEIL_REV}.tar.gz:abseil \
		buildtools-${BUILDTOOLS_REV}.tar.gz:buildtools \
		fastfloat-${FASTFLOAT_REV}.tar.gz:fastfloat \
		highway-${HIGHWAY_REV}.tar.gz:highway \
		icu-${ICU_REV}.tar.gz:icu \
		partition-${PARTITION_REV}.tar.gz:partition \
		simdutf-${SIMDUTF_REV}.tar.gz:simdutf

MAINTAINER=	mikael@FreeBSD.org
COMMENT=	Rust bindings for the V8 JavaScript engine
WWW=		https://github.com/denoland/rusty_v8

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	gn:devel/gn \
		${PYTHON_PKGNAMEPREFIX}Jinja2>0:devel/py-Jinja2@${PY_FLAVOR}

USES=		cargo cpe gnome llvm:min=16,build ninja:build pkgconfig:build python:3.9+,build

USE_GITHUB=	yes
GH_ACCOUNT=	denoland

USE_GNOME=	glib20

GH_TUPLE=	denoland:rusty_v8:${DISTVERSIONPREFIX}${DISTVERSION} \
		denoland:v8:${V8_REV}:v8 \
		denoland:chromium_build:${BUILD_REV}:build \
		Maratyszcza:FP16:${FP16_REV}:fp16

# git clone git@github.com:denoland/rusty_v8.git rusty_v8.git
# cd rusty_v8.git
# git checkout v135.0.0
# git submodule update --init --recursive
# git submodule status
ABSEIL_REV=	2705c6655c0008cc3fb152dae27890d44bc335f1
BUILD_REV=	d62828b93ca8ff189bcc58615ff2176b6232c143
BUILDTOOLS_REV=	b248db940ef3dd7e5f4694ebf4d8a3f67aa0086d
FASTFLOAT_REV=	cb1d42aaa1e14b09e1452cfdef373d051b8c02a4
FP16_REV=	0a92994d729ff76a58f692d3028ca1b64b145d91
HIGHWAY_REV=	00fe003dac355b979f36157f9407c7c46448958e
ICU_REV=	d30b7b0bb3829f2e220df403ed461a1ede78b774
PARTITION_REV=	46d880ff62f340854a5a70142b0abf604c7af221
SIMDUTF_REV=	5a9a2134b280c1b956ad68a0643797fe26dd1c94
V8_REV=		d5b5559004797d190e3b6aac57a90557098b0588

CARGO_ENV+=	CLANG_BASE_PATH=/usr \
		GN=${PREFIX}/bin/gn \
		NINJA=${NINJA_CMD} \
		V8_FROM_SOURCE=1 \
		RUSTC_BOOTSTRAP=yes \
		GN_ARGS="clang_use_chrome_plugins=false \
		fatal_linker_warnings=false \
		is_clang=true \
		treat_warnings_as_errors=false \
		use_custom_libcxx=false \
		use_lld=true \
		use_sysroot=false \
		use_udev=false"

PLIST_FILES=	lib/lib${PORTNAME}.a \
		${DATADIR}/src_binding_release_x86_64-unknown-freebsd.rs

BINARY_ALIAS=	python3=${PYTHON_CMD}

CARGO_INSTALL=	no

post-extract:
	${MV} ${WRKDIR}/abseil/* ${WRKSRC}/third_party/abseil-cpp
	${MV} ${WRKDIR}/buildtools ${WRKSRC}
	${MV} ${WRKDIR}/chromium_build-${BUILD_REV}/* ${WRKSRC}/build
	${MV} ${WRKDIR}/fastfloat/* ${WRKSRC}/third_party/fast_float/src
	${MV} ${WRKDIR}/highway/* ${WRKSRC}/third_party/highway/src
	${MV} ${WRKDIR}/icu ${WRKSRC}/third_party
	${MV} ${WRKDIR}/partition/* ${WRKSRC}/third_party/partition_alloc
	${MV} ${WRKDIR}/simdutf ${WRKSRC}/third_party
	${MV} ${WRKDIR}/FP16-${FP16_REV}/* ${WRKSRC}/third_party/fp16/src
	${MV} ${WRKDIR}/v8-${V8_REV}/* ${WRKSRC}/v8

do-install:
	${MKDIR} ${STAGEDIR}/${DATADIR}
	${INSTALL_PROGRAM} ${CARGO_TARGET_DIR}/release/gn_out/obj/librusty_v8.a ${STAGEDIR}${LOCALBASE}/lib
	${INSTALL_DATA} ${CARGO_TARGET_DIR}/release/gn_out/src_binding.rs ${STAGEDIR}${DATADIR}/src_binding_release_x86_64-unknown-freebsd.rs

.include <bsd.port.mk>
