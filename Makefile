## ----------------------------------------------------------------------
## Set up a computer
##
## Target OS: Mac
## ----------------------------------------------------------------------

DOTFILE_DIR = $(shell pwd)

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

.PHONY: tmux
tmux:
	if [[ ! -d $${HOME}/.tmux/themes/nord-tmux ]]; then \
		mkdir -p $${HOME}/.tmux/themes; \
		cd $${HOME}/.tmux/themes; \
		git clone https://github.com/arcticicestudio/nord-tmux; \
	fi
	if [[ ! -L $${HOME}/.tmux.conf ]]; then \
		[[ -f $${HOME}/.tmux.conf ]] && rm $${HOME}/.tmux.conf; \
		ln -s $(DOTFILE_DIR)/.tmux.conf $${HOME}/.tmux.conf; \
	fi
