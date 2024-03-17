{ config, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userEmail = "manfred.endres@tslarusso.de";
    userName = "Manfred Endres";
    signing.key = "EF8E6FD1";
    signing.signByDefault = true;
    lfs.enable = true;
    diff-so-fancy.enable = false;
    difftastic.enable = false;

    ignores = [
      "*~"
      ".DS_Store"
      "atlassian-ide-plugin.xml"
      ".ant-targets-*.xml"
      "*.ipr"
      "*.iws"
      "*.sublime-project"
      "*.sublime-workspace"
      "*.iml"
      ".idea/"
      "auth.txt"
      "*.apk"
      "*.tar.gz"
      "stale_outputs_checked"
      ".envrc "
    ];

    extraConfig = {
      #url = { "git@github.com:" = { insteadOf = "https://github.com/"; }; };

      core = {
        quotepath = false;
        autocrlf = "input";
        editor = "${pkgs.vim}/bin/vim";
        commitGraph = true;
      };

      diff = {
        tool = "kitty";
        guitool = "kitty.gui";
      };

      difftool = {
        prompt = false;
        trustExitCode = true;

        "kitty" = {
          cmd = "${pkgs.kitty}/bin/kitty +kitten diff $LOCAL $REMOTE";
        };

        "kitty.gui" = {
          cmd = "${pkgs.kitty}/bin/kitty kitty +kitten diff $LOCAL $REMOTE";
        };
      };

      user.useConfigOnly = true;
      push.default = "current";
      merge.tool = "${pkgs.vim}/bin/vimdiff";
      merge.conflictstyle = "diff3";
      mergetool.prompt = false;
      color.ui = "auto";
      rebase.autoStash = true;
      pull.rebase = true;
      tag.gpgsign = true;

      init.defaultBranch = "master";
    };

    includes = [
      {
        contents = {
          user = {
	          name = "Manfred Endres";
	          email = "manfred.endres@wooga.net";
	          useConfigOnly = true;
          };
          
          init.defaultBranch = "master";
          url = { "git@github.com:" = { insteadOf = "https://github.com/"; }; };
        };
        contentSuffix = "wooga.gitconfig";
        condition = "gitdir:work/wooga/";
      }
    ];

    aliases = {
      ci = "commit";
      co = "checkout";
      commend = "commit --amend --no-edit";
      fco = "!git co $(git branch | fzf)";
      fix-message = "commit --amend --allow-empty";

      lg = "!git lg1";
      graph = "!git lg";
      lg1 = ''!sh -c "git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' $*"'';
	    lg2 = "!sh -c \"git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' $*\"";
	    lg3 = "!sh -c \"git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)' $*\"";
      #last-commit = ''#!sh -c \"git log -2 --pretty=tformat:\\\"%H\\\" --author=\\\"`git config user.name`\\\" $*\"'';

      #prune-all = "!git remote | xargs -n 1 git remote prune";
      #prune-merged = "!git branch -d $(git branch --merged)";
      #st = "status -s";
    };
  };
}