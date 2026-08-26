{ ... }:
let
  substituters = [
    "https://cache.soopy.moe"
    "https://noctalia.cachix.org"
  ];
in
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # nixos adds cache.nixos.org at the very end so specifying that is not needed.
    # on other systems please use extra-substituters to not overwrite that.
    inherit substituters;
    trusted-substituters = substituters;
    trusted-public-keys = [
      "cache.soopy.moe-1:0RZVsQeR+GOh0VQI9rvnHz55nVXkFardDqfm4+afjPo="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
    trusted-users = [
      "root"
      "myuron"
    ];
  };
}
