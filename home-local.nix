{ config, lib, pkgs, modulesPath, ... }:

{
    config = {
        size = lib.mkForce {
            fontsize = 10;
            fontsizeXmobar = 22;
            fontsizeWaybar = 11;
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

        wallpaper = lib.mkForce {
            dir = "Wallpapers";
            gamma = 0.9;
            contrast = 1.0;
        };

        misc = lib.mkForce {
            usePackageList = true;   
            systemFont = "Hack";
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
            '';
            extraOptions  = "";
            template = " %XMonadLog% }{ %kbd% | %date% | %battery% | %alsa:default:Master% ";
        };
    };
}
