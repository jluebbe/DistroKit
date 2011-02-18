#
# This is an example rule file to install some kind of binary data only.
# Only the targetinstall stage will do something. All other stages are skipped.
# Nothing has to be built at compile time, the files are expected ready for use
# as part of the BSP.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_BINARY_EXAMPLE) += binary_example

#
# Paths and names
#
BINARY_EXAMPLE_VERSION := 1

# ----------------------------------------------------------------------------
# omit the 'get' stage (due to the fact, the files are already present)
# ----------------------------------------------------------------------------

$(STATEDIR)/binary_example.get:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'extract' stage (due to the fact, all files are already present)
# ----------------------------------------------------------------------------

$(STATEDIR)/binary_example.extract:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'prepare' stage (due to the fact, nothing is to be built)
# ----------------------------------------------------------------------------

$(STATEDIR)/binary_example.prepare:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'compile' stage (due to the fact, nothing is to be built)
# ----------------------------------------------------------------------------

$(STATEDIR)/binary_example.compile:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# omit the 'install' stage (due to the fact, nothing is to be installed into the sysroot)
# ----------------------------------------------------------------------------

$(STATEDIR)/binary_example.install:
		@$(call targetinfo)
		@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/binary_example.targetinstall:
	@$(call targetinfo)
	
	@$(call install_init, binary_example)
	@$(call install_fixup, binary_example,PACKAGE,binary_example)
	@$(call install_fixup, binary_example,PRIORITY,optional)
	@$(call install_fixup, binary_example,VERSION,$(BINARY_EXAMPLE_VERSION))
	@$(call install_fixup, binary_example,SECTION,base)
	@$(call install_fixup, binary_example,AUTHOR,"Juergen Beisert <jbe@pengutronix.de>")
	@$(call install_fixup, binary_example,DEPENDS,)
	@$(call install_fixup, binary_example,DESCRIPTION,"A few binary example files")

#
# Install the single binary file on demand
#
ifdef PTXCONF_BINARY_EXAMPLE_FILE
	@$(call install_copy, binary_example, 0, 0, 0755, /example)
	@$(call install_copy, binary_example, 0, 0, 0644, \
		$(PTXDIST_WORKSPACE)/local_src/binary_example/ptx_logo.png, \
		/example/ptx_logo.png)
endif

#
# Install the whole archive on demand
#
ifdef PTXCONF_BINARY_EXAMPLE_ARCHIVE
	@$(call install_archive, binary_example, -, -, \
		$(PTXDIST_WORKSPACE)/local_src/archive_example/pictures.tgz, \
		/)
# note: the third parameter is the 'user id', the forth parameter the 'group id'.
# If given as '-', the ID from the archive is used. If given as number, this
# number is used, instead of the ID in the archive.
endif

	@$(call install_finish, binary_example)
	@$(call touch)
