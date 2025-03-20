{ config, lib, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home.packages = [
    pkgs.git-crypt

    pkgs.awscli

    # ssh
    pkgs.sshpass
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      arrterian.nix-env-selector
      matklad.rust-analyzer 
      bbenoist.nix
      brettm12345.nixfmt-vscode
      vadimcn.vscode-lldb
    ];
  };

  programs.kitty = {
    settings = {
      #"foreground" = "#f8f8f0";
      #"background" = "#160821";
      #"selection_foreground" = "#31004b";
      #"selection_background" = "#f2eb32";

      "url_color" = "#6bdfff";

      # black
      "color0" = "#171717";
      "color8" = "#676767";

      # red
      "color1" = "#f25619";
      "color9" = "#fb2f4c";

      # green
      "color2" = "#00ff00";
      "color10" = "#2de2a6";

      # yellow
      "color3" = "#ffff00";
      "color11" = "#f3f400";

      # blue
      "color4" = "#0c6dee";
      "color12" = "#2232a2";

      # magenta
      "color5" = "#b848c0";
      "color13" = "#c670ee";

      # cyan
      "color6" = "#4ed6ff";
      "color14" = "#99ecfd";

      # white
      "color7" = "#c7c7c7";
      "color15" = "#feffff";

      # "Cursor" = "colors";
      "cursor" = "#f2eb32";
      "cursor_text_color" = "background";

      # Tab "bar" = "colors";
      "active_tab_foreground" = "#31004b";
      "active_tab_background" = "#f2eb32";
      "inactive_tab_foreground" = "#f2eb32";
      "inactive_tab_background" = "#31004b";

      # Marks
      "mark1_foreground" = "#282a36";
      "mark1_background" = "#ff5555";
    };
  };
}
