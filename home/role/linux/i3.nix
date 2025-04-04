{ config, lib, pkgs, ... }:
{
    imports = [
      ./default.nix
      ./autorandr.nix
      # ./picom.nix
    ];

    home.packages = [
      pkgs.font-awesome
    ];

    programs.feh.enable = true;

    xsession.windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        modifier = "Mod4";
        workspaceAutoBackAndForth = true;
        #TODO: want to use i3-sensible-terminal!
        terminal = "kitty";

        window = {
          titlebar = false;
          hideEdgeBorders = "smart";

          commands = [
            {
              command = "boder pixel 1";
              criteria = {
                class = ".*";
              };
            }
          ];
        };

        floating = {
          titlebar = true;
          criteria = [
            {
              class = "egui";
            }
            {
              class = "rs6502";
            }
            {
              class = "Pavucontrol";
            }
          ];
          modifier = "${config.xsession.windowManager.i3.config.modifier}";
        };

        gaps = {
          inner = 30;
          outer = -20;
        };

        bars = [
          {
            position = "top";
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
            command = "${config.xsession.windowManager.i3.package}/bin/i3bar -t";
            fonts = {
              names = ["DejaVu Sans Mono" "Font Awesome 6 Free"];
              size = 11.8;
            };
            # colors = {
            #   background = "#00000099";
            # };
            mode = "dock";
            hiddenState = "hide";
            extraConfig = let mod = config.xsession.windowManager.i3.config.modifier; in ''
              modifier ${mod}
              workspace_min_width 30
            '';
            colors = {
              separator = "#FF00FF";
              background = "#22222200";
              statusline = "#dddddd";
              activeWorkspace = {
                background = "#6a0a6d";
                border = "#6a0a6d";
                text = "#f0fc16";
              };
              focusedWorkspace = {
                background = "#f0fc16";
                border = "#6a0a6d";
                text = "#6a0a6d";
              };
              inactiveWorkspace = {
                background = "#360038";
                border = "#6a0a6d";
                text = "#f0fc16";
              };
              urgentWorkspace = {
                background = "#2f343a";
                border = "#900000";
                text = "#ffffff";
              };
            };
            
          }
          {
            position = "bottom";

            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-bottom.toml";
            command = "${config.xsession.windowManager.i3.package}/bin/i3bar -t";
            fonts = {
              names = ["DejaVu Sans Mono" "Font Awesome 6 Free"];
              size = 11.8;
            };
            hiddenState = "hide";
            extraConfig = let mod = config.xsession.windowManager.i3.config.modifier; in ''
              modifier ${mod}
              workspace_min_width 30
            '';
            trayOutput = "primary";
            workspaceButtons = false;
            colors = {
              separator = "#FF00FF";
              background = "#22222200";
              statusline = "#dddddd";
            };
          }
        ];

        workspaceOutputAssign = [
          {
            workspace = "1";
            output = "primary DisplayPort-0 DisplayPort-1";
          }           
          {           
            workspace = "3";
            output = "primary DisplayPort-0 DisplayPort-1";
          }           
          {           
            workspace = "5";
            output = "primary DisplayPort-0 DisplayPort-1";
          }           
          {           
            workspace = "7";
            output = "primary DisplayPort-0 DisplayPort-1";
          }           
          {           
            workspace = "9";
            output = "primary DisplayPort-0 DisplayPort-1";
          }
          {
            workspace = "2";
            output = "DisplayPort-1 primary DisplayPort-0";
          }
          {
            workspace = "4";
            output = "DisplayPort-1 primary DisplayPort-0";
          }
          {
            workspace = "6";
            output = "DisplayPort-1 primary DisplayPort-0";
          }
          {
            workspace = "8";
            output = "DisplayPort-1 primary DisplayPort-0";
          }
          {
            workspace = "10";
            output = "DisplayPort-1 primary DisplayPort-0";
          }
        ];

        keybindings = let mod = config.xsession.windowManager.i3.config.modifier; in lib.mkOptionDefault {
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
          "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";

          # start a terminal
          "${mod}+Return" = "exec ${config.xsession.windowManager.i3.config.terminal}";

          # kill focused window
          "${mod}+Shift+q" = "kill";

          # change focus
          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";

          # move window
          "Mod1+h" = "move left";
          "Mod1+j" = "move down";
          "Mod1+k" = "move up ";
          "Mod1+l" = "move right";

          # alternatively, you can use the cursor keys:
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # move focused window
          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          # alternatively, you can use the cursor keys:
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # split in horizontal orientation
          "${mod}+g" = "split h";

          # split in vertical orientation
          "${mod}+v" = "split v";

          # enter fullscreen mode for the focused container
          "${mod}+f" = "fullscreen toggle";

          # change container layout (stacked, tabbed, toggle split)
          "${mod}+s" = "layout stacking";
          "${mod}+w" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          # open a browser window
          "${mod}+b" = "exec firefox";
          "${mod}+Shift+b" = "exec firefox -private-window";

          # open 1password
          #TODO: Install one password. Point to package?
          "${mod}+backslash" = "exec ${pkgs._1password-gui}/bin/1password";

          # suspend system
          "${mod}+Shift+Delete" = "exec systemctl suspend";

          # toggle tiling / floating
          "${mod}+Shift+space" = "floating toggle";

          # change focus between tiling / floating windows
          "${mod}+space" = "focus mode_toggle";

          # focus the parent container
          "${mod}+a" = "focus parent";

          # focus the child container
          #"${mod}+d" = "focus child";

          # switch to workspace
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          # move focused container to workspace
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          # reload the configuration file
          "${mod}+Shift+c" = "reload";
          # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
          "${mod}+Shift+r" = "restart";
          # exit i3 (logs you out of your X session)
          "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'\"";
        };
      };
      extraConfig = ''
        show_marks no
        mode "resize" {
          # These bindings trigger as soon as you enter the resize mode

          # Pressing left will shrink the window’s width.
          # Pressing right will grow the window’s width.
          # Pressing up will shrink the window’s height.
          # Pressing down will grow the window’s height.
          bindsym h resize shrink width 10 px or 10 ppt
          bindsym j resize grow height 10 px or 10 ppt
          bindsym k resize shrink height 10 px or 10 ppt
          bindsym l resize grow width 10 px or 10 ppt

          # same bindings, but for the arrow keys
          bindsym Left resize shrink width 10 px or 10 ppt
          bindsym Down resize grow height 10 px or 10 ppt
          bindsym Up resize shrink height 10 px or 10 ppt
          bindsym Right resize grow width 10 px or 10 ppt

          # back to normal: Enter or Escape or $mod+r
          bindsym Return mode "default"
          bindsym Escape mode "default"
          bindsym $mod+r mode "default"
        }

        mode "launcher" {
          bindsym f exec firefox; mode "default"
          bindsym Shift+f exec firefox --private-window; mode "default"
          bindsym c exec signal; mode "default"
          bindsym m exec mailspring; mode "default"
          # back to normal: Enter or Escape
          bindsym Return mode "default"
          bindsym Escape mode "default"
        }

        exec_always ${pkgs.feh}/bin/feh --no-fehbg --bg-scale --recursive --randomize ~/.config/i3/wallpapers/*
      '';
    };

    home.file.".config/i3status-rust/config-top.toml" = let britania_colors = {
            foreground_1 = config.theme.color3;
            background_1 = config.theme.color1;

            foreground_2 = config.theme.color10;
            background_2 = config.theme.color2;

            foreground_3 = config.theme.color10;
            background_3 = config.theme.color3;

            foreground_4 = config.theme.color3;
            background_4 = config.theme.color4;

            foreground_5 = config.theme.color10;
            background_5 = config.theme.color5;

            foreground_6 = config.theme.color3;
            background_6 = config.theme.color6;

            foreground_7 = config.theme.color10;
            background_7 = config.theme.color7;
            
            foreground_8 = config.theme.color10;
            background_8 = config.theme.color8;
            
            foreground_9 = config.theme.color3;
            background_9 = config.theme.color9;

            foreground_10 = config.theme.color1;
            background_10 = config.theme.color10;
    }; in {
      text = ''
        [icons]
        icons = "awesome6"

        [theme]
        theme = "dracula"

        [[block]]
        block = "focused_window"

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_10}"
        idle_fg = "${britania_colors.foreground_10}"

        [[block]]
        block = "disk_space"
        alert = 10.0
        info_type = "available"
        interval = 60
        path = "/"
        alert_unit = "GB"
        warning = 20.0
        format = " $icon $available "

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_6}"
        idle_fg = "${britania_colors.foreground_6}"

        [[block]]
        block = "memory"
        format = " $icon $mem_used/$mem_total($mem_used_percents) "
        format_alt = " $icon_swap $swap_free.eng(width:3,unit:B,prefix:Mi)/$swap_total.eng(width:3,unit:B,prefix:Mi)($swap_used_percents.eng(widht:2)) "

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_5}"
        idle_fg = "${britania_colors.foreground_5}"

        [[block]]
        block = "cpu"

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_4}"
        idle_fg = "${britania_colors.foreground_4}"

        [[block]]
        block = "load"
        format = " $icon 1min avg: $1m.eng(w:4) "
        interval = 1

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_3}"
        idle_fg = "${britania_colors.foreground_3}"

        [[block]]
        block = "temperature"
        format = " $icon $max max "
        format_alt = " $icon $min min, $max max, $average avg "
        interval = 10
        good = 35
        idle = 40
        info = 55
        warning = 60

        [[block]]
        block = "sound"

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_2}"
        idle_fg = "${britania_colors.foreground_2}"

        [[block]]
        block = "time"
        interval = 60
        timezone = "Europe/Berlin"
        format = " $icon $timestamp.datetime(f:%R) "

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_1}"
        idle_fg = "${britania_colors.foreground_1}"

        [[block]]
        block = "menu"
        text = "⏻"
        [[block.items]]
        display = " -&gt;   Sleep   &lt;-"
        cmd = "systemctl suspend"
        [[block.items]]
        display = " -&gt; Power Off &lt;-"
        cmd = "systemctl poweroff"
        confirm_msg = "Are you sure you want to power off?"
        [[block.items]]
        display = " -&gt;  Reboot   &lt;-"
        cmd = "systemctl reboot"
        confirm_msg = "Are you sure you want to reboot?"
      '';
    };

    home.file.".config/i3status-rust/config-bottom.toml" = let britania_colors = {
            foreground_1 = config.theme.color3;
            background_1 = config.theme.color1;

            foreground_2 = config.theme.color10;
            background_2 = config.theme.color2;

            foreground_3 = config.theme.color10;
            background_3 = config.theme.color3;

            foreground_4 = config.theme.color3;
            background_4 = config.theme.color4;

            foreground_5 = config.theme.color10;
            background_5 = config.theme.color5;

            foreground_6 = config.theme.color3;
            background_6 = config.theme.color6;

            foreground_7 = config.theme.color10;
            background_7 = config.theme.color7;
            
            foreground_8 = config.theme.color10;
            background_8 = config.theme.color8;
            
            foreground_9 = config.theme.color3;
            background_9 = config.theme.color9;

            foreground_10 = config.theme.color1;
            background_10 = config.theme.color10;
    }; in {
      text = ''
        [icons]
        icons = "awesome6"

        [theme]
        theme = "dracula"

        [[block]]
        block = "net"
        format = " $icon {$signal_strength $ssid $frequency|Wired connection} via $device "

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_9}"
        idle_fg = "${britania_colors.foreground_9}"

        [[block]]
        block = "xrandr"
        format = " $icon $brightness $resolution "


        [block.theme_overrides]
        idle_bg = "${britania_colors.background_8}"
        idle_fg = "${britania_colors.foreground_8}"

        [[block]]
        block = "external_ip"

        [block.theme_overrides]
        idle_bg = "${britania_colors.background_7}"
        idle_fg = "${britania_colors.foreground_7}"

      '';
    };
}
