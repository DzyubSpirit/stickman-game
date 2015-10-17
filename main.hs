module Main where

import Graphics.UI.GLUT
import Data.IORef
import qualified Data.Map as M
import Bindings
import StickMan

animate :: IORef StickMan -> IORef (M.Map Char Bool) -> IO ()
animate io_player io_keysState = do
    player <- get io_player
    keysState <- get io_keysState

    let toRight = if M.lookup 'd' keysState == Just True then 1 else 0
        toLeft  = if M.lookup 'a' keysState == Just True then -1 else 0
        slowing = multByNum (-0.4) $ vel player 
        acc' = Vector2 ((toRight + toLeft)*0.1) 0 + slowing
        (player', more) = makePartOfStep 0.1 . calculateVel 0.1 $ player { acc = acc'} 
    --print $ vel player'

    io_player $= player'
    postRedisplay Nothing
    addTimerCallback 33 $ animate io_player io_keysState

main :: IO ()
main = do
    (_progName, _args) <- getArgsAndInitialize
    initialWindowSize $= Size 640 480
    _window <- createWindow "Hello, world!"

    clearColor $= Color4 1 1 1 1

    player <- newIORef $ standingMan (0, 0)
    keysState <- newIORef $ emptyKeysState

    displayCallback $= display player
    keyboardMouseCallback $= (Just $ keyboardMouse player keysState)

    addTimerCallback 33 $ animate player keysState
    mainLoop

emptyKeysState :: M.Map Char Bool
emptyKeysState = M.fromList []
