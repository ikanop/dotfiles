DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

SHELL := /bin/bash

export XDG_CONFIG_HOME=$(HOME)/.config

.PHONY: test

macos: brew stow packages link

brew:
	command -v brew >/dev/null 2>&1 || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

stow:
	command -v stow >/dev/null 2>&1 || brew install stow

link: stow
	for FILE in $$(\ls -A runcom); do if [ -f $(HOME)/$$FILE -a ! -h $(HOME)/$$FILE ]; then \
		mv -v $(HOME)/$$FILE{,.bak}; fi; done
	mkdir -p "$(XDG_CONFIG_HOME)"
	stow -t "$(HOME)" runcom
	stow -t "$(XDG_CONFIG_HOME)" config
	mkdir -p $(HOME)/.local/runtime
	chmod 700 $(HOME)/.local/runtime

packages:
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile || true
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

test:
	bats test
