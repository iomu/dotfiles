{ config, pkgs, pkgs-stable, lib, ... }:
let
  globalGitIgnore = pkgs.writeText ".gitignore_global" ''
    .local-history
  '';
in {
  home.packages = with pkgs; [ git-crypt gh git-branchless lazygit ];

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Johannes Müller";
        email = config.custom.git.userEmail;
      };
      alias = {
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

      core = {
        editor = "${config.programs.helix.package}/bin/hx";
        excludesFile = "${globalGitIgnore}";
      };
      # https://blog.gitbutler.com/how-git-core-devs-configure-git/
      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };
      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };
      help.autocorrect = "prompt";
      commit.verbose = true;
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      pull.rebase = true;
      merge.conflictstyle = "zdiff3";
      url = {
        "git@ssh.dev.azure.com:v3/schwarzit/schwarzit.stackit-public/stackit-api" =
          {
            insteadOf =
              "https://dev.azure.com/schwarzit/schwarzit.stackit-public/stackit-api";
          };
        "git@ssh.dev.azure.com:v3/schwarzit/schwarzit.stackit-public" =
          {
            insteadOf =
              "https://dev.azure.com/schwarzit/schwarzit.stackit-public";
          };
      };
    };
  };
}
