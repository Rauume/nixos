{config, pkgs, ...}: {
  # Zsh shell configuration
  programs.zsh = {
    enable = true;
    # enableCompletion = true;
    plugins = [
      {
        name = pkgs.zsh-fzf-tab.pname;
        src = pkgs.zsh-fzf-tab.src;
      }
      {
        name = "powerlevel10k-config";
        src = ./../../files/configs/zsh;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = pkgs.zsh-syntax-highlighting.pname;
        src = pkgs.zsh-syntax-highlighting.src;
      }
      {
        name = pkgs.zsh-autosuggestions.pname;
        src = pkgs.zsh-autosuggestions.src;
      }
      {
        name = pkgs.zsh-fzf-history-search.pname;
        src = pkgs.zsh-fzf-history-search.src;
      }
    ];
    oh-my-zsh = {
      enable = true;
      plugins = [
      "git"
      "sudo" 
      ];
    };
    shellAliases = {
      ff = "fastfetch";

      # git
      gaa = "git add --all";
      gcam = "git commit --all --message";
      gcl = "git clone";
      gco = "git checkout";
      ggl = "git pull";
      ggp = "git push";

      ld = "lazydocker";
      lg = "lazygit";

      repo = "cd $HOME/Documents/repositories";
      temp = "cd $HOME/Downloads/temp";

      v = "nvim";
      vi = "nvim";
      vim = "nvim";

      ls = "eza --icons always"; # default view
      ll = "eza -bhl --icons --group-directories-first"; # long list
      la = "eza -abhl --icons --group-directories-first"; # all list
      lt = "eza --tree --level=2 --icons"; # tree
    };
    initContent = ''
      # kubectl auto-complete
      # source <(kubectl completion zsh)

      # bindings
      # bindkey -v
      # bindkey '^A' beginning-of-line
      # bindkey '^E' end-of-line
      bindkey '^[[F' end-of-line
      bindkey '^[[F' beginning-of-line
      bindkey '^[[3;5~' delete-word
      bindkey '^H' backward-delete-word
      
      bindkey '^[[1;5C' forward-word
      bindkey '^[[1;5D' backward-word
      

      # open commands in $EDITOR with C-e
      autoload -z edit-command-line
      zle -N edit-command-line
      bindkey "^e" edit-command-line
    '';
  };

  # programs.starship = {
  #   enable = true;
  #   # catppuccin.enable = true;
  #   enableZshIntegration = true;
  #   settings = {
  #     add_newline = false;
  #     directory = {
  #       style = "bold lavender";
  #     };
  #     aws = {
  #       disabled = true;
  #     };
  #     docker_context = {
  #       symbol = " ";
  #     };
  #     golang = {
  #       symbol = " ";
  #     };
  #     kubernetes = {
  #       disabled = false;
  #       style = "bold pink";
  #       symbol = "󱃾 ";
  #       format = "[$symbol$context( \($namespace\))]($style)";
  #       contexts = [
  #         {
  #           context_pattern = "arn:aws:eks:(?P<var_region>.*):(?P<var_account>[0-9]{12}):cluster/(?P<var_cluster>.*)";
  #           context_alias = "$var_cluster";
  #         }
  #       ];
  #     };
  #     lua = {
  #       symbol = " ";
  #     };
  #     package = {
  #       symbol = " ";
  #     };
  #     php = {
  #       symbol = " ";
  #     };
  #     python = {
  #       symbol = " ";
  #     };
  #     terraform = {
  #       symbol = " ";
  #     };
  #     right_format = "$kubernetes";
  #   };
  # };
}
