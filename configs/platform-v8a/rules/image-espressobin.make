#
# We provide this package
#
IMAGE_PACKAGES-$(PTXCONF_IMAGE_ESPRESSOBIN) += image-espressobin

#
# Paths and names
#
IMAGE_ESPRESSOBIN		:= image-espressobin
IMAGE_ESPRESSOBIN_DIR		:= $(BUILDDIR)/$(IMAGE_ESPRESSOBIN)
IMAGE_ESPRESSOBIN_IMAGE		:= $(IMAGEDIR)/espressobin.hdimg
IMAGE_ESPRESSOBIN_CONFIG	:= espressobin.config

# ----------------------------------------------------------------------------
# Image
# ----------------------------------------------------------------------------

$(IMAGE_ESPRESSOBIN_IMAGE):
	@$(call targetinfo)
	@$(call image/genimage, IMAGE_ESPRESSOBIN)
	@$(call finish)

# vim: syntax=make
