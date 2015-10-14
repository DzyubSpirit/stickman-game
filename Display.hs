module Display(display) where

import Graphics.UI.GLUT

myPoints :: [(GLfloat, GLfloat, GLfloat)]
myPoints = [(cos.angle$k, sin.angle$k,0) | k <- [1..12]]
     where angle k = 2*pi*k/12 

display :: DisplayCallback
display = do
	clear [ColorBuffer]
	renderPrimitive Points $
	    mapM_ (\(x, y, z) -> vertex $ Vertex3 x y z) myPoints
	flush	