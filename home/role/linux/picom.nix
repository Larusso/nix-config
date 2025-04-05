{ config, lib, pkgs, ... }:
{
    imports = [
      ./default.nix
    ];

    services.picom = {
        enable = false; #todo: use defaults and overrides!
        extraArgs = ["--no-vsync"];
        backend = "glx";
        vSync = false;
        #package = pkgs.picom-jonaburg;

    
        wintypes = {
            tooltip = { fade = false; shadow = false; };
            dock = { shadow = false; };
            dnd = { shadow = false; };
            popup_menu = { opacity = 0.8; };
            dropdown_menu = { opacity = 0.8; };
        };

        settings = {
            #################################
            #          Animations           #
            #################################
            # requires https://github.com/jonaburg/picom
            # (These are also the default values)
            transition-length = 150;
            transition-pow-x = 0.1;
            transition-pow-y = 0.1;
            transition-pow-w = 0.1;
            transition-pow-h = 0.1;
            size-transition = true;

            #################################
            #             Corners           #
            #################################
            # requires: https://github.com/sdhand/compton or https://github.com/jonaburg/picom
            corner-radius = 0.0;
            rounded-corners-exclude = [
              #"window_type = 'normal'"
              "class_g = 'awesome'"
              #"class_g = 'URxvt'"
              #"class_g = 'XTerm'"
              #"class_g = 'kitty'"
              ##"class_g = 'Alacritty'"
              "class_g = 'Polybar'"
              "class_g = 'i3bar'"
              ##"class_g = 'code-oss'"
              ##"class_g = 'TelegramDesktop'"
              #"class_g = 'firefox'"
              #"class_g = 'Thunderbird'"
            ];
            round-borders = 1;
            round-borders-exclude = [
              #"class_g = 'TelegramDesktop'",
            ];

            #################################
            #             Shadows           #
            #################################


            # Enabled client-side shadows on windows. Note desktop windows 
            # (windows with '_NET_WM_WINDOW_TYPE_DESKTOP') never get shadow, 
            # unless explicitly requested using the wintypes option.
            #
            # shadow = false
            shadow = true;

            # The blur radius for shadows, in pixels. (defaults to 12)
            # shadow-radius = 12
            shadow-radius = 20;

            # The opacity of shadows. (0.0 - 1.0, defaults to 0.75)
            shadow-opacity = 0.80;

            # The left offset for shadows, in pixels. (defaults to -15)
            # shadow-offset-x = -15
            shadow-offset-x = -20;

            # The top offset for shadows, in pixels. (defaults to -15)
            # shadow-offset-y = -15
            shadow-offset-y = -20;

            # Avoid drawing shadows on dock/panel windows. This option is deprecated,
            # you should use the *wintypes* option in your config file instead.
            #
            # no-dock-shadow = false

            # Don't draw shadows on drag-and-drop windows. This option is deprecated, 
            # you should use the *wintypes* option in your config file instead.
            #
            # no-dnd-shadow = false

            # Red color value of shadow (0.0 - 1.0, defaults to 0).
            # shadow-red = 0

            # Green color value of shadow (0.0 - 1.0, defaults to 0).
            # shadow-green = 0

            # Blue color value of shadow (0.0 - 1.0, defaults to 0).
            # shadow-blue = 0

            # Do not paint shadows on shaped windows. Note shaped windows 
            # here means windows setting its shape through X Shape extension. 
            # Those using ARGB background is beyond our control. 
            # Deprecated, use 
            #   shadow-exclude = 'bounding_shaped'
            # or 
            #   shadow-exclude = 'bounding_shaped && !rounded_corners'
            # instead.
            #
            # shadow-ignore-shaped = ''

            # Specify a list of conditions of windows that should have no shadow.
            #
            # examples:
            #   shadow-exclude = "n:e:Notification";
            #
            # shadow-exclude = []
            shadow-exclude = [
                "name = 'Notification'"
                "class_g = 'Conky'"
                "class_g ?= 'Notify-osd'"
                "class_g = 'Cairo-clock'"
                "class_g = 'slop'"
                "class_g = 'Polybar'"
                "class_g = 'i3bar'"
                "_GTK_FRAME_EXTENTS@:c"
            ];

            # Specify a X geometry that describes the region in which shadow should not
            # be painted in, such as a dock window region. Use 
            #    shadow-exclude-reg = "x10+0+0"
            # for example, if the 10 pixels on the bottom of the screen should not have shadows painted on.
            #
            # shadow-exclude-reg = "" 

            # Crop shadow of a window fully on a particular Xinerama screen to the screen.
            # xinerama-shadow-crop = false

            #################################
            #           Fading              #
            #################################


            # Fade windows in/out when opening/closing and when opacity changes,
            #  unless no-fading-openclose is used.
            # fading = false
            fading = true;

            # Opacity change between steps while fading in. (0.01 - 1.0, defaults to 0.028)
            # fade-in-step = 0.028
            fade-in-step = 0.03;

            # Opacity change between steps while fading out. (0.01 - 1.0, defaults to 0.03)
            # fade-out-step = 0.03
            fade-out-step = 0.03;

            # The time between steps in fade step, in milliseconds. (> 0, defaults to 10)
            # fade-delta = 10

            # Specify a list of conditions of windows that should not be faded.
            # don't need this, we disable fading for all normal windows with wintypes: {}
            fade-exclude = [
                "class_g = 'slop'"
            ];

            # Do not fade on window open/close.
            # no-fading-openclose = false

            # Do not fade destroyed ARGB windows with WM frame. Workaround of bugs in Openbox, Fluxbox, etc.
            # no-fading-destroyed-argb = false


            #################################
            #   Transparency / Opacity      #
            #################################


            # Opacity of inactive windows. (0.1 - 1.0, defaults to 1.0)
            # inactive-opacity = 1
            inactive-opacity = 1.0;

            # Opacity of window titlebars and borders. (0.1 - 1.0, disabled by default)
            # frame-opacity = 1.0
            frame-opacity = 0.7;

            # Default opacity for dropdown menus and popup menus. (0.0 - 1.0, defaults to 1.0)
            # menu-opacity = 1.0 
            # menu-opacity is depreciated use dropdown-menu and popup-menu instead.

            #If using these 2 below change their values in line 510 & 511 aswell
            popup_menu = { opacity = 0.8; };
            dropdown_menu = { opacity = 0.8; };

            # Let inactive opacity set by -i override the '_NET_WM_OPACITY' values of windows.
            # inactive-opacity-override = true
            inactive-opacity-override = false;

            # Default opacity for active windows. (0.0 - 1.0, defaults to 1.0)
            active-opacity = 1.0;

            # Dim inactive windows. (0.0 - 1.0, defaults to 0.0)
            # inactive-dim = 0.0
            inactive-dim = 0.2;

            # Specify a list of conditions of windows that should always be considered focused.
            # focus-exclude = []
            focus-exclude = [
                "class_g = 'Cairo-clock'"
                "class_g = 'Bar'"
                "class_g = 'slop'"
            ];

            # Use fixed inactive dim value, instead of adjusting according to window opacity.
            # inactive-dim-fixed = 1.0


            #################################
            #     Background-Blurring       #
            #################################


            # Parameters for background blurring, see the *BLUR* section for more information.
            # blur-method = 
            # blur-size = 12
            #
            # blur-deviation = false

            # Blur background of semi-transparent / ARGB windows. 
            # Bad in performance, with driver-dependent behavior. 
            # The name of the switch may change without prior notifications.
            #
            # blur-background = true;

            # Blur background of windows when the window frame is not opaque. 
            # Implies:
            #    blur-background 
            # Bad in performance, with driver-dependent behavior. The name may change.
            #
            # blur-background-frame = false;


            # Use fixed blur strength rather than adjusting according to window opacity.
            # blur-background-fixed = false;


            # Specify the blur convolution kernel, with the following format:
            # example:
            #   blur-kern = "5,5,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1";
            #
            # blur-kern = ''
            # blur-kern = "3x3box";

            blur = {
                # requires: https://github.com/ibhagwan/picom
                method = "dual_kawase";
                strength = 8;
                #method = "kernel";
                # deviation = 1.0;
                # kernel = "11x11gaussian";
                # background = false;
                # background-frame = false;
                # background-fixed = false;
                # kern = "3x3box";
            };

            # Exclude conditions for background blur.
            blur-background-exclude = [
                "class_g = 'i3bar'"
                #"window_type = 'desktop'",
                #"class_g = 'URxvt'",
                #
                # prevents picom from blurring the background
                # when taking selection screenshot with `main`
                # https://github.com/naelstrof/maim/issues/130
                "class_g = 'slop'"
                "_GTK_FRAME_EXTENTS@:c"
            ];

            vsync = true;
            mark-wmwin-focused = true;
            mark-ovredir-focused = true;
            detect-rounded-corners = true;
            detect-client-opacity = true;
            detect-transient = true;
            detect-client-leader = true;
        };

        opacityRules = [
            "80:class_g  = 'Bar'"
            "100:class_g = 'slop'"
            "100:class_g = 'XTerm'"
            "100:class_g = 'URxvt'"
            "80:class_g = 'kitty'"
            "100:class_g = 'Alacritty'"
            "80:class_g  = 'Polybar'"
            "98:class_g  = 'code-oss'"
            "100:class_g = 'Meld'"
            "70:class_g  = 'TelegramDesktop'"
            "90:class_g  = 'Joplin'"
            "100:class_g = 'firefox'"
            "100:class_g = 'Thunderbird'"
        ];
    };
}