{
  programs.nvimx = {
    enable = true;
    vimAlias = true;
    configDir = ./nvim;
    lockDir = ./nvim/nvimx-lock;
    lock = {
      installCommand = true;
      projectDir = "/home/myuron/ghq/github.com/myuron/dotfiles/home-manager/nvimx";
      configDirRelative = "./nvim";
      lockDirRelative = "./nvim/nvimx-lock";
    };
  };
}
