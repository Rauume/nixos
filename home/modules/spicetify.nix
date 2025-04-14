{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [
    # Spicetify
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.hazy;
    # colorScheme = "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      keyboardShortcut
      shuffle
    ];
  };
}
