module Tarefa5_2022li1g031_Spec where

import LI12223
import Tarefa5_2022li1g031
import Test.HUnit

testsT5 :: Test

deslizaJogoTestes = TestList [
  "Teste Desliza Jogo 01" ~: Jogo (Jogador (3,5)) (Mapa 4 [(Relva,[Nenhum,Arvore,Nenhum,Arvore]),(Relva,[Nenhum,Nenhum,Arvore,Arvore]),(Estrada 5,[Nenhum,Carro,Carro,Nenhum])]) ~=? deslizaJogo 5 (Jogo (Jogador (3, 4)) (Mapa 4 [ (Relva , [Nenhum, Nenhum, Arvore, Arvore]), (Estrada 5 , [Nenhum, Carro, Carro, Nenhum]), (Rio 3 , [Nenhum, Tronco, Tronco, Tronco]) ]))
  ] 


testsT5 = TestList [deslizaJogoTestes]
