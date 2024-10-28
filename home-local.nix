{ config, lib, pkgs, modulesPath, ... }:

{
    config = {
        size = lib.mkForce {
            fontsize = 10;
            fontsizeBar = 14;
            windowSpace = 2;
            windowBorderWidth = 0;
            terminalOpacity = 0.9;
            terminalPadding = { x = 3; y = 3; };
            barHeight = 36;
            magnifiedScale = 1.5;
        };

        wallpaper = lib.mkForce {
            dir = "Landscapes";
            gamma = 0.9;
            contrast = 1.0;
        };

        misc = lib.mkForce {
            usePackageList = true;   
            scratchpadWidth = "4 % 5";
            scratchpadHeight = "35 % 50";
            font = "Hack";
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
            # xmobarExtraOptions = ''
            #     alpha = ${builtins.toString (builtins.floor (255*config.size.windowOpacity))},
            # '';
            template = " %XMonadLog% }{ %kbd% | %date% | %battery% | %alsa:default:Master% ";
        };

        home.file.".Xmodmap".text = ''
            remove mod1 = Alt_R

            clear mod4
            keycode 108 = Super_R
            add mod4 = Super_R

            keysym F8 = U00B1
            keysym F9 = U03B5
            keysym F10 = U03B4
        '';

        home.packages = with pkgs; [
            light
            xorg.xmodmap
            brightnessctl
            upower
            tlp
        ];
    };
}
