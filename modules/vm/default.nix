{ vars, ... }:

{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ vars.username ];
  users.users.${vars.username}.extraGroups = [ "libvirtd" ];
  virtualisation.libvirtd = {
    enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;
}
