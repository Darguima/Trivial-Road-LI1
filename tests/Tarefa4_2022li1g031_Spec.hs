module Tarefa4_2022li1g031_Spec where

import LI12223
import Tarefa4_2022li1g031
import Test.HUnit

testsT4 :: Test

jogoTerminouTestes = TestList [
  "Teste Jogo Terminou 01" ~: False ~=? jogoTerminou (Jogo (Jogador (0,0))  (Mapa 4 [ (Rio 5 , [Tronco, Tronco, Tronco, Nenhum]) ])),
  "Teste Jogo Terminou 02" ~: True ~=? jogoTerminou (Jogo (Jogador (2,0))  (Mapa 4 [ (Rio 5 , [Tronco, Tronco, Nenhum, Nenhum]) ])),

  "Teste Jogo Terminou 03" ~: False ~=? jogoTerminou (Jogo (Jogador (0,0))  (Mapa 4 [ (Estrada 5 , [Nenhum, Nenhum, Carro, Carro]) ])),
  "Teste Jogo Terminou 04" ~: True ~=? jogoTerminou (Jogo (Jogador (0,0))  (Mapa 4 [ (Estrada 5 , [Carro, Carro, Nenhum, Nenhum]) ])),

  "Teste Jogo Terminou 05" ~: False ~=? jogoTerminou (Jogo (Jogador (2,0))  (Mapa 4 [ (Relva , [Arvore, Arvore, Nenhum, Nenhum]) ])),

  "Teste Jogo Terminou 06" ~: False ~=? jogoTerminou (Jogo (Jogador (2,0))  (Mapa 4 [ (Estrada 5 , [Carro, Carro, Nenhum, Nenhum]) ])),
  "Teste Jogo Terminou 07" ~: True ~=? jogoTerminou (Jogo (Jogador (4,0))  (Mapa 4 [ (Relva , [Nenhum, Nenhum, Arvore, Arvore]) ])),

  "Teste Jogo Terminou 08" ~: False ~=? jogoTerminou (Jogo (Jogador (0, 1))  (Mapa 4 [ (Relva , [Nenhum, Nenhum, Arvore, Arvore]), (Estrada 5 , [Nenhum, Carro, Carro, Nenhum]), (Rio 3 , [Nenhum, Tronco, Tronco, Tronco]) ])),
  "Teste Jogo Terminou 09" ~: True ~=? jogoTerminou (Jogo (Jogador (0 ,2))  (Mapa 4 [ (Relva , [Nenhum, Nenhum, Arvore, Arvore]), (Estrada 5 , [Nenhum, Carro, Carro, Nenhum]), (Rio 3 , [Nenhum, Tronco, Tronco, Tronco]) ])),
  "Teste Jogo Terminou 10" ~: True ~=? jogoTerminou (Jogo (Jogador (4, 2))  (Mapa 4 [ (Relva , [Nenhum, Nenhum, Arvore, Arvore]), (Estrada 5 , [Nenhum, Carro, Carro, Nenhum]), (Rio 3 , [Nenhum, Tronco, Tronco, Tronco]) ]))
  ] 


testsT4 = TestList [jogoTerminouTestes]
