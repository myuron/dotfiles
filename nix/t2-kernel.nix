{
  lib,
  pkgsT2,
  nixos-hardware,
  ...
}:
{
  # nixos-hardware の apple-t2 モジュールと同じ組み立て方を、flake.nix でピン留めした
  # nixpkgs (nixpkgs-t2) で行い、cache.soopy.moe にあるカーネルをそのまま使う。
  boot.kernelPackages = lib.mkForce (
    pkgsT2.linuxPackagesFor (pkgsT2.callPackage "${nixos-hardware}/apple/t2/pkgs/linux-t2" { })
  );
}
