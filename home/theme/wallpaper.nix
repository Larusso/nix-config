{ config,...}:
{
    home.file.".config/i3/wallpapers" = {
      source = ./wallpaper;
      recursive = true;
    };
}