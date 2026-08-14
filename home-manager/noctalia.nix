{
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      wallpaper = {
        enabled = true;
        directory = "${../wallpapers}";
        default.path = "${../wallpapers/wallpaper-001.jpg}";
      };

      widget = {
        network = {
          show_label = false;
        };
      };

      bar.default = {
        position = "top";
        radius = 0;
        margin_ends = 0;
      };
    };
  };
}
