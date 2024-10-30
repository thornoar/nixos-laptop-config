{ config, lib, pkgs, pkgs-unstable, modulesPath, ... }:

{
    config = {
        environment.variables = {
            PCTYPE = "laptop";
            MUTTER_DEBUG_KMS_THREAD_TYPE="user";
        };

        boot.kernelPackages = pkgs.linuxPackages_latest;

        services.xserver = {
            # videoDrivers = [ "nvidiaLegacy470" ];
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

        services = {
            upower.enable = true;
            thermald.enable = true;
            tlp = {
                enable = true;
                settings = {
                    CPU_BOOST_ON_AC = 1;
                    CPU_BOOST_ON_BAT = 0;
                    CPU_SCALING_GOVERNOR_ON_AC = "performance";
                    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
                    START_CHARGE_THRESH_BAT0 = 50;
                    STOP_CHARGE_THRESH_BAT0 = 80;
                };
            };
        };
        
        powerManagement = {
            enable = true;
            powertop.enable = true;
            cpuFreqGovernor = "powersave";
        };

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
            forceFullCompositionPipeline = true;
            open = true;
            package = config.boot.kernelPackages.nvidiaPackages.stable;
            prime = {
                sync.enable = true; 
                nvidiaBusId = "PCI:1:0:0"; 
                intelBusId = "PCI:0:2:0"; 
            };
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
