# -*-makefile-*-
#
# Copyright (C) 2012 by Alexander Aring <aar@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_WPAN_TOOLS) += wpan-tools

#
# Paths and names
#
WPAN_TOOLS_VERSION	:= 0.1
WPAN_TOOLS_MD5		:= 0d4d5ad2285611c0c11d3319a9842667
WPAN_TOOLS		:= wpan-tools-$(WPAN_TOOLS_VERSION)
WPAN_TOOLS_SUFFIX	:= tar.gz
WPAN_TOOLS_URL		:= file://$(PTXDIST_WORKSPACE)/local_src/$(WPAN_TOOLS)
#WPAN_TOOLS_URL		:= https://github.com/linux-wpan/wpan-tools/archive/$(WPAN_TOOLS).$(WPAN_TOOLS_SUFFIX)
#WPAN_TOOLS_SOURCE	:= $(SRCDIR)/$(WPAN_TOOLS).$(WPAN_TOOLS_SUFFIX)
WPAN_TOOLS_DIR		:= $(BUILDDIR)/$(WPAN_TOOLS)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

WPAN_TOOLS_CONF_ENV = \
	$(CROSS_ENV)

#
# autoconf
#
WPAN_TOOLS_CONF_TOOL	:= autoconf
WPAN_TOOLS_CONF_OPT	:= \
	$(CROSS_AUTOCONF_USR) \
	--with-gnu-ld

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/wpan-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init, wpan-tools)
	@$(call install_fixup, wpan-tools,PRIORITY,optional)
	@$(call install_fixup, wpan-tools,SECTION,base)
	@$(call install_fixup, wpan-tools,AUTHOR,"Alexander Aring <aar@pengutronix.de>")
	@$(call install_fixup, wpan-tools,DESCRIPTION,missing)

	@$(call install_copy, wpan-tools, 0, 0, 0755, -, /usr/bin/iwpan)
	@$(call install_copy, wpan-tools, 0, 0, 0755, -, /usr/bin/wpan-ping)
#	@$(call install_copy, wpan-tools, 0, 0, 0755, -, /usr/bin/iwpan-store)
#	@$(call install_copy, wpan-tools, 0, 0, 0755, -, /usr/bin/iwpan-restore)

	@$(call install_finish, wpan-tools)

	@$(call touch)

# vim: syntax=make
