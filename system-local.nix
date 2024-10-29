{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:

{
    config = {
        environment.variables = {
            PCTYPE = "laptop";
            MUTTER_DEBUG_KMS_THREAD_TYPE="user";
        };

        boot.kernelPackages = pkgs.linuxPackages_latest;

        services.xserver = {
            videoDrivers = [ "nvidiaLegacy390" ];
            # videoDrivers = [ "nvidia" ];
            displayManager = {
                sessionCommands = ''
                    # nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"
                    setxkbmap -layout us,ru,de
                    xset -dpms
                    setterm -blank 0 -powerdown 0
                    xset r rate 200 30
                    xset s off
                    transmission-daemon
                '';
            };
        };
        services.libinput = {
                enable = true;
                touchpad = {
                    naturalScrolling = true;
                    tapping = true;
                    clickMethod = "clickfinger";
                    disableWhileTyping = true;
                };
            };

        fileSystems."/home/ramak/media" = {
            device = "/dev/disk/by-uuid/aa543ce3-5cbd-4251-a01c-59ebe4a97f92";
            fsType = "ext4";
            options = [ "nofail" "rw" "user" "auto" ];
        };

        services.upower.enable = true;

        hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };
        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            nvidiaSettings = false;
            # forceFullCompositionPipeline = true;
            open = false;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
        };

        nixpkgs.config.nvidia.acceptLicense = true;

        hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
            settings = {
                General.Experimental = true;
            };
        };

        time.timeZone = "Asia/Hong_Kong";

        boot.blacklistedKernelModules = [ "nouveau" ];
    };
}
