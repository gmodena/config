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
}
