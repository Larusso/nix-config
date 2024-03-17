{ config, lib ,...}:
with lib;
let kittyTheme = config.theme.kitty;
in {
    options = {
        theme.kitty = {
            enable = mkEnableOption "enable";
            foreground = mkOption { 
                type = types.str;
                example = "#171717";
                description = lib.mDoc "Primary Color for Theme";
            };

            background = mkOption { 
                type = types.str;
                example = "#171717";
                description = lib.mDoc "Primary Color for Theme";
            };

            selectionForeground = mkOption { 
                type = types.str;
                example = "#171717";
                description = lib.mDoc "Primary Color for Theme";
            };

            selectionBackground = mkOption { 
                type = types.str;
                example = "#171717";
                description = lib.mDoc "Primary Color for Theme";
            };

            ansi = {
                color0 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color8 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color1 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color9 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color2 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color10 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color3 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color11 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color4 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color12 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color5 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color13 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color6 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color14 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color7 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
                color15 = mkOption {
                    type = types.str;
                    example = "#171717";
                    description = lib.mDoc "Primary Color for Theme";
                };
            };
        };

        theme = {
            color1 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color2 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color3 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color4 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color5 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color6 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color7 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color8 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color9 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };
            color10 = mkOption {
                type = types.str;
                example = "#c34b37";
                description = lib.mDoc "Primary Color for Theme";
            };

        };
    };

    config = {
        programs.kitty.settings = if kittyTheme.enable then {
            "foreground" = kittyTheme.foreground;
            "background" = kittyTheme.background;
            "selection_foreground" = kittyTheme.selectionForeground;
            "selection_background" = kittyTheme.selectionBackground;
        } else {};
    };
}