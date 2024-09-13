{ pkgs, ... }:
let
	myAliases = {
		cat = "bat";
	};
in
{
	programs.zsh = {
		enable = true;
		shellAliases = myAliases;
		};
	home.packages = with pkgs; [
		bat
	];


}
