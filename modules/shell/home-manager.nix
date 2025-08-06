{ vars, pkgs, ... }:

{
  home.shell.enableShellIntegration = true;

  home.packages = with pkgs; [
    bat
    ffmpeg
    file
    git
    ripgrep-all
    unzip
    zip

    # You can also create simple shell scripts directly inside your
    # configuration. For example, this adds a command 'my-hello' to your
    # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    # echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        # https://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
        PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

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

    starship = {
      enable = true;
      settings = {
        battery = {
          display = [
            { threshold = 10; style = "bold red"; }
            { threshold = 20; style = "bold yellow"; }
          ];
        };

        nix_shell = {
          format = ''via [$symbol$name]($style) '';
        };
      };
    };

    nh = {
      enable = true;
      flake = vars.config-path;
    };

    yt-dlp.enable = true;
  };

  home.shellAliases = {
    grep = "rga";
  };
}
