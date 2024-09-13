{ pkgs, ... }:
let
	myAliases = {
		cat = "bat";
		vi = "nvim";
	};
in
{
	programs.zsh = {
		enable = true;
		shellAliases = myAliases;
		plugins = [
			{ 
				name = "powerlevel10k";
				src = pkgs.zsh-powerlevel10k;
				file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
			}
		];
		initExtra = ''
			source ~/nixos-config/dotfiles/p10k.zsh
			'';
		};
	home.packages = with pkgs; [
		bat
	];


}
