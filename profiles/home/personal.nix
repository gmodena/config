{ config, lib, pkgs, ... }: {
  programs.git = {
    userEmail = "gmodena@pm.me";
    userName = "Gabriele Modena";
    # for git send-email
    smtpServer = "smtp.gmail.com";
    smtpServerPort = "587";
    smtpEncryption = "tls";
    smtpUser = "gabriele.modena@gmail.com";
  };
}
