export CURRENT_DIR=${PWD}
export VSCODE_SETTING_DIR=~/Library/Application\ Support/Code/User/

install:
	ln -sf ${CURRENT_DIR}/.vimrc $$HOME/.vimrc
	ln -sf ${CURRENT_DIR}/.bash_profile $$HOME/.bash_profile
	ln -sf ${CURRENT_DIR}/.gitignore_global $$HOME/.gitignore_global
	ln -sf ${CURRENT_DIR}/settings.json ${VSCODE_SETTING_DIR}/settings.json
	ln -sf ${CURRENT_DIR}/keybindings.json ${VSCODE_SETTING_DIR}/keybindings.json
