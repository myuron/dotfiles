{ pkgs, org-babel, ... }:
let
  tangle = org-babel.lib.tangleOrgBabel { languages = [ "emacs-lisp" ]; };
in
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: with epkgs; [
      spacemacs-theme
      spaceline
      centaur-tabs
      dashboard
    ];
  };
  home.file.".emacs.d/early-init.el".text = tangle (builtins.readFile ./early-init.org);
  home.file.".emacs.d/init.el".text = tangle (builtins.readFile ./init.org);
}
