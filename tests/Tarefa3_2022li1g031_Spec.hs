module Tarefa3_2022li1g031_Spec where

import LI12223
import Tarefa3_2022li1g031
import Test.HUnit

testsT3 :: Test
animaJogoTestes = TestList [
  "Teste animaJogo 01" ~: Jogo (Jogador (0,1)) (Mapa 5 [(Relva,[Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Estrada 2,[Nenhum,Nenhum, Carro, Carro ,Carro])]) ~=? animaJogo (Jogo (Jogador (0,0))  (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Arvore,Arvore]), (Estrada 2, [Carro, Carro ,Carro,Nenhum,Nenhum])])) (Move Baixo),
  "Teste animaJogo 02" ~: Jogo (Jogador (2,0)) (Mapa 5 [(Relva,[Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Estrada 2,[Nenhum,Carro,Nenhum,Carro,Carro])]) ~=? animaJogo (Jogo (Jogador (2,0))  (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Arvore,Arvore]), (Estrada 2, [Nenhum,Carro,Carro,Nenhum,Carro])])) (Move Direita),
  "Teste animaJogo 03" ~: Jogo (Jogador (3,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio 2, [Nenhum,Nenhum,Nenhum,Tronco,Tronco])]) ~=? animaJogo (Jogo (Jogador (1,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio 2, [Nenhum,Tronco,Tronco,Nenhum,Nenhum])])) (Move Cima),
  "Teste animaJogo 04" ~: Jogo (Jogador (2,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio (-1), [Tronco,Nenhum,Tronco,Nenhum,Nenhum])]) ~=? animaJogo (Jogo (Jogador (3,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio (-1), [Nenhum,Tronco,Nenhum,Tronco,Nenhum])])) (Move Esquerda),
  "Teste animaJogo 05" ~: Jogo (Jogador (3,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio 2, [Tronco, Nenhum, Nenhum,Tronco,Nenhum]), (Estrada 3, [Carro,Nenhum,Nenhum,Carro,Carro])]) ~=? animaJogo (Jogo (Jogador (1,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio 2, [Nenhum,Tronco,Nenhum,Tronco,Nenhum]), (Estrada 3 , [Carro,Carro,Carro,Nenhum,Nenhum])])) Parado,
  "Teste animaJogo 06" ~: Jogo (Jogador (5,1)) (Mapa 5 [(Relva,[Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Rio 3,[Tronco,Tronco,Tronco,Nenhum,Tronco])])~=? animaJogo   (Jogo (Jogador (1,1))  (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Arvore,Arvore]), (Rio 3, [Nenhum,Tronco,Tronco,Tronco,Tronco])])) (Move Direita),

  "Teste animaJogo 07" ~: Jogo (Jogador (0,1)) (Mapa 5 [(Relva,[Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Estrada 2,[Carro,Nenhum,Carro,Carro,Nenhum])])~=? animaJogo   (Jogo (Jogador (0,0))  (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Arvore,Arvore]), (Estrada 2, [Nenhum,Carro,Carro,Nenhum,Carro])])) (Move Baixo),
  "Teste animaJogo 08" ~: Jogo (Jogador (3,0)) (Mapa 5 [(Relva,[Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Estrada 2,[Nenhum,Carro,Nenhum,Carro,Carro])]) ~=? animaJogo (Jogo (Jogador (3,0))  (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Arvore,Arvore]), (Estrada 2, [Nenhum,Carro,Carro,Nenhum,Carro])])) (Move Direita),
  "Teste animaJogo 09" ~: Jogo (Jogador (3,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio 2, [Tronco, Nenhum, Nenhum,Tronco,Nenhum]), (Estrada 3, [Carro,Nenhum,Nenhum,Carro,Carro])]) ~=? animaJogo (Jogo (Jogador (1,1))  (Mapa 5 [(Relva , [Nenhum,Arvore,Nenhum,Arvore,Arvore]), (Rio 2, [Nenhum,Tronco,Nenhum,Tronco,Nenhum]), (Estrada 3 , [Carro,Carro,Carro,Nenhum,Nenhum])])) Parado
                           ]


testsT3 = TestList [
     animaJogoTestes
                   ]
