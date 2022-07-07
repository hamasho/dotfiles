## ----------------------------------------------------------------------
## Set up a computer
##
## Target OS: Mac
## ----------------------------------------------------------------------

BREWPATH = /opt/homebrew/bin/brew

CORE_PACKAGES = tmux neovim the_silver_searcher fzf fd gh tree moreutils
CORE_PACKAGES += asdf fasd starship bat colordiff wget jq ripgrep
CORE_PACKAGES += tmuxinator

help:  ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

brew:  ## Install homebrew
	@if [[ ! -x $(BREWPATH) ]]; then \
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	else \
		echo "brew is already installed." ;\
	fi

install_core: brew  ## Install necessary brew packages
	$(BREWPATH) install $(CORE_PACKAGES)
