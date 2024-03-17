{ config, pkgs, ... }:
{
  programs.fzf = { 
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    defaultOptions = [
      "--no-reverse"
    ];

    fileWidgetOptions = [
      "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
      "--select-1 --exit-0"
    ];

    historyWidgetOptions = [
      "--preview 'echo {}'"
      "--preview-window down:3:hidden:wrap"
      "--bind '?:toggle-preview'"
    ];

    changeDirWidgetCommand = "${pkgs.fd}/bin/fd --type d";

    changeDirWidgetOptions = [
      "--preview '${pkgs.tree}/bin/tree -C {} | head -200'"
    ];
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    history = {
      save = 10000;
      size = 10000;
      expireDuplicatesFirst = true;
      ignoreDups = true;
      share = true;
      ignoreSpace = true;
      extended = false;
      path = "${config.xdg.dataHome}/zsh/zsh_history";
    };

    localVariables = {
      POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true;
    };

    sessionVariables = {
      LANG="en_US.UTF-8";
      LC_ALL="$LANG";
    };

    initExtraFirst = ''
      #
      # Powerlevel10k configuration module for zsh.
      #
      # Enable Powerlevel9k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p9k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p9k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';

    # env settings for every shell (login, interactive)
    envExtra = ''
    '';

    # login shell settings
    loginExtra = ''
      export XDG_BIN_HOME="${config.home.homeDirectory}/.local/bin"
      export XDG_LIB_HOME="${config.home.homeDirectory}/.local/lib"
      export XDG_DATA_HOME="${config.xdg.dataHome}"
      export XDG_CONFIG_HOME="${config.xdg.configHome}"
      export XDG_CACHE_HOME="${config.xdg.cacheHome}"
    '';

    # runs at logout
    logoutExtra = ''
    '';


    profileExtra = ''
    '';

    initExtra = ''
      if [ "$TERM" = "linux" ]; then
        p10k_theme_config="${config.xdg.configHome}/zsh/.p10k-term-linux.zsh"
      else
        p10k_theme_config="${config.xdg.configHome}/zsh/.p10k.zsh"
      fi


      source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
      [[ ! -f $p10k_theme_config ]] || source "$p10k_theme_config"

      function reload() {
        source ~/.config/zsh/.zshrc
      }
    '';

    shellAliases = {
      cfg = "${pkgs.git}/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      gg = "${pkgs.git}/bin/git status -s";
      ls = "exa";
      ll = "ls -l";
      la = "ls -la";
      l = "ls -lh";
    };
  };
}