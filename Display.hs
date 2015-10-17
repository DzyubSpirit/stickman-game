module Display(display) where

import Graphics.UI.GLUT
import Data.IORef
import StickMan

myPoints :: [(GLfloat, GLfloat, GLfloat)]
myPoints = [(cos.angle$k, sin.angle$k,0) | k <- [1..12]]
     where angle k = 2*pi*k/12 

vertex2f :: (GLfloat, GLfloat) -> IO ()
vertex2f (x, y) = vertex $ Vertex3 x y 0 

color3 :: (GLfloat, GLfloat, GLfloat) -> IO ()
color3 (r, g, b) = color $ Color3 r g b

display :: IORef StickMan -> DisplayCallback
display player = do
    playerEx <- get player
    let Vector2 playerX playerY = coords playerEx
        cur_cur_step = cur_step playerEx
        cur_step_moment = step_moment playerEx
        cur_another_leg = another_leg playerEx
        dx = abs (playerX - cur_another_leg)
        mid = (playerX + (another_leg playerEx)) / 2
        left_mid_x = (playerX + mid) / 2 + 0.2  * dx  * 1.5
        left_mid_y = -0.7 - (playerX - mid) / 2 * dx * 1.5
        right_mid_x = (cur_another_leg + mid) / 2 + 0.2  * dx  * 1.5
        right_mid_y = -0.7 - (cur_another_leg - mid) / 2 * dx * 1.5
    clear [ColorBuffer]
    renderPrimitive Lines $ do
        color3(0, 0, 0)
        vertex2f (-1, -0.8)
        vertex2f (1, -0.8)
        vertex2f (playerX, -0.8)
        vertex2f (left_mid_x, left_mid_y)
        vertex2f (left_mid_x, left_mid_y)
        vertex2f (mid, -0.6)
        vertex2f (cur_another_leg, -0.8)
        vertex2f (right_mid_x, right_mid_y)
        vertex2f (right_mid_x, right_mid_y)        
        vertex2f (mid, -0.6)
    flush