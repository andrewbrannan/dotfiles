SCRIPT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

install:
	@echo ### Starting dotfiles installation

	# Install oh-my-zsh if not already installed
	@echo ### Installing oh-my-zsh
	-curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

	# Create symlinks of each dot file to home directory
	@echo ### Linking from ${HOME} to dotfiles
	ln -sf $(SCRIPT_DIR)/.vimrc ${HOME}/.vimrc
	ln -sf $(SCRIPT_DIR)/.zshrc ${HOME}/.zshrc
	ln -sf $(SCRIPT_DIR)/.tmux.conf ${HOME}/.tmux.conf

	# Install vscode user settings... 
	ln -sf $(SCRIPT_DIR)/vscode/settings.json ${HOME}/Library/Application\ Support/Code/User/settings.json
	# ...and extensions
	cat $(SCRIPT_DIR)/vscode/extensions.txt | xargs -L 1 echo code --install-extension | bash

	@echo ### Done!