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

type State = (Jogo,Texturas)
type Texturas = [Picture]

initialX:: Float
initialX = -400

initialY:: Float
initialY =  540

initialMap = Mapa 8 [(Rio 5, [Nenhum, Tronco, Nenhum,Nenhum,Nenhum,Nenhum,Tronco,Tronco]), (Estrada 2 , [Nenhum,Carro,Nenhum,Carro,Carro,Nenhum,Carro,Carro]), (Estrada 2 , [Nenhum,Carro,Nenhum,Nenhum,Carro,Nenhum,Nenhum,Carro]), (Rio 2 , [Nenhum,Tronco,Nenhum,Tronco,Tronco,Nenhum,Nenhum,Nenhum]), (Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Nenhum,Nenhum]), (Estrada 2 , [Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Nenhum]), (Estrada 1, [Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Nenhum,Nenhum]), (Rio 1, [Tronco,Nenhum,Nenhum,Tronco,Tronco,Nenhum,Nenhum,Nenhum]),(Rio 2 , [Nenhum,Tronco,Nenhum,Tronco,Tronco,Nenhum,Nenhum,Nenhum]), (Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore,Nenhum,Nenhum,Nenhum]), (Estrada 2 , [Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Nenhum])] 

initialState :: Texturas->State
initialState textures = (Jogo (Jogador (0, 0)) initialMap, textures)

drawNewState :: State -> IO Picture
drawNewState (Jogo _ map, textures) = return $ Pictures $ drawMap map textures initialX initialY

  where drawMap :: Mapa -> Texturas -> Float -> Float -> [Picture]
  
        drawMap (Mapa l ((_, chunks) : otherLines)) textures initialX initialY = 
          drawLines chunks initialX initialY textures ++ drawMap (Mapa l otherLines) textures initialX (initialY - 100)

        drawMap _ _ _ _ = []

        drawLines :: [Obstaculo] -> Float -> Float -> Texturas -> [Picture]
        drawLines (currentChunk : otherChunks) posX posY textureList
          = drawChunk currentChunk posX posY textureList :  drawLines otherChunks (posX + 100) posY textureList

        drawLines [] _ _ _ = [] 

        drawChunk :: Obstaculo -> Float -> Float -> Texturas -> Picture
        drawChunk Nenhum posX posY textures = Translate posX posY (textures !! 0)
        drawChunk Tronco posX posY textures = Translate posX posY (textures !! 1)
        -- drawChunk Nenhum posX posY textures = Translate posX posY (textures !! 2)
        drawChunk Arvore posX posY textures = Translate posX posY (textures !! 3)
        -- drawChunk Nenhum posX posY textures = Translate posX posY (textures !! 4)
        drawChunk Carro posX posY textures = Translate posX posY (textures !! 5)


reactEvent :: Event -> State -> IO State
reactEvent _ = return

reactTime :: Float -> State -> IO State
reactTime _ = return

fr :: Int
fr = 50

dm :: Display
dm = FullScreen  

play :: IO ()
play = do water <- loadBMP "src/images/water.bmp"
          trunk <- loadBMP "src/images/trunk.bmp"
          grass <- loadBMP "src/images/grass.bmp"
          tree <- loadBMP "src/images/tree.bmp"
          road <- loadBMP "src/images/road.bmp"
          car <- loadBMP "src/images/car.bmp"

          let mapImages = [water, trunk, grass, tree, road, car]

          playIO dm
            black
            fr
            (initialState mapImages)
            drawNewState
            reactEvent
            reactTime