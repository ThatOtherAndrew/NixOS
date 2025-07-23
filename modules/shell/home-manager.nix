{ vars, ... }:

{
  programs = {
    bash = {
      enable = true;
      initExtra = ''
        what() {
          target=$(which "$1") || return 1
          echo "-> $target"
          while [ -L "$target" ]; do
            target=$(readlink -f "$target")
            echo "-> $target"
          done
          echo -n "== "
          file -b "$target"
        }
      '';
    };

    git = {
      enable = true;
      userName = vars.display-name;
      userEmail = vars.email;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };

    zoxide = {
      enable = true;
      options = [
        "--cmd cd"
      ];
    };

    starship.enable = true;

    nh = {
      enable = true;
      flake = vars.config-path;
    };

    yt-dlp.enable = true;
  };
}
