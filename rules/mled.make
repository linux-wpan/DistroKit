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
PACKAGES-$(PTXCONF_MLED) += mled

#
# Paths and names
#
MLED_VERSION	:= 0
MLED_MD5	:=
MLED		:= mled-$(MLED_VERSION)
MLED_SUFFIX	:= 
MLED_URL	:= file://$(PTXDIST_WORKSPACE)/local_src/$(MLED)
#MLED_SOURCE	:= $(SRCDIR)/$(MLED).$(MLED_SUFFIX)
MLED_DIR	:= $(BUILDDIR)/$(MLED)
MLED_LICENSE	:= BSD

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

MLED_CONF_ENV	:= $(CROSS_ENV)

#
# autoconf
#
MLED_CONF_TOOL	:= autoconf
MLED_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--without-check

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/mled.targetinstall:
	@$(call targetinfo)

	@$(call install_init, mled)
	@$(call install_fixup, mled,PRIORITY,optional)
	@$(call install_fixup, mled,SECTION,base)
	@$(call install_fixup, mled,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, mled,DESCRIPTION,missing)

	@$(call install_copy, mled, 0, 0, 0755, -, /usr/sbin/mled)
	@$(call install_copy, mled, 0, 0, 0755, -, /usr/sbin/mledump)
#	@$(call install_alternative, mled, 0, 0, 0644, /etc/mled.conf)

	@$(call install_finish, mled)

	@$(call touch)

# vim: syntax=make
