{ pkgs, noctalia, ... }:
{
  home = {
    username = "myuron";
    homeDirectory = "/home/myuron";
    stateVersion = "26.05";
    sessionVariables = {
      "QT_QPA_PLATFORM" = "wayland;xcb";
      "QT_QPA_PLATFORMTHEME" = "qt6ct";
      "QT_AUTO_SCREEN_SCALE_FACTOR" = "1";
    };
    packages = with pkgs; [
      # git
      git
      gh
      ghq
      lazygit
      discord
      just

      # LSP
      lua-language-server
      nixd
      vscode-langservers-extracted
      bash-language-server
      gopls
      rust-analyzer
      cliamp

      # AI
      hunk
      herdr
      claude-agent-acp
      llm-agents.claude-desktop

      # browser
      google-chrome

      # terminal
      foot

      llm-agents.orca

      # etc
      ripgrep
      fd
      jq
      yazi
      nix-search-tv

      whitesur-gtk-theme
      pkgs.quickshell
      pkgs.qt6Packages.qt6ct
      thorium-reader
    ];
  };
  imports = [
    ./niri
    ./wezterm
    ./nvimx
    ./hunk
    ./emacs
    ./claude-code
    ./noctalia.nix
    ./fish.nix
    ./direnv.nix
    ./fzf.nix
    ./television.nix
    ./zoxide.nix
    ./firefox.nix
  ];
  programs.home-manager.enable = true;
  catppuccin = {
    enable = true;
    autoEnable = false;
  };
}
