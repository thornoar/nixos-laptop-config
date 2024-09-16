{ config, lib, pkgs, modulesPath, ... }:

{
    config = {
        fontsize = 10;
        fontsizeBar = 14;

        wallpaperDir = "Landscapes";
        wallpaperGamma = 0.9;
        wallpaperContrast = 1.0;
        
        font = "Hack";
        
        # windowSpace = lib.mkForce 36;
        windowSpace = 0;
        windowBorderWidth = 0;

        terminalOpacity = 0.9;
        terminalPadding = { x = 6; y = 4; };

        barHeight = lib.mkForce 36;

        magnifiedScale = 1.5;

        scratchpadWidth = lib.mkForce "4 % 5";
        scratchpadHeight = lib.mkForce "35 % 50";

        xmobarExtraCommands = lib.mkForce ''
            Run Battery [
                "--template" , "<acstatus>",
                "--Low"      , "10",        -- units: %
                "--High"     , "80",        -- units: %
                "--low"      , "red",
                "--normal"   , "orange",
                "--high"     , "green",
                "--",
                "-o", "<left>% (<timeleft>)",
                "-O", "<fc=${config.colorYellow1}>Charging</fc>",
                "-i", "<fc=${config.colorGreen0}>Charged</fc>"
            ] 50,
        '';
        # xmobarExtraOptions = ''
        #     alpha = ${builtins.toString (builtins.floor (255*config.windowOpacity))},
        # '';
        xmobarTemplate = lib.mkForce " %XMonadLog% }{ %kbd% | %date% | %battery% | %alsa:default:Master% ";

        # home.file.".Xmodmap".text = ''
        #     remove mod1 = Alt_R
        #
        #     clear mod4
        #     keycode 108 = Super_R
        #     add mod4 = Super_R
        # '';

        home.packages = with pkgs; [
            light
            xorg.xmodmap
            brightnessctl
            upower
            tlp
        ];
    };
}
