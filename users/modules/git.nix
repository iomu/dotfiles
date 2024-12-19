{ config, pkgs, pkgs-stable, lib, ... }:
let
  globalGitIgnore = pkgs.writeText ".gitignore_global" ''
    .local-history
  '';
in {
  home.packages = with pkgs; [ git-crypt gh git-branchless ];

  programs.git = {
    enable = true;
    userName = "Johannes Müller";
    userEmail = config.custom.git.userEmail;
    aliases = {
      co = "checkout";
      ri = "rebase --interactive";
      st = "status";
      publish =
        "!sh -c 'git push origin HEAD:$(git rev-parse --abbrev-ref HEAD)' -";
      feature = "!sh -c 'git checkout -b jomu/$1 origin/main' -";

      # commit log
      lg = "lg1";
      lg1 = "lg1-specific --all";
      lg2 = "lg2-specific --all";
      lg3 = "lg3-specific --all";
      lg1-specific =
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'";
      lg2-specific =
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'";
      lg3-specific =
        "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'";

      # branchless
      sync = "branchless sync";
      sl = "branchless smartlog";
      record = "branchless record";
      undo = "branchless undo";
      prev = "branchless prev";
      next = "branchless next";
      submit = "branchless submit";
      sw = "branchless switch";
      restack = "branchless restack";
      amend = "branchless amend";
      reword = "branchless reword";
      move = "branchless move";
    };
    delta.enable = true;

    extraConfig = {
      core = {
        editor = "${config.programs.helix.package}/bin/hx";
        excludesFile = "${globalGitIgnore}";
      };
      url = {
        "git@ssh.dev.azure.com:v3/schwarzit/schwarzit.stackit-public/stackit-api" = {
          insteadOf = "https://dev.azure.com/schwarzit/schwarzit.stackit-public/stackit-api";
        };
      };
    };
  };
}
