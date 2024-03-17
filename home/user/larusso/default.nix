{ config, pkgs, ... }:
{
  imports = [
    ./git.nix
    ./ssh.nix
    ./direnv.nix
    ./shell.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "larusso";
  home.homeDirectory = "/home/larusso";

  home.packages = [
    pkgs.nixfmt
    pkgs.git-crypt
    pkgs.eza
    pkgs.direnv
    pkgs.rustup
    pkgs.ripgrep
    pkgs.zsh-powerlevel10k
    pkgs._1password
    pkgs.kitty
    pkgs.alacritty
    pkgs.chiaki
    pkgs._1password
    pkgs._1password-gui
  ];

  xdg.configFile."direnv/direnvrc".text = ''
    #export DIRENV_LOG_FORMAT=""
  '';

  fonts.fontconfig.enable = true;
  

 

  programs.kitty = {
    enable = true;
    font = {
      name = "MesloLGS NF Regular";
      package = pkgs.meslo-lgs-nf;
      size = 13;
    };

    settings = {
      bold_font = "MesloLGS NF Bold";
      italic_font = "MesloLGS NF Italic";
      bold_italic_font = "MesloLGS NF Bold Italic";

      # url_color = "#0087bd";
      url_style = "single";
      open_url_modifiers = "kitty_mod";
      open_url_with = "default";
      copy_on_select = "clipboard";     
      strip_tailing_spaces = "smart";

      enabled_layouts = "splits:split_axis=horizontal,tall:bias=50;full_size=1;mirrored=false,grid,horizontal,vertical";
      window_padding_width = 5;
      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_bar_strategy = "previous";
      # active_tab_foreground  = "#000000";
      # active_tab_background  = "#f2eb32";
      # active_tab_font_style = "bold";
      # inactive_tab_foreground = "#cccccc"; 
      # inactive_tab_background = "#31004b";
      # inactive_tab_font_style = "normal";
      background_opacity = "0.70";

      allow_remote_control = "yes";
      clipboard_control = "write-clipboard write-primary";
      macos_option_as_alt = "yes";
      macos_thicken_font = "0.75";
    };

    keybindings = {
      "cmd+enter" = "launch --cwd=current";
      "kitty_mod+n" = "new_os_window";
      "ctrl+alt+t" = "goto_layout tall>";
      "ctrl+alt+h" = "goto_layout horizontal>";
      "ctrl+alt+g" = "goto_layout grid>";
      "ctrl+alt+s" = "goto_layout splits>";

      "F5" = "launch --location=hsplit";
      "cmd+d" = "launch --location=vsplit";
      "F6" = "launch --location=vsplit";
      "F7" = "layout_action rotate";

      "shift+up" = "move_window up";
      "shift+left" = "move_window left";
      "shift+right" = "move_window right";
      "shift+down" = "move_window down";

      "ctrl+shift+k" = "move_window up";
      "ctrl+shift+h" = "move_window left";
      "ctrl+shift+l" = "move_window right";
      "ctrl+shift+j" = "move_window down";

      "ctrl+left" = "neighboring_window left";
      "ctrl+right" = "neighboring_window right";
      "ctrl+up" = "neighboring_window up";
      "ctrl+down" = "neighboring_window down";

      "ctrl+h" = "neighboring_window left";
      "ctrl+l" = "neighboring_window right";
      "ctrl+k" = "neighboring_window up";
      "ctrl+j" = "neighboring_window down";
    };

    # theme = "Goa Base";
    # "Lavandula";
  };
}

