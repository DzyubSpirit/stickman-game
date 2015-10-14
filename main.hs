module Main where

import Graphics.UI.GLUT
import Bindings

main :: IO ()
main = do
    (_progName, _args) <- getArgsAndInitialize
    initialWindowSize $= Size 640 480
    _window <- createWindow "Hello, world!"

    

    displayCallback $= display
    mainLoop

