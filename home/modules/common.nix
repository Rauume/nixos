{outputs, ...}: {
  imports = [
    ../modules/bat.nix
    ../modules/fastfetch.nix
    ../modules/fzf.nix
    ../modules/git.nix
    ../modules/gpg.nix
    ../modules/home.nix
    ../modules/lazygit.nix
    # ../modules/neovim.nix
    ../modules/scripts.nix
    ../modules/zsh.nix
    ../modules/ohmyzsh.nix
    ../modules/ghostty.nix
  ];

  # Nixpkgs configuration
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
