{ pkgs, org-babel, ... }:
let
  tangle = org-babel.lib.tangleOrgBabel { languages = [ "emacs-lisp" ]; };
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: with epkgs; [
      # UI
      spacemacs-theme
      spaceline
      centaur-tabs
      dashboard

      # Explorer
      treemacs
      treemacs-nerd-icons

      # Completion
      vertico
      vertico-posframe
      marginalia
      nerd-icons-completion
      orderless
      consult
      consult-ghq
      corfu
      embark
      embark-consult
      puni

      # LSP
      treesit-grammars.with-all-grammars
      nix-ts-mode
      go-mode
      rust-mode

      # Git
      magit

      # Other
      envrc
      winum
    ];
  };
  home.file.".emacs.d/early-init.el".text = tangle (builtins.readFile ./early-init.org);
  home.file.".emacs.d/init.el".text = tangle (builtins.readFile ./init.org);
}
