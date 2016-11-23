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
PACKAGES-$(PTXCONF_LIBMLE) += libmle

#
# Paths and names
#
LIBMLE_VERSION	:= 0
LIBMLE_MD5	:=
LIBMLE		:= libmle-$(LIBMLE_VERSION)
LIBMLE_SUFFIX	:= 
LIBMLE_URL	:= file://$(PTXDIST_WORKSPACE)/local_src/$(LIBMLE)
#LIBMLE_SOURCE	:= $(SRCDIR)/$(LIBMLE).$(LIBMLE_SUFFIX)
LIBMLE_DIR	:= $(BUILDDIR)/$(LIBMLE)
LIBMLE_LICENSE	:= LGPL

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

LIBMLE_CONF_ENV = \
	$(CROSS_ENV)

#
# autoconf
#
LIBMLE_CONF_TOOL	:= autoconf
#LIBMLE_CONF_OPT		:= \
	$(CROSS_AUTOCONF_USR) \
	--disable-shared \
	--enable-static

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/libmle.targetinstall:
	@$(call targetinfo)

	@$(call install_init, libmle)
	@$(call install_fixup, libmle,PRIORITY,optional)
	@$(call install_fixup, libmle,SECTION,base)
	@$(call install_fixup, libmle,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, libmle,DESCRIPTION,missing)

	@$(call install_lib, libmle, 0, 0, 0644, libmle)

	@$(call install_copy, libmle, 0, 0, 0755, -, /usr/bin/mle-util)

	@$(call install_finish, libmle)

	@$(call touch)

# vim: syntax=make
