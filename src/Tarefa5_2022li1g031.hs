{- |
Module      : Tarefa5_2022li1g031
Description : Deslizar o mapa
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2022/23.
-}
module Tarefa5_2022li1g031 where
import LI12223 ( Mapa(Mapa), Jogador(Jogador), Jogo(..) )
import Tarefa2_2022li1g031 (estendeMapa)

{-|

A função deslizaJogo que faz com que a última linha do mapa desapareça, ao
mesmo tempo que uma nova linha no topo do mapa seja criada. Mais
concretamente:

1. A última linha do mapa deve é, enquanto que, por outro lado, uma nova linha é adicionada ao topo do mapa. Em particular, o mapa resultante mantém o tamanho (i.e. comprimento) do mapa original.
2. A coordenada y do jogador é aumentada (em 1 unidade), reflectindo assim o efeito de que o jogador “ficou para trás”.

== Exemplos de utilização:
>>> deslizaJogo 5 (Jogo (Jogador (3, 4)) (Mapa 4 [ (Relva , [Nenhum, Nenhum, Arvore, Arvore]), (Estrada 5 , [Nenhum, Carro, Carro, Nenhum]), (Rio 3 , [Nenhum, Tronco, Tronco, Tronco]) ]))
Jogo (Jogador (3,5)) (Mapa 4 [(Relva,[Nenhum,Arvore,Nenhum,Arvore]),(Relva,[Nenhum,Nenhum,Arvore,Arvore]),(Estrada 5,[Nenhum,Carro,Carro,Nenhum])])
-}

deslizaJogo :: Int -> Jogo -> Jogo
deslizaJogo randomNumber currentGame@(Jogo (Jogador (posX, posY)) mapa) = 
 let (Mapa l linhasDoMapa) = estendeMapa mapa randomNumber
 in Jogo (Jogador (posX, posY + 1)) (Mapa l (init linhasDoMapa))