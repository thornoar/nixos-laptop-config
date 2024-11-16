{ config, lib, pkgs, modulesPath, ... }:

{
    config = {
        home.pointerCursor.size = 16;

        xmonad = lib.mkForce {
            desktopScale = 2.0;
            fontsize = 10;
            fontsizeXmobar = 22;
            windowSpaceInner = 4;
            windowSpaceOuter = 8;
            windowBorderWidth = 0;
            terminalOpacity = 0.9;
            terminalPaddingX = 3;
            terminalPaddingY = 3;
            barHeight = 50;
            magnifiedScale = 1.5;
            scratchpadWidth = "4 % 5";
            scratchpadHeight = "35 % 50";
        };

        hyprland = lib.mkForce {
            desktopScale = 2.0;
            fontsize = 11;
            fontsizeWaybar = 11;
            windowSpaceInner = 4;
            windowSpaceOuter = 8;
            windowBorderWidth = 0;
            terminalOpacity = 0.9;
            terminalPadding = 1;
            rounding = 5;
            barHeight = 50;
        };

        wallpaper = lib.mkForce {
            dir = "Wallpapers";
            gamma = 0.9;
            contrast = 1.0;
        };

        misc = lib.mkForce {
            usePackageList = true;   
            systemFont = "Hack";
            monitorName = "eDP-1";
        };

        xmobar = lib.mkForce {
            extraCommands = ''
                Run Battery [
                    "--template" , "<acstatus>",
                    "--Low"      , "10",        -- units: %
                    "--High"     , "80",        -- units: %
                    "--low"      , "red",
                    "--normal"   , "orange",
                    "--high"     , "green",
                    "--",
                    "-o", "<left>% (<timeleft>)",
                    "-O", "<fc=${config.colors.colorYellow1}>Charging</fc>",
                    "-i", "<fc=${config.colors.colorGreen0}>Charged</fc>"
                ] 50,
                -- Run Brightness [
                --     "-t", "Br: <percent>%", "--", "-D", "intel_backlight"
                -- ] 60,
                -- Run Brightness [
                --     "-t", "<bar>", "--", "-D", "/sys/class/backlight/intel_backlight"
                -- ] 60,
            '';
            extraOptions  = ""; # {
            template = " %XMonadLog% } %alsa:default:Master% | %date% { %kbd% | %multicpu% | %memory% | %battery% "; # }
        };
    };
}
