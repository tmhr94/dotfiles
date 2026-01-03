CURRENT_DIR := $(shell pwd)
VSCODE_SETTING_DIR := ~/Library/Application\ Support/Code/User/
CLAUDE_DIR := $(HOME)/.claude
HOME_DIR := $(HOME)

FILES_TO_LINK := .vimrc .zshrc .gitconfig .gitignore_global .zsh/.git-prompt.sh .codex/config.toml .claude.json
VSCODE_FILES := settings.json keybindings.json
CLAUDE_FILES := settings.json statusline.sh CLAUDE.md agents/app-test-debug-agent.md agents/tech-docs-searcher.md

.PHONY: link unlink commit

# Commands
link:
	@$(MAKE) link_home_files || true
	@$(MAKE) link_claude_files
	@$(MAKE) link_vscode_files || true
unlink: unlink_home_files unlink_claude_files unlink_vscode_files
commit:
	git add .
	git commit -m 'updated'
	git push origin master

# Functions
link_home_files:
	@echo "Linking files to home directory..."
	@$(foreach file,$(FILES_TO_LINK),ln -s $(CURRENT_DIR)/$(file) $(HOME_DIR)/$(file);)

link_claude_files:
	@echo "Linking .claude files to home directory..."
	@mkdir -p $(CLAUDE_DIR)/agents
	@$(foreach file,$(CLAUDE_FILES),mkdir -p "$(dir $(CLAUDE_DIR)/$(file))"; ln -sfn "$(CURRENT_DIR)/.claude/$(file)" "$(CLAUDE_DIR)/$(file)";)

link_vscode_files:
	@echo "Linking VSCode files..."
	@$(foreach file,$(VSCODE_FILES),ln -s $(CURRENT_DIR)/vscode/$(file) $(VSCODE_SETTING_DIR)/$(file);)

unlink_home_files:
	@echo "Unlinking files from home directory..."
	@$(foreach file,$(FILES_TO_LINK),unlink $(HOME_DIR)/$(file);)

unlink_claude_files:
	@echo "Unlinking .claude files from home directory..."
	@$(foreach file,$(CLAUDE_FILES),unlink $(CLAUDE_DIR)/$(file);)

unlink_vscode_files:
	@echo "Unlinking VSCode files..."
	@$(foreach file,$(VSCODE_FILES),unlink $(VSCODE_SETTING_DIR)/$(file);)
