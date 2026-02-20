{ config, lib, pkgs, ... }: {
  programs.git = {
    userEmail = "gmodena@pm.me";
    userName = "Gabriele Modena";
    extraConfig = {
      sendmail = {
        # for git send-email
        smtpserver = "smtp.gmail.com";
        smtpserverPort = "587";
        smtpencryption = "tls";
        smtpuser = "gabriele.modena@gmail.com";
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" "toml" "rust" "python" "zig" "golang" ];
    userSettings = {
      theme = {
        mode = "system";
        dark = "One Dark";
        light = "One Light";
      };
      hour_format = "hour24";
      vim_mode = true;
    };
  };
}
