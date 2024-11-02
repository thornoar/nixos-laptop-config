{ config, lib, pkgs, pkgs-old, pkgs-unstable, modulesPath, ... }:

{
    config = {
        environment.variables = {
            PCTYPE = "laptop";
            MUTTER_DEBUG_KMS_THREAD_TYPE="user";
        };

        boot.kernelPackages = pkgs.linuxPackages_latest;

        hardware.nvidia = {
            modesetting.enable = true;
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            nvidiaSettings = true;
            forceFullCompositionPipeline = true;
            open = false;
            package = config.boot.kernelPackages.nvidiaPackages.production;
            prime = {
                sync.enable = false; 
                nvidiaBusId = "PCI:1:0:0"; 
                intelBusId = "PCI:0:2:0"; 
            };
        };
        nixpkgs.config.nvidia.acceptLicense = true;
        boot.blacklistedKernelModules = [ "nouveau" ];

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
            resumeCommands = "${pkgs.kmod}/bin/rmmod atkbd; ${pkgs.kmod}/bin/modprobe atkbd reset=1";
        };

        hardware.opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };

        services.cron = {
            enable = true;
            systemCronJobs = [
                "*/1 * * * * root ${pkgs.coreutils}/bin/echo disable > /sys/firmware/acpi/interrupts/sci"
                "*/1 * * * * root ${pkgs.coreutils}/bin/echo disable > /sys/firmware/acpi/interrupts/gpe6F"
                "@reboot root ${pkgs.coreutils}/bin/echo disable > /sys/firmware/acpi/interrupts/sci"
                "@reboot root ${pkgs.coreutils}/bin/echo disable > /sys/firmware/acpi/interrupts/gpe6F"
            ];
        };

        hardware.bluetooth = {
            enable = true;
            powerOnBoot = true;
            settings = {
                General.Experimental = true;
            };
        };

        time.timeZone = "Asia/Hong_Kong";

        environment.systemPackages = with pkgs; [
            light
            brightnessctl
        ];
    };
}
