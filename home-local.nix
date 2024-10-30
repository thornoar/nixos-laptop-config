{ config, lib, pkgs, modulesPath, ... }:

{
    config = {
        size = lib.mkForce {
            fontsize = 10;
            fontsizeBar = 21;
            windowSpace = 4;
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

        home.file.".Xmodmap".text = ''
            remove mod1 = Alt_R

            clear mod4
            keycode 108 = Super_R
            add mod4 = Super_R

            keysym F8 = U00B1
            keysym F9 = U03B5
            keysym F10 = U03B4

            keycode  79 =  Home   Home   Home   Home
            keycode  80 =  Up     Up     Up     Up
            keycode  81 =  Prior  Prior  Prior  Prior
            keycode  83 =  Left   Left   Left   Left
            keycode  85 =  Right  Right  Right  Right
            keycode  87 =  End    End    End    End
            keycode  88 =  Down   Down   Down   Down
            keycode  89 =  Next   Next   Next   Next
            keycode  104 =  Return   Return   Return   Return
        '';

        home.packages = with pkgs; [
            light
            xorg.xmodmap
            brightnessctl
        ];
    };
}
