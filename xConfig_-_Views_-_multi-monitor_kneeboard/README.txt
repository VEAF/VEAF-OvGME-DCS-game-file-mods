Allow to finely position the kneeboard, even on multiple monitors (or in VR)
Edit the ViewportHandling.lua file to set up the desired position (first four lines of the file) :
    
	local kneeY = 1400 -- vertical size
    local kneeX = 962 -- horizontal size
    local kneePosY = 20 -- offset from topmost monitor 
    local kneePosX = 2400 -- offset from leftmost monitor 


Permet de positionner le kneeboard exactement là où on le veut, y compris sur un système à plusieurs écrans (ou en VR).
Editez le fichier ViewportHandling.lua pour définir la position exacte du kneeboard (les 4 premières lignes du fichier)

	local kneeY = 1400 -- taille verticale
    local kneeX = 962 --  taille horizontale
    local kneePosY = 20 -- décalage vertical à partir du point le plus haut de tous les écrans
    local kneePosX = 2400 -- décalage horizontal à partir du point le plus à gauche de tous les écrans

---------------------------------------
-- Tested with DCS World 2.5.6.49314 --
---------------------------------------

Made by Zip, may contain work from other people of the DCS forum.
http://www.veaf.org