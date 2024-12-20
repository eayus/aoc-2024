let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    (haskellPackages.ghcWithPackages (hpkgs: [hpkgs.regex-pcre hpkgs.split hpkgs.unordered-containers]))
  ];
}