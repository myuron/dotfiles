{
  nixConfig = {
    extra-substituters = [
      "https://cache.soopy.moe"
      "https://noctalia.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # T2 カーネルを cache.soopy.moe にある linux-t2 6.18.46 に固定するための nixpkgs。
    # hydra.soopy.moe 廃止でキャッシュが更新されていないため、通常の nixpkgs に追従させると
    # カーネルのローカルビルドになる。キャッシュ復活を確認したらこの入力と nix/t2-kernel.nix を削除する。
    nixpkgs-t2.url = "github:NixOS/nixpkgs/9fbb54b33e91ee4ca368e35a78e0613c720600b3";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nvimx.url = "github:myuron/nvimx";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/nur";
    org-babel.url = "github:emacs-twist/org-babel";
    llm-agents.url = "github:numtide/llm-agents.nix";
    catppuccin.url = "github:catppuccin/nix";
    hermes-agent.url = "github:nousresearch/hermes-agent";
    nix-claude-code.url = "github:ryoppippi/nix-claude-code";
    # fish の kubectl 補完。nixpkgs の fishPlugins に無いため直接取得する。
    fish-kubectl-completions = {
      url = "github:evanlucas/fish-kubectl-completions";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-t2,
      nixos-hardware,
      home-manager,
      nvimx,
      treefmt-nix,
      noctalia,
      nur,
      org-babel,
      llm-agents,
      catppuccin,
      hermes-agent,
      nix-claude-code,
      fish-kubectl-completions,
      ...
    }:
    let
      system = "x86_64-linux";
      overlays = [
        nur.overlays.default
        llm-agents.overlays.shared-nixpkgs
        nix-claude-code.overlays.default
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };
      pkgsT2 = import nixpkgs-t2 { inherit system; };
    in
    {
      # ===== remove everything below this =====
      templates.default = {
        path = builtins.filterSource (
          path: _:
          (
            !builtins.elem (builtins.baseNameOf path) [
              "README.md"
              "LICENSE"
              "flake.lock"
            ]
          )
        ) ./.;
        description = "A flake to quickly get started to use NixOS on a T2 Mac device.";
      };
      # ===== remove everything above this =====

      formatter.${system} = treefmt-nix.lib.mkWrapper pkgs {
        projectRootFile = "flake.nix";
        programs = {
          nixfmt.enable = true;
        };
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = { inherit pkgsT2 nixos-hardware; };
        modules = [
          ./configuration.nix
          ./nix/substituter.nix
          nixos-hardware.nixosModules.apple-t2
          hermes-agent.nixosModules.default
          ./nix/t2-kernel.nix
        ];
      };

      homeConfigurations.home = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit noctalia org-babel fish-kubectl-completions;
          llm-agents = llm-agents.packages.${system};
        };
        modules = [
          ./home-manager
          nvimx.homeModules.nvimx
          noctalia.homeModules.default
          catppuccin.homeModules.catppuccin
        ];
      };

      apps.${system} = {
        nixos = {
          type = "app";
          program = toString (
            pkgs.writeShellScript "nixos build..." ''
              set -e
              sudo nixos-rebuild switch --flake .#nixos
            ''
          );
        };
        home = {
          type = "app";
          program = toString (
            pkgs.writeShellScript "nixos build..." ''
              set -e
              nix run nixpkgs#home-manager -- switch --flake .#home
            ''
          );
        };
      };
    };
}
