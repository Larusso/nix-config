{ config, lib, pkgs, ... }:

let
    extra = ''
      ${pkgs.autorandr}/bin/autorandr --change
    '';
in
{
    imports = [
        ../default.nix
    ];

    home.packages = [
      pkgs.scrot
    ];

    xresources.properties = {
        "Xft.dpi" = 180;
        "Xft.autohint" = 0;
        "Xft.hintstyle" = "hintfull";
        "Xft.hinting" = 1;
        "Xft.antialias" = 1;
        "Xft.rgba" = "rgb";
        "Xcursor*theme" = "Vanilla-DMZ-AA";
        "Xcursor*size" = 24;
    };




    programs.xmobar = {
        enable = true;
        extraConfig = ''
            Config
                { font        = "Fira Code"
                , borderColor = "#d0d0d0"
                , border      = FullB
                , borderWidth = 3
                , bgColor     = "#222"
                , fgColor     = "grey"
                , position    = TopSize C 99 30
                , commands    =
                    [ Run Cpu ["-t", "cpu: <fc=#4eb4fa><bar> <total>%</fc>"] 10
                    , Run Network "enp3s0" ["-S", "True", "-t", "eth: <fc=#4eb4fa><rx></fc>/<fc=#4eb4fa><tx></fc>"] 10
                    , Run Memory ["-t","mem: <fc=#4eb4fa><usedbar> <usedratio>%</fc>"] 10
                    , Run Date "date: <fc=#4eb4fa>%a %d %b %Y %H:%M:%S </fc>" "date" 10
                    , Run StdinReader
                    ]
                , sepChar     = "%"
                , alignSep    = "}{"
                , template    = "  %StdinReader% | %cpu% | %memory% | %enp3s0%  }{%date%  "
                }
        '';
    };
}
