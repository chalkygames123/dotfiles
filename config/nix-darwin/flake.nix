{
  inputs = {
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };
  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { lib, pkgs, ... }: {
        environment.systemPackages = with pkgs; [
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
          statix
          tree
          volta
          watchexec
        ];
        fonts.fontDir.enable = true;
        fonts.fonts = with pkgs; [
          (nerdfonts.override {
            fonts = [
              "FiraCode"
            ];
          })
        ];
        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "1password-cli"
        ];
        nixpkgs.hostPlatform = "aarch64-darwin";
        programs.zsh.enable = true;
        programs.zsh.enableSyntaxHighlighting = true;
        services.nix-daemon.enable = true;
        system.activationScripts.postUserActivation.text = ''
          					/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
          				'';
        system.configurationRevision = self.rev or self.dirtyRev or null;
        system.defaults.CustomUserPreferences.NSGlobalDomain.ApplePressAndHoldEnabled = false;
        system.defaults.CustomUserPreferences.NSGlobalDomain.InitialKeyRepeat = 10;
        system.defaults.CustomUserPreferences.NSGlobalDomain.KeyRepeat = 1;
        system.defaults.CustomUserPreferences.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
        system.defaults.CustomUserPreferences."com.apple.dock".appswitcher-all-displays = true;
        system.defaults.CustomUserPreferences."com.apple.dock".autohide-delay = 0;
        system.defaults.CustomUserPreferences."com.apple.dock".showhidden = true;
        system.defaults.CustomUserPreferences."com.apple.dock".size-immutable = true;
        system.defaults.CustomUserPreferences."com.apple.dock".static-only = true;
        system.defaults.CustomUserPreferences."com.apple.screencapture".disable-shadow = true;
        system.defaults.CustomUserPreferences."com.apple.screencapture".show-thumbnail = true;
        system.stateVersion = 4;
      };
    in
    {
      darwinConfigurations."Rhelixa-Takuya-Fukujus-MacBook-Pro" = nix-darwin.lib.darwinSystem { modules = [ configuration ]; };
      darwinPackages = self.darwinConfigurations."Rhelixa-Takuya-Fukujus-MacBook-Pro".pkgs;
    };
}
