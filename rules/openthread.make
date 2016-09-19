# -*-makefile-*-
#
# Copyright (C) 2016 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_OPENTHREAD) += openthread

#
# Paths and names
#
OPENTHREAD_VERSION	:= 1
OPENTHREAD_MD5		:= 26dab4db44e89e98f1ad4a20ff09b74a
OPENTHREAD		:= openthread-$(OPENTHREAD_VERSION)
#OPENTHREAD_SUFFIX	:= tar.gz
#OPENTHREAD_URL	:= https://github.com/RIOT-OS/RIOT/archive/$(RIOT_OS_VERSION).$(RIOT_OS_SUFFIX)
#OPENTHREAD_SOURCE	:= $(SRCDIR)/$(RIOT_OS).$(RIOT_OS_SUFFIX)
#OPENTHREAD_DIR	:= $(BUILDDIR)/$(RIOT_OS)
OPENTHREAD_DIR		:= $(PTXDIST_WORKSPACE)/local_src/$(OPENTHREAD)
OPENTHREAD_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
OPENTHREAD_CONF_TOOL	:= NO
OPENTHREAD_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-cli \
	--enable-ncp \
	--enable-diag \
	--enable-af-packet \
	--with-examples=posix \
	--with-platform-info=POSIX \
	--disable-tests


$(STATEDIR)/openthread.prepare:
	@$(call targetinfo)
	@$(call clean, $(OPENTHREAD_DIR)/config.cache)
	cd $(OPENTHREAD_DIR) && \
		./bootstrap
	@$(call touch)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

$(STATEDIR)/openthread.compile:
	@$(call targetinfo)
	cd $(OPENTHREAD_DIR) && \
		make -f examples/Makefile-posix AUTOCONF_OPTIONS='$(OPENTHREAD_CONF_OPT)'
	@$(call touch)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openthread.install:
	@$(call targetinfo)
	install -D -m 755 "$(OPENTHREAD_DIR)/output/x86_64-unknown-linux-gnu/bin/ot-cli" \
		"$(OPENTHREAD_PKGDIR)/usr/share/openthread/ot-cli"
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/openthread.targetinstall:
	@$(call targetinfo)

	@$(call install_init, openthread)
	@$(call install_fixup, openthread,PRIORITY,optional)
	@$(call install_fixup, openthread,SECTION,base)
	@$(call install_fixup, openthread,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, openthread,DESCRIPTION,missing)

	@$(call install_copy, openthread, 0, 0, 0755, -, \
		/usr/share/openthread/ot-cli)

	@$(call install_finish, openthread)

	@$(call touch)

# vim: syntax=make
