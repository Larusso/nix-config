{ config, pkgs, ... }:
{
    programs.ssh = {
        enable = true;

        extraOptionOverrides = {
            controlMaster = "auto";
            IgnoreUnknown = "UseKeychain";
            ControlPath = "/tmp/ssh_mux_%h_%p_%r";
            ControlPersist = "60m";
        };

        forwardAgent = false;
        compression = false;
        serverAliveInterval = 0;
        serverAliveCountMax = 3;
        hashKnownHosts = false;

        matchBlocks = {
            "github.com" = {
                extraOptions = {
                    IdentityFile = "~/.ssh/id_ed25519_sk_rk_github_private";
                    AddKeysToAgent = "yes";
                };
                identitiesOnly = true;
            };

            "gitlab.com" = {
                extraOptions = {
                    IdentityFile = "~/.ssh/id_ed25519";
                };
                identitiesOnly = true;
            };
        };

        extraConfig = ''
            AddKeysToAgent yes
            UseKeychain yes
        '';
    };
}