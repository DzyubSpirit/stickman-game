module Bindings(display
               ,reshape
               ,keyboardMouse
               ) where

import Graphics.UI.GLUT
import Data.IORef
import StickMan
import Display
import Control.Monad
import Data.Map

reshape :: ReshapeCallback
reshape size = do
    viewport $= (Position 0 0, size)

keyboardMouse :: IORef StickMan -> IORef (Map Char Bool) -> KeyboardMouseCallback
keyboardMouse io_player io_keysState _key _state _modifiers _position = do
    player <- get io_player
    keysState <- get io_keysState
    --print _state
    case _key of
        Char ch -> io_keysState $= insert ch (_state == Down) keysState
        _ -> return ()