{ config, pkgs, lib, ...}:
with lib;
let
  cfg = config.pokerus.darlings;
in
{
  options.pokerus.darlings = {
    enable = mkEnableOption "Darlings";
  };

  config = mkIf cfg.enable {
    environment.etc = {
      nixos.source = "/persist/etc/nixos";
      NIXOS.source = "/persist/etc/NIXOS";
      machine-id.source = "/persist/etc/machine-id";
      # cups.source = "/persist/etc/cups";
    };

    # systemd.tmpfiles.rules = [
      # "d /var/lib/libvirt 644 root root - -"
      # "L /var/lib/libvirt/storage - - - - /persist/var/lib/libvirt/storage"
      # "L /var/lib/libvirt/images - - - - /persist/var/lib/libvirt/images"
      # "L /var/lib/libvirt/qemu - - - - /persist/var/lib/libvirt/qemu"
      # "L /var/lib/libvirt/secrets - - - - /persist/var/lib/libvirt/secrets"
      # "L /var/lib/libvirt/nwfilter - - - - /persist/var/lib/libvirt/nwfilter"
      # "L /var/lib/libvirt/dnsmasq - - - - /persist/var/lib/libvirt/dnsmasq"
      # "L /var/lib/libvirt/qemu.conf - - - - /persist/var/lib/libvirt/qemu.conf"
    # ];

    security.sudo.extraConfig = ''
      # rollback results in sudo lectures after each reboot
      Defaults lecture = never
    '';

    boot.initrd.postDeviceCommands = pkgs.lib.mkBefore ''
      mkdir -p /mnt

      # We first mount the btrfs root to /mnt
      # so we can manipulate btrfs subvolumes.
      mount -o subvol=/ /dev/mapper/enc /mnt

      # While we're tempted to just delete /root and create
      # a new snapshot from /root-blank, /root is already
      # populated at this point with a number of subvolumes,
      # which makes `btrfs subvolume delete` fail.
      # So, we remove them first.
      #
      # /root contains subvolumes:
      # - /root/var/lib/portables
      # - /root/var/lib/machines
      #
      # I suspect these are related to systemd-nspawn, but
      # since I don't use it I'm not 100% sure.
      # Anyhow, deleting these subvolumes hasn't resulted
      # in any issues so far, except for fairly
      # benign-looking errors from systemd-tmpfiles.
      btrfs subvolume list -o /mnt/root |
      cut -f9 -d' ' |
      while read subvolume; do
        echo "deleting /$subvolume subvolume..."
        btrfs subvolume delete "/mnt/$subvolume"
      done &&
      echo "deleting /root subvolume..." &&
      btrfs subvolume delete /mnt/root

      echo "restoring blank /root subvolume..."
      btrfs subvolume snapshot /mnt/root-blank /mnt/root

      # Once we're done rolling back to a blank snapshot,
      # we can unmount /mnt and continue on the boot process.
      umount /mnt
    '';
  };
}
