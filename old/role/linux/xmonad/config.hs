import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops


import XMonad.Util.EZConfig
import XMonad.Util.Ungrab

myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
    where
        threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
        tiled    = Tall nmaster delta ratio
        nmaster  = 1      -- Default number of windows in the master pane
        ratio    = 1/2    -- Default proportion of screen occupied by master pane
        delta    = 3/100  -- Percent of screen to increment by when resizing panes


main :: IO ()
main = xmonad $ ewmhFullscreen $ ewmh $ xmobarProp $ def
    { modMask = mod4Mask
    , layoutHook = myLayout
    , terminal = "kitty"
    , borderWidth = 5
    }
    `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-b"  , spawn "firefox"                   )
    ]
