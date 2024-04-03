{ inputs, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    _1password
    actionlint
    awscli2
    bandwhich
    bat
    bottom
    broot
    checkbashisms
    delta
    deno
    difftastic
    dua
    eza
    fd
    fzf
    gh
    ghq
    git
    grex
    jq
    nixpkgs-fmt
    onefetch
    ripgrep
    rnr
    sd
    shellcheck
    shfmt
    starship
    statix
    tealdeer
    tree
    watchexec
    zoxide
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
  security.pam.enableSudoTouchIdAuth = true;
  services.nix-daemon.enable = true;
  system.activationScripts.postUserActivation.text = ''
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
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
}
