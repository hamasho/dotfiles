ARCH_BASE_PACKAGES :=
ARCH_USER_PACKAGES := \
	git gvim zsh \
	rubygems
ARCH_PACKAGES := $(ARCH_BASE_PACKAGES) $(ARCH_USER_PACKAGES)

ARCH_AUR_PACKAGES := vi-vim-symlink

ARCH_PACKAGE_UPGRADE := n

RUBY_PACKAGES := tmuxinator


define ZSH_PLUGIN_URLS
https://github.com/marzocchi/zsh-notify
endef

noop:

.PHONY: arch-packages
arch-packages:
	if [ "$(ARCH_PACKAGE_UPGRADE)" = "y" ]; then \
		sudo pacman -S $(ARCH_PACKAGES) ; \
		yaourt -S $(ARCH_AUR_PACKAGES) ; \
	fi

export ZSH_PLUGIN_URLS
.PHONY: oh-my-zsh
oh-my-zsh: arch-packages
	if [ ! -d ~/.oh-my-zsh ]; then \
		sh -c "$$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" ; \
	fi
	cd ~/.oh-my-zsh/custom/plugins && \
		for plugin_url in $$ZSH_PLUGIN_URLS; do \
			git clone $$plugin_url ; \
		done
	# manually rename zsh-notify to notify cuz filename is `notify.plugin.zsh`
	cd ~/.oh-my-zsh/custom/plugins && \
		mv zsh-notify notify

ruby-packages: arch-packages
	gem install $(RUBY_PACKAGES)
