CURRENT_DIR := $(shell pwd)
VSCODE_SETTING_DIR := ~/Library/Application\ Support/Code/User/
HOME_DIR := $(HOME)

FILES_TO_LINK := .vimrc .zshrc .gitconfig .gitignore_global .zsh/.git-prompt.sh .codex/config.toml .claude.json
VSCODE_FILES := settings.json keybindings.json

.PHONY: link unlink commit

# Commands
link: link_home_files link_claude_dir link_vscode_files
unlink: unlink_home_files unlink_claude_dir unlink_vscode_files
commit:
	git add .
	git commit -m 'updated'
	git push origin master

# Functions
link_home_files:
	@echo "Linking files to home directory..."
	@$(foreach file,$(FILES_TO_LINK),ln -s $(CURRENT_DIR)/$(file) $(HOME_DIR)/$(file);)

link_claude_dir:
	@echo "Linking .claude directory to home directory..."
	@ln -s $(CURRENT_DIR)/.claude $(HOME_DIR)/.claude

link_vscode_files:
	@echo "Linking VSCode files..."
	@$(foreach file,$(VSCODE_FILES),ln -s $(CURRENT_DIR)/vscode/$(file) $(VSCODE_SETTING_DIR)/$(file);)

unlink_home_files:
	@echo "Unlinking files from home directory..."
	@$(foreach file,$(FILES_TO_LINK),unlink $(HOME_DIR)/$(file);)

unlink_claude_dir:
	@echo "Unlinking .claude directory from home directory..."
	@unlink $(HOME_DIR)/.claude || true

unlink_vscode_files:
	@echo "Unlinking VSCode files..."
	@$(foreach file,$(VSCODE_FILES),unlink $(VSCODE_SETTING_DIR)/$(file);)
