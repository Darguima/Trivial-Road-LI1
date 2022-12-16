module Gloss_Functions.PlayGame where

import Gloss_Functions.GlossData ( Texturas, Estado, MenuAtual(JOGO, DERROTA), fr, dm, estadoInicial )
import Gloss_Functions.DesenhaEstado (desenharNovoEstado)
import Gloss_Functions.ReageEvento (reageEvento)
import Gloss_Functions.ReageTempo (reageTempo)

import Graphics.Gloss ( loadBMP ) 
import Graphics.Gloss.Interface.Environment ( getScreenSize )
import Graphics.Gloss.Interface.IO.Game ( black, playIO )

startGame :: IO ()
startGame = do 
  rio <- loadBMP "src/images/rio.bmp"
  tronco <- loadBMP "src/images/tronco.bmp"
  relva <- loadBMP "src/images/relva.bmp"
  arvore <- loadBMP "src/images/arvore.bmp"
  estrada <- loadBMP "src/images/estrada.bmp"
  carro <- loadBMP "src/images/carro.bmp"
  (_, alturaWindow) <- getScreenSize 

  let mapImages = [rio, tronco, relva, arvore, estrada, carro]

  playIO dm
    black
    fr
    (estadoInicial mapImages alturaWindow)
    desenharNovoEstado
    reageEvento
    reageTempo