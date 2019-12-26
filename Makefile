SCRIPT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: install save

install:
	@echo ### Starting dotfiles installation

	# Install oh-my-zsh if not already installed
	@echo ### Installing oh-my-zsh
	-curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

	# Create symlinks of each dot file to home directory
	@echo ### Linking from ${HOME} to dotfiles
	mkdir -p ${HOME}/.config
	ln -sf $(SCRIPT_DIR)/.vimrc ${HOME}/.vimrc
	ln -sF $(SCRIPT_DIR)/.config/nvim ${HOME}/.config/nvim
	ln -sf $(SCRIPT_DIR)/.zshrc ${HOME}/.zshrc
	ln -sf $(SCRIPT_DIR)/.tmux.conf ${HOME}/.tmux.conf
	
	# Copy over plugins to .vim
	ln -sF $(SCRIPT_DIR)/.vim ${HOME}/.vim

	# Install vscode user settings... 
	ln -sf $(SCRIPT_DIR)/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
	# ...and extensions
	cat $(SCRIPT_DIR)/vscode/extensions.txt | xargs -L 1 echo code --install-extension | bash

	@echo ### Done!

save:
	@echo ### Saving vscode configuration

	# Copy a list of current vscode extensions
	code --list-extensions > ${SCRIPT_DIR}/vscode/extensions.txt

	@echo ### Done!

