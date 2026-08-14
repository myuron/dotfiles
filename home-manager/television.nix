{
  programs.television = {
    enable = true;
    channels = {
      nix = {
        metadata = {
          name = "nix";
          requirements = ["nix-search-tv"];
        };
        source = {
          command = "nix-search-tv print";
        };
        preview = {
          command = "nix-search-tv preview {}";
        };
      };
    };
  };
}
