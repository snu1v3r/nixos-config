{ pkgs, ...}:

{
  programs.tmux = {
	enable = true;
	mouse = true;
	keyMode = "vi";
	baseIndex = 1;
	prefix = "`";
	plugins = with pkgs; [
		tmuxPlugins.sensible
		tmuxPlugins.yank
		tmuxPlugins.catppuccin
		tmuxPlugins.vim-tmux-navigator
	];
	extraConfig = ''
	# Moves status bar to the top
	set -g status-position top

	# Prompt to rename session right after creation
	set-hook -g after-new-session 'command-prompt -I "#{session_name}" "rename-session '%%'"'

	# Tells tmux that the terminal support colors
	set-option -sa terminal-overrides ",xterm*:Tc"

	# Creates new window in the current directory
	bind C new-window -c "#{pane_current_path}"

	# Creates new session in the current directory
	bind S new-session -c "#{pane_current_path}"

	# Window split commans will open new panes in the same path as the current pane
	bind '"' split-window -v -c "#{pane_current_path}"
	bind % split-window -h -c "#{pane_current_path}"
	'';
  };
}
