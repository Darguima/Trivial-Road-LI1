{- |
Module      : Tarefa5_2022li1g031
Description : Deslizar o mapa
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2022/23.
-}
module Tarefa5_2022li1g031 where
import LI12223
import Tarefa2_2022li1g031 (estendeMapa)
import System.Random

{-|
O objetivo desta tarefa é implementar a função:
deslizaJogo :: Jogo -> Jogo 
que, intuitivamente, faz com que a última linha do mapa desapareça, ao
mesmo tempo que uma nova linha no topo do mapa seja criada. Mais
concretamente:

1. A última linha do mapa deve ser removida, enquanto que, por outro lado, uma nova linha deve ser adicionada ao topo do mapa. Em particular, o mapa resultante mantém o tamanho (i.e. comprimento) do mapa original.
2. A coordenada y do jogador deve ser aumentada (em 1 unidade), reflectindo assim o efeito de que o jogador “ficou para trás”.
-}

deslizaJogo :: Int -> Jogo -> Jogo
deslizaJogo randomNumber currentGame@(Jogo (Jogador (posX, posY)) mapa) = 
 let (Mapa l linhasDoMapa) = estendeMapa mapa randomNumber
 in Jogo (Jogador (posX, posY + 1)) (Mapa l (init linhasDoMapa))