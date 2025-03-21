#!/bin/sh

abseil_url="https://chromium.googlesource.com/chromium/src/third_party/abseil-cpp.git/+archive/"
buildtools_url="https://chromium.googlesource.com/chromium/src/buildtools.git/+archive/"
fastfloat_url="https://chromium.googlesource.com/external/github.com/fastfloat/fast_float.git/+archive/"
highway_url="https://chromium.googlesource.com/external/github.com/google/highway.git/+archive/"
icu_url="https://chromium.googlesource.com/chromium/deps/icu.git/+archive/"
partition_url="https://chromium.googlesource.com/chromium/src/base/allocator/partition_allocator.git/+archive/"
simdutf_url="https://chromium.googlesource.com/chromium/src/third_party/simdutf/+archive/"

abseil_hash=$(awk /ABSEIL_REV/'{print $2}' Makefile)
buildtools_hash=$(awk /BUILDTOOLS_REV/'{print $2}' Makefile)
fastfloat_hash=$(awk /FASTFLOAT_REV/'{print $2}' Makefile)
highway_hash=$(awk /HIGHWAY_REV/'{print $2}' Makefile)
icu_hash=$(awk /ICU_REV/'{print $2}' Makefile)
partition_hash=$(awk /PARTITION_REV/'{print $2}' Makefile)
simdutf_hash=$(awk /SIMDUTF_REV/'{print $2}' Makefile)

mkdir -p dist_good

for c in abseil buildtools fastfloat highway icu partition simdutf
do
	hash=$(echo ${c}_hash)
	eval "hash=\$$hash"

	if [ ! -f /usr/ports/distfiles/${c}-${hash}.tar.gz ] && [ ! -f dist_good/${c}-${hash}.tar.gz ]; then
		url=$(echo ${c}_url)
		eval "url=\$$url"

		echo "Fetching ${url}${hash}.tar.gz"

		mkdir -p ${c}
		fetch -qo - ${url}${hash}.tar.gz | tar xf - -C ${c}
		tar czf dist_good/${c}-${hash}.tar.gz ${c}
		rm -rf ${c}
	fi
done

echo "Copy dist_good/* in /usr/ports/distfiles and run make makesum"


# mandatory:
# abseil
# fast_float
# fp16
# googletest (not a git submodule)
# highway
# icu
# partition_allocator
# simdutf

# not needed:
# jinja2
# libc++
# libc++abi
# libunwind
# llvm-libc
# markupsafe

#clang_url="https://chromium.googlesource.com/chromium/src/tools/clang.git/+archive/"
#jinja2_url="https://chromium.googlesource.com/chromium/src/third_party/jinja2.git/+archive/"
#libc_url="https://chromium.googlesource.com/external/github.com/llvm/llvm-project/libc.git/+archive/"
#libcxx_url="https://chromium.googlesource.com/external/github.com/llvm/llvm-project/libcxx.git/+archive/"
#libcxxabi_url="https://chromium.googlesource.com/external/github.com/llvm/llvm-project/libcxxabi.git/+archive/"
#libunwind_url="https://chromium.googlesource.com/external/github.com/llvm/llvm-project/libunwind.git/+archive/"
#markupsafe_url="https://chromium.googlesource.com/chromium/src/third_party/markupsafe.git/+archive/"

#clang_hash=$(awk /CLANG_REV/'{print $2}' Makefile)
#jinja_hash=$(awk /JINJA_REV/'{print $2}' Makefile)
#libc_hash=$(awk /LIBC_REV/'{print $2}' Makefile)
#libcxx_hash=$(awk /LIBCXX_REV/'{print $2}' Makefile)
#libcxxabi_hash=$(awk /LIBCXXABI_REV/'{print $2}' Makefile)
#libunwind_hash=$(awk /LIBUNWIND_REV/'{print $2}' Makefile)
#markupsafe_hash=$(awk /MARKUPSAFE_REV/'{print $2}' Makefile)
