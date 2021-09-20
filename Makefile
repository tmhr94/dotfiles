export CURRENT_DIR=${PWD}

install:
	ln -sf ${CURRENT_DIR}/.vimrc $$HOME/.vimrc
	ln -sf ${CURRENT_DIR}/.gitconfig $$HOME/.gitconfig
	ln -sf ${CURRENT_DIR}/.bash_profile $$HOME/.bash_profile
	ln -sf ${CURRENT_DIR}/.gitignore_global $$HOME/.gitignore_global
