{- |
Module      : Gloss_Functions.PlayGame
Description : Interface Gráfica do jogo
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo responsável pela interface gráfica do Jogo.
-}

module Gloss_Functions.PlayGame where

import Gloss_Functions.GlossData ( Texturas, Estado, PaginaAtual(JOGO, DERROTA), fr, dm, estadoInicial )

import Gloss_Functions.DesenhaEstado (desenharNovoEstado)
import Gloss_Functions.ReageEvento (reageEvento)
import Gloss_Functions.ReageTempo (reageTempo)

import Graphics.Gloss
import Graphics.Gloss.Interface.Environment ( getScreenSize )
import Graphics.Gloss.Interface.IO.Game ( black, playIO )

{- | A função 

== Exemplos de utilização:
>>> c
r
-}

{- | A função startGame é a responsável por comunicar diretamente com o Gloss.
  Para isso ela usa os módulos:

  * `Gloss_Functions.DesenhaEstado`
  * `Gloss_Functions.ReageEvento`
  * `Gloss_Functions.ReageTempo`
  * `Gloss_Functions.GlossData`

== Exemplos de utilização:
>>> startGame
-}

startGame :: IO ()
startGame = do 
  rio <- loadBMP "./assets/rio.bmp"
  tronco <- loadBMP "./assets/tronco.bmp"
  relva <- loadBMP "./assets/relva.bmp"
  arvore <- loadBMP "./assets/arvore.bmp"
  estrada <- loadBMP "./assets/estrada.bmp"
  carro <- loadBMP "./assets/carro.bmp"
  player <- loadBMP "./assets/player.bmp"
  carro1 <- loadBMP "./assets/carro1.bmp"
  carro2 <- loadBMP "./assets/carro2.bmp"
  carro3 <- loadBMP "./assets/carro3.bmp"
  carro4 <- loadBMP "./assets/carro4.bmp"
  carro5 <- loadBMP "./assets/carro5.bmp"
  carro6 <- loadBMP "./assets/carro6.bmp"
  carro7 <- loadBMP "./assets/carro7.bmp"
  carro8 <- loadBMP "./assets/carro8.bmp"
  carro9 <- loadBMP "./assets/carro9.bmp"
  carro10 <- loadBMP "./assets/carro10.bmp"
  jogar <- loadBMP "./assets/jogar.bmp"
  sobre <- loadBMP "./assets/sobre.bmp"
  sair <- loadBMP "./assets/sair.bmp"
  sobre_dentro <- loadBMP "./assets/sobre_dentro.bmp"
  opcao_sim <- loadBMP "./assets/simsair.bmp"
  opcao_nao <- loadBMP "./assets/naosair.bmp"
  continuar <- loadBMP "./assets/continuar.bmp"
  menu <- loadBMP "./assets/menu.bmp"
  derrota<-loadBMP "./assets/derrota.bmp"
  derrotap<- loadBMP "./assets/derrotap.bmp"
  comandos <- loadBMP "./assets/comandos.bmp"
  carronegativo <- loadBMP "./assets/carronegativo.bmp"
  bot <- loadBMP "./assets/Bot.bmp"
  jogador <- loadBMP "./assets/jogador.bmp"
  
  let tamanhoJanela = (1920, 1080)

  let mapImages = [rio, tronco, relva, arvore, estrada, carro, player, carro1, carro2, carro3, carro4, carro5, carro6,carro7,carro8,carro9,carro10,jogar,sobre,sair,sobre_dentro,opcao_sim,opcao_nao,continuar,menu,derrota,derrotap,comandos,carronegativo,bot,jogador]

  playIO dm
    black
    fr
    (estadoInicial mapImages (1920,1080))
    desenharNovoEstado
    reageEvento
    reageTempo