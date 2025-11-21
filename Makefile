DOTFILE_DIR = $(shell pwd)

BREWPATH = /opt/homebrew/bin/brew

CORE_PACKAGES = tmux neovim fzf fd gh sd tree moreutils
CORE_PACKAGES += fasd starship bat colordiff wget jq ripgrep

help:  ## Show this help.
	@sed -ne '/@sed/!s/## //p' $(MAKEFILE_LIST)

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
