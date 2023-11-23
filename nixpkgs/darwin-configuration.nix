{ config, lib, pkgs, ... }:

{
	imports = [
		<home-manager/nix-darwin>
	];

	environment = {
		darwinConfig = "$HOME/dotfiles/nixpkgs/darwin-configuration.nix";
		systemPackages = with pkgs; [
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
			tree
			volta
			watchexec
		];
	};

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

	home-manager = {
		useGlobalPkgs = true;
		useUserPackages = true;
		users = {
			"takuya.fukuju" = {
				home = {
					file = {
						".nixpkgs" = {
							source = ../nixpkgs;
						};
						".vimrc" = {
							source = ../vimrc;
						};
						".zprofile" = {
							source = ../zprofile;
						};
						".zsh_history" = {
							source = ../zsh_history;
						};
						".zshenv" = {
							source = ../zshenv;
						};
						".zshrc" = {
							source = ../zshrc;
						};
					};
					stateVersion = "23.05";
				};
				xdg = {
					configFile = {
						"git" = {
							source = ../config/git;
						};
						"op/plugins" = {
							source = ../config/op/plugins;
						};
						"op/plugins.sh" = {
							source = ../config/op/plugins.sh;
						};
					};
					enable = true;
				};
			};
		};
	};

	nixpkgs = {
		config = {
			allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
				"1password-cli"
			];
		};
	};

	services = {
		nix-daemon = {
			enable = true;
		};
	};

	system = {
		activationScripts = {
			postUserActivation = {
				text = ''
					/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
				'';
			};
		};
		defaults = {
			CustomUserPreferences = {
				NSGlobalDomain = {
					ApplePressAndHoldEnabled = false;
					InitialKeyRepeat = 10;
					KeyRepeat = 1;
					NSNavPanelExpandedStateForSaveMode2 = true;
				};
				"com.apple.dock" = {
					appswitcher-all-displays = true;
					autohide-delay = 0;
					showhidden = true;
					size-immutable = true;
					static-only = true;
				};
				"com.apple.screencapture" = {
					disable-shadow = true;
					show-thumbnail = true;
				};
			};
		};
		stateVersion = 4;
	};

	users = {
		users = {
			"takuya.fukuju" = {
				home = "/Users/takuya.fukuju";
			};
		};
	};
}
