{ config, pkgs, ... }:
{
    programs.direnv = {
        enable = true;
        enableZshIntegration = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
        stdlib = ''
        use_jenv() {
            export JENV_ROOT=''${XDG_DATA_HOME:-$HOME/.local/share}/jenv
            eval "$(command jenv init -)"
        }

        use_rbenv() {
            export RBENV_ROOT=''${XDG_DATA_HOME:-$HOME/.local/share}/rbenv
            eval "$(command ${pkgs.rbenv}/bin/rbenv init -)" 
        }

        use_pyenv() {
            export RBENV_ROOT=''${XDG_DATA_HOME:-$HOME/.local/share}/pyenv
            eval "$(command pyenv init -)"
        }

        use_nodenv() {
            export RBENV_ROOT=''${XDG_DATA_HOME:-$HOME/.local/share}/nodenv
            eval "$(command ${pkgs.nodenv}/bin/nodenv init -)"
        }

        alias_dir=''${XDG_DATA_HOME:-$HOME/.local/share}/direnv/aliases
        rm -rf "$alias_dir"

        export_alias() {
            local name=$1
            shift
            local target="$alias_dir/$name"
            mkdir -p "$alias_dir"
            PATH_add "$alias_dir"
            echo "#!/usr/bin/env bash" > "$target"
            echo "$@ \"\$@\"" >> "$target"
            chmod +x "''$target"
            1>&2 echo "direnv: export alias +$name"
        }
        '';
    };
}