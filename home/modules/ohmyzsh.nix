{pkgs, ...}: {
  # Ensure omz and plugins are installed
  home.packages = with pkgs; [
    oh-my-zsh
    zsh-fzf-tab
    zsh-powerlevel10k
    zsh-fzf-history-search
    zsh-autosuggestions
    zsh-syntax-highlighting
  ];
  programs.direnv.enableZshIntegration = true;
}