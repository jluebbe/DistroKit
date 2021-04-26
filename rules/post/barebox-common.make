# ----------------------------------------------------------------------------
# oldconfig
# ----------------------------------------------------------------------------

ifneq ($(filter barebox-common_oldconfig,$(MAKECMDGOALS)),)
$(eval $(addsuffix _oldconfig,$(filter-out barebox-common, \
		$(filter barebox-%, $(PTX_PACKAGES_SELECTED)))): barebox-common_do_oldconfig$(ptx/nl))
endif

barebox-common_oldconfig: \
	$(addsuffix _oldconfig,$(filter-out barebox-common, \
		$(filter barebox-%, $(PTX_PACKAGES_SELECTED))))

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

$(STATEDIR)/barebox-common.clean: \
		$(addprefix $(STATEDIR)/, $(addsuffix .clean, \
			$(filter barebox-%, \ $(PTX_PACKAGES_SELECTED))))

# vim: syntax=make
