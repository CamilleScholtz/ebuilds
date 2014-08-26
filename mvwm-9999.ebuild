# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-r3 autotools eutils flag-o-matic

DESCRIPTION="Modern Virtual Window Manager - This is a clean-up effort of FVWM"
HOMEPAGE="https://github.com/ThomasAdam/mvwm"
SRC_URI=""

EGIT_REPO_URI="https://github.com/ThomasAdam/mvwm.git"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ppc ~ppc64 ~sparc x86 ~x86-fbsd"

IUSE="bidi doc nls perl png truetype vanilla"

DEPEND=""
RDEPEND="!x11-wm/fvwm !punpun/fvwm"

src_prepare() {
	if ! use vanilla; then
		epatch "${FILESDIR}/rounded.patch"
	fi
	eautoreconf
}

src_configure() {
	./autogen.sh || die "autogen failed"

	local myconf="" 

	econf \
		$(use_enable bidi) \
		$(use_enable doc htmldoc) \
		$(use_enable nls) \
		$(use_enable nls iconv) \
		$(use_enable perl perllib) \
		$(use_enable truetype xft) \		
		$(use_with png) \
		--docdir="/usr/share/doc/${P}"
}

src_install() {
	emake DESTDIR="${D}" install
}