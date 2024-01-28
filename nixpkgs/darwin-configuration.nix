{ lib, pkgs, ... }:

{
	environment = {
		systemPackages = with pkgs; [
			_1password
			actionlint
			awscli2
			bat
			checkbashisms
			delta
			deno
			difftastic
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

	nixpkgs = {
		config = {
			allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
				"1password-cli"
			];
		};
	};

	programs = {
		zsh = {
			enable = true;
			enableSyntaxHighlighting = true;
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
