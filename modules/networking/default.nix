{ ... }:

{
  environment.etc = {
    "ssl/certs/uos.crt" = {
      source = ./certs/uos.crt;
    };
  };

  networking.networkmanager.ensureProfiles.profiles = {
    eduroam = {
      connection = {
        id = "eduroam";
        type = "wifi";
      };
      wifi = {};
      "802-11-wireless-security" = {
        key-mgmt = "wpa-eap";
      };
      "802-1x" = {
        eap = "ttls";
        phase2-auth = "pap";
        identity = "anonymous@st-andrews.ac.uk";
        anonymous-identity = "@st-andrews.ac.uk";
        ca-cert = "/etc/ssl/certs/uos.crt";
        altsubject-matches = "dot1x.st-andrews.ac.uk";
        password-flags = "1";
      };
    };
  };
}
