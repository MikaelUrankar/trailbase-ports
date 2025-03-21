PORTNAME=	trailbase
DISTVERSIONPREFIX=	v
DISTVERSION=	0.8.0
CATEGORIES=	databases

MAINTAINER=	mikael@FreeBSD.org
COMMENT=	Secure JavaScript and TypeScript runtime
WWW=		https://trailbase.io/

# OSL-3.0 license
#LICENSE=	MIT
#LICENSE_FILE=	${WRKSRC}/LICENSE.md

#BUILD_DEPENDS=	gn:devel/gn \
#		libunwind>0:devel/libunwind \
#		protoc:devel/protobuf
#LIB_DEPENDS=	libzstd.so:archivers/zstd \
#		libonig.so:devel/oniguruma

USES=		cargo cpe gmake gnome llvm:min=16,build ninja:build pkgconfig:build python:3.9+,build ssl

USE_GITHUB=	yes
GH_ACCOUNT=	trailbaseio
GH_TUPLE=	trailbaseio:trailbase:${DISTVERSIONPREFIX}${DISTVERSION} \
		trailbaseio:refinery:37ff038:refinery/vendor/refinery \
		trailbaseio:sqlean:66eb788:sqlean/vendor/sqlean/bundled/sqlean

#CARGO_ENV+=	RUSTY_V8_ARCHIVE=/usr/local/lib/librusty_v8.a
CARGO_ENV+=	RUSTY_V8_ARCHIVE=/home/miki/trailbase-ports/librusty_v8.a \
		RUSTY_V8_SRC_BINDING_PATH=/home/miki/trailbase-ports/src_binding_release_x86_64-unknown-freebsd.rs

# xxx chmod a+x tools/get_bindgen_args.py
# /home/stuff/trailbase/rusty_v8.git gn gen --ide=json /tmp

BINARY_ALIAS=	python3=${PYTHON_CMD}


do-install:
	${INSTALL_PROGRAM} ${CARGO_TARGET_DIR}/*/deno ${STAGEDIR}${LOCALBASE}/bin

.include <bsd.port.mk>
