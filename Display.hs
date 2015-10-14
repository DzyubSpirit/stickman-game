module Display(display) where

import Graphics.UI.GLUT
import StickMan

myPoints :: [(GLfloat, GLfloat, GLfloat)]
myPoints = [(cos.angle$k, sin.angle$k,0) | k <- [1..12]]
     where angle k = 2*pi*k/12 

vertex2f :: (GLfloat, GLfloat) -> IO ()
vertex2f (x, y) = vertex $ Vertex3 x y 0 

color3 :: (GLfloat, GLfloat, GLfloat) -> IO ()
color3 (r, g, b) = color $ Color3 r g b

display :: DisplayCallback
display = do
	clear [ColorBuffer]
	renderPrimitive Lines $ do
		color3(0, 0, 0)
		vertex2f (-1, -0.8)
		vertex2f (1, -0.8)
	flush	