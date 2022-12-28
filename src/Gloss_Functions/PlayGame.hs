module Gloss_Functions.PlayGame where

import Gloss_Functions.GlossData ( Texturas, Estado, PaginaAtual(JOGO, DERROTA), fr, dm, estadoInicial )
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
  player <- loadBMP "src/images/player.bmp"
  carro1 <- loadBMP "src/images/carro1.bmp"
  carro2 <- loadBMP "src/images/carro2.bmp"
  carro3 <- loadBMP "src/images/carro3.bmp"
  carro4 <- loadBMP "src/images/carro4.bmp"
  carro5 <- loadBMP "src/images/carro5.bmp"
  carro6 <- loadBMP "src/images/carro6.bmp"
  carro7 <- loadBMP "src/images/carro7.bmp"
  carro8 <- loadBMP "src/images/carro8.bmp"
  carro9 <- loadBMP "src/images/carro9.bmp"
  carro10 <- loadBMP "src/images/carro10.bmp"
  jogar <- loadBMP "src/images/jogar.bmp"
  sobre <- loadBMP "src/images/sobre.bmp"
  sair <- loadBMP "src/images/sair.bmp"
  sobre_dentro <- loadBMP "src/images/sobre_dentro.bmp"
  opcao_sim <- loadBMP "src/images/simsair.bmp"
  opcao_nao <- loadBMP "src/images/naosair.bmp"
  continuar <- loadBMP "src/images/continuar.bmp"
  menu <- loadBMP "src/images/menu.bmp"
  
  -- tamanhoJanela <- getScreenSize 
  let tamanhoJanela = (1920, 1080)

  let mapImages = [rio, tronco, relva, arvore, estrada, carro, player, carro1, carro2, carro3, carro4, carro5, carro6,carro7,carro8,carro9,carro10,jogar,sobre,sair,sobre_dentro,opcao_sim,opcao_nao,continuar,menu]

  playIO dm
    black
    fr
    (estadoInicial mapImages tamanhoJanela)
    desenharNovoEstado
    reageEvento
    reageTempo