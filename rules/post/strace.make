$(warning Note: strace version overwritten as temporary workaround)
STRACE_VERSION	:= 5.8
STRACE_MD5	:= 1a808c5917f0d91169e377c90faee6dd
STRACE		:= strace-$(STRACE_VERSION)
STRACE_URL	:= https://strace.io/files/$(STRACE_VERSION)/$(STRACE).$(STRACE_SUFFIX)
STRACE_SOURCE	:= $(SRCDIR)/$(STRACE).$(STRACE_SUFFIX)
STRACE_DIR	:= $(BUILDDIR)/$(STRACE)
