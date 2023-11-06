{ config, lib, pkgs, ... }:

{
	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs; [
		_1password
		actionlint
		awscli2
		bat
		checkbashisms
		delta
		deno
		du-dust
		eza
		fd
		fzf
		gh
		ghq
		git
		jq
		ripgrep
		rnr
		shellcheck
		shfmt
		starship
		tree
		volta
		watchexec
	];

	fonts = {
		fontDir = {
			enable = true;
		};
		fonts = with pkgs; [
			(nerdfonts.override {
				fonts = [
					"FiraCode"
				];
			})
		];
	};

	nixpkgs = {
		config = {
			allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
				"1password-cli"
			];
		};
	};

	# Use a custom configuration.nix location.
	# $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
	# environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

	# Auto upgrade nix package and the daemon service.
	services.nix-daemon.enable = true;
	# nix.package = pkgs.nix;

	# Create /etc/zshrc that loads the nix-darwin environment.
	programs.zsh.enable = true;  # default shell on catalina
	programs.zsh.enableSyntaxHighlighting = true;
	# programs.fish.enable = true;

	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog
	system.stateVersion = 4;
}
