{- |
Module      : Tarefa6_2022li1g031
Description : Implementação Gráfica
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2022/23.
-}
module Tarefa6_2022li1g031 where
import LI12223
import System.Random
import Graphics.Gloss 
import Graphics.Gloss.Interface.IO.Game
import Graphics.Gloss.Interface.Environment
import Tarefa5_2022li1g031 (deslizaJogo)
import Tarefa3_2022li1g031 (animaJogo)
import Tarefa4_2022li1g031 (jogoTerminou)
{-|
O objetivo desta tarefa consiste em aproveitar todas as funcionalidades já
elaboradas nas outras Tarefas e construir uma aplicação gráfica que permita
um utilizador jogar. Para o interface gráfico deverá utilizar a biblioteca
Gloss1 , que terá oportunidade de estudar durante as aulas práticas.
O grafismo e as funcionalidades disponibilizadas ficam à criatividade dos
alunos, sendo que, no mı́nimo, a aplicação deverá:

1. Ser capaz de gerar um mapa e permitir ao utilizador jogá-lo.
2. Implementar o efeito de deslize do mapa ao fim de um determinado tempo (à escolha do grupo.)
3. Implementar um sistema de pontuação, e.g. em função do tempo que o jogador está a jogar, ou quão longe o jogador já conseguiu chegar.
4. Detetar quando o jogador perde e reagir adequadamente, e.g mostrando uma mensagem, reiniciando o jogo, etc.
-}

data MenuAtual = INICIAL | JOGO | DERROTA

type Estado = (Jogo, Texturas, Int, MenuAtual)
type Texturas = [Picture]

tamanhoChunk :: Float
tamanhoChunk = 100

getInitialX :: Int -> Float
getInitialX larguraMapa = - (fromIntegral larguraMapa * tamanhoChunk) / 2 +  (tamanhoChunk / 2)

getInitialY :: Int -> Float
getInitialY alturaWindow = (fromIntegral alturaWindow / 2) - (tamanhoChunk / 2)

mapaInicial = Mapa 8 [(Estrada 2 , [Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Nenhum]), (Estrada 1, [Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Nenhum,Nenhum]), (Rio 1, [Tronco,Nenhum,Nenhum,Tronco,Tronco,Nenhum,Nenhum,Nenhum]),(Rio 2 , [Nenhum,Tronco,Nenhum,Tronco,Tronco,Nenhum,Nenhum,Nenhum]), (Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Nenhum,Nenhum]), (Estrada 2 , [Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Nenhum]), (Relva , [Nenhum,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum]), (Relva , [Nenhum,Nenhum,Arvore,Nenhum,Nenhum,Nenhum, Nenhum, Nenhum]), (Relva , [Nenhum,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum]), (Relva , [Nenhum,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum]), (Relva , [Nenhum,Nenhum,Arvore,Nenhum,Nenhum,Nenhum, Nenhum, Nenhum]), (Relva , [Nenhum,Arvore,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum])] 

getPosInicial :: Coordenadas
getPosInicial = getPosInicial_ mapaInicial
  where getPosInicial_ :: Mapa -> (Int, Int)
        getPosInicial_ (Mapa largura linhasMap@((_, linhaMapa) : _)) = (div (length linhaMapa) 2, length linhasMap - 4)


estadoInicial :: Texturas -> Int -> Estado
estadoInicial texturas alturaWindow = (Jogo (Jogador getPosInicial) mapaInicial, texturas, alturaWindow, JOGO )

desenharNovoEstado :: Estado -> IO Picture
desenharNovoEstado (Jogo (Jogador (posX, posY)) mapa@(Mapa larguraMapa _), texturas, alturaWindow, JOGO) = do
  return $ Pictures $ desenharMapa mapa texturas (getInitialX larguraMapa) (getInitialY alturaWindow) ++ [desenharPlayer posX posY larguraMapa alturaWindow]

  where desenharMapa :: Mapa -> Texturas -> Float -> Float -> [Picture]
  
        desenharMapa (Mapa l (linhaAtual : outrasLinhas)) texturas xInicial yInicial = 
          desenharLinha linhaAtual xInicial yInicial texturas ++ desenharMapa (Mapa l outrasLinhas) texturas xInicial (yInicial - tamanhoChunk)

        desenharMapa _ _ _ _ = []

        desenharLinha :: LinhaDoMapa -> Float -> Float -> Texturas -> [Picture]
        desenharLinha (terreno, chunkAtual : otherChunks) posX posY textures
          = desenharChunk terreno chunkAtual posX posY textures :  desenharLinha (terreno, otherChunks) (posX + tamanhoChunk) posY textures

        desenharLinha (_, []) _ _ _ = []

        desenharChunk :: Terreno -> Obstaculo -> Float -> Float -> Texturas -> Picture
        desenharChunk (Rio _) Nenhum posX posY texturas = Translate posX posY (texturas !! 0)
        desenharChunk (Rio _) Tronco posX posY texturas = Translate posX posY (texturas !! 1)
        desenharChunk Relva Nenhum posX posY texturas = Translate posX posY (texturas !! 2)
        desenharChunk Relva Arvore posX posY texturas = Translate posX posY (texturas !! 3)
        desenharChunk (Estrada _) Nenhum posX posY texturas = Translate posX posY (texturas !! 4)
        desenharChunk (Estrada _) Carro posX posY texturas = Translate posX posY (texturas !! 5)

        desenharPlayer :: Int -> Int -> Int -> Int -> Picture
        desenharPlayer posXJogador posYJogador larguraMapa alturaWindow = Translate posX posY $ color yellow $ circle 20
          where posX = getInitialX larguraMapa + fromIntegral posXJogador * tamanhoChunk
                posY = getInitialY alturaWindow - fromIntegral posYJogador * tamanhoChunk

desenharNovoEstado (jogo, texturas, alturaWindow, DERROTA) = return $ color red $ circle 20
desenharNovoEstado (jogo, texturas, alturaWindow, _) = return $ color green $ circle 20

reageEvento :: Event -> Estado -> IO Estado
reageEvento _ = return

reageTempo :: Float -> Estado -> IO Estado

reageTempo _ (jogo, texturas, alturaWindow, DERROTA) = do
  return (jogo, texturas, alturaWindow, DERROTA)

reageTempo _ (jogo, texturas, alturaWindow, JOGO) = do
  novoJogo <- deslizaJogo $ animaJogo jogo (Move Cima)
  let novoMenu = if jogoTerminou novoJogo then DERROTA else JOGO
  return (jogo, texturas, alturaWindow, novoMenu)

reageTempo _ (jogo, texturas, alturaWindow, menuAtual) = do
  return (jogo, texturas, alturaWindow, menuAtual)

fr :: Int
fr = 1

dm :: Display
dm = FullScreen  

play :: IO ()
play = do rio <- loadBMP "src/images/rio.bmp"
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