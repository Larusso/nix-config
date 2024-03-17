{ config, pkgs, ... }:
let
    theme = config.theme;
in {
    imports = [ 
        ./default.nix
    ];
    
    config = {
        theme.color1 = "#050622";
        theme.color2 = "#983069";
        theme.color3 = "#c34b37";
        theme.color4 = "#07072a";
        theme.color5 = "#c1224e";
        theme.color6 = "#1e0f39";
        theme.color7 = "#a6175c";
        theme.color8 = "#950c7d";
        theme.color9 = "#050622";
        theme.color10 = "#e1fc11";

        theme.kitty = {
            enable = true;
            foreground = "#f8f8f0";
            background = theme.color6;

            selectionForeground = theme.color6;
            selectionBackground = theme.color10;
        };
    };
}
