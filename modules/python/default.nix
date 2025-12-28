{ vars, ... }:

{
  home-manager.users.${vars.username} = ./home-manager.nix;

  # Fix uv python ssl.SSLCertVerificationError
  # https://discourse.nixos.org/t/fix-ssl-sslcertverificationerror-with-uvs-standalone-python
  environment.etc.certfile = {
    source = "/etc/ssl/certs/ca-bundle.crt";
    target = "ssl/cert.pem";
  };
}
