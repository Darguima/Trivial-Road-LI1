module Gloss_Functions.GlossData where
import LI12223 ( Jogo(..), Jogador(Jogador), Coordenadas, Mapa(..), Obstaculo(Arvore, Tronco, Carro, Nenhum), Terreno(Relva, Rio, Estrada) )
import Graphics.Gloss ( Picture, Display(FullScreen) )
import Data.Monoid (Last(getLast))

data OpcoesMenu = OPCAO_JOGAR
            | OPCAO_SOBRE
            | OPCAO_SAIR
            | OPCAO_SIM
            | OPCAO_NAO
            | OPCAO_CONTINUAR
            | OPCAO_MENU

data PaginaAtual = Menu OpcoesMenu
          | JOGO
          | DERROTA
          | SOBRE

-- type Estado = (Jogo, Texturas, tamanhoJanela, PaginaAtual, PontuaçãoAtual, Pontuações, LarguraDoMapa, frameAtual, yMin)
type Estado = (Jogo, Texturas, (Int, Int), PaginaAtual, Int , [Int], Int, Int,Int)
type Texturas = [Picture]

tamanhoChunk :: Float
tamanhoChunk = 135

getLastX :: Int -> Float 
getLastX larguraMapa = (fromIntegral larguraMapa * tamanhoChunk)/2  - (tamanhoChunk/2)

getInitialX :: Int -> Float
getInitialX larguraMapa = - (fromIntegral larguraMapa * tamanhoChunk) / 2 +  (tamanhoChunk / 2)

getInitialY :: Int -> Float
getInitialY alturaJanela = -(fromIntegral alturaJanela / 2) + (tamanhoChunk / 2)

larguraMapa = 8
mapaInicial = Mapa larguraMapa [(Relva , [Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum]), (Estrada (-2) , [Nenhum,Carro,Nenhum,Nenhum,Carro,Carro,Nenhum,Nenhum]), (Rio (3) , [Nenhum,Tronco,Nenhum,Nenhum,Tronco,Tronco,Nenhum,Nenhum]), (Relva , [Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum]), (Relva , [Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum, Nenhum]), (Relva , [Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum]), (Relva , [Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum]), (Relva , [Arvore,Arvore,Nenhum,Nenhum,Nenhum,Nenhum, Nenhum, Arvore])] 
--Nenhum Nenhum Carro Carro Carro 
estadoInicial :: Texturas -> (Int, Int) -> Estado
estadoInicial texturas tamanhoJanela = (Jogo (Jogador (4, 5)) mapaInicial, texturas, tamanhoJanela, Menu OPCAO_JOGAR , 0 , [] , 8, 1,7)
          
                

fr :: Int
fr = 60

dm :: Display
dm = FullScreen