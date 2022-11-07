module Tarefa1_2022li1g031_Spec where

import LI12223  
import Tarefa1_2022li1g031
import Test.HUnit

testsT1 :: Test

restricaoObstaculosTests = TestList [
  "Teste Obstaculos Rio 01" ~: True ~=? restricaoObstaculos[(Rio 5, [Nenhum, Nenhum, Nenhum]), (Rio 3 , [Nenhum,Tronco,Nenhum]), (Rio 2 , [Tronco,Tronco,Tronco])],
  "Teste Obstaculos Rio 02" ~: True ~=? restricaoObstaculos[(Rio (-6), [Nenhum, Tronco, Nenhum])],
  "Teste Obstaculos Rio 03" ~: False ~=? restricaoObstaculos[(Rio 3, [Carro, Tronco, Nenhum]), (Rio 3 , [Nenhum,Nenhum,Tronco]), (Rio 1, [Carro, Nenhum, Nenhum])],
  "Teste Obstaculos Rio 04" ~: False ~=? restricaoObstaculos[(Rio (-1), [Carro])],

  "Teste Obstaculos Estrada 01" ~: True ~=? restricaoObstaculos[(Estrada 5, [Nenhum, Nenhum, Nenhum]), (Estrada 2 , [Carro,Carro,Nenhum])],
  "Teste Obstaculos Estrada 02" ~: True ~=? restricaoObstaculos[(Estrada (-6), [Nenhum, Carro, Nenhum])],
  "Teste Obstaculos Estrada 03" ~: False ~=? restricaoObstaculos[(Estrada 3, [Carro, Arvore, Nenhum]), (Estrada 1, [Arvore, Nenhum, Nenhum])],
  "Teste Obstaculos Estrada 04" ~: False ~=? restricaoObstaculos[(Estrada (-1), [Tronco])],

  "Teste Obstaculos Relva 01" ~: True ~=? restricaoObstaculos[(Relva, [Nenhum, Nenhum, Nenhum]), (Relva, [Nenhum,Arvore,Arvore])],
  "Teste Obstaculos Relva 02" ~: True ~=? restricaoObstaculos[(Relva, [Nenhum, Arvore, Nenhum])],
  "Teste Obstaculos Relva 03" ~: False ~=? restricaoObstaculos[(Relva, [Carro, Nenhum, Arvore]), (Relva, [Tronco, Nenhum, Nenhum])],
  "Teste Obstaculos Relva 04" ~: False ~=? restricaoObstaculos[(Relva, [Carro])]
  ]

restricaoRiosContiguosTestes = TestList [
  "Teste Rios Contiguos 01" ~: True ~=? restricaoRiosContiguos[],
  "Teste Rios Contiguos 02" ~: True ~=? restricaoRiosContiguos[(Rio 5, [Nenhum])],
  "Teste Rios Contiguos 03" ~: True ~=? restricaoRiosContiguos[(Rio 5, [Nenhum]), (Rio (-5), [Nenhum])],
  "Teste Rios Contiguos 04" ~: False ~=? restricaoRiosContiguos[(Rio 5, [Nenhum]), (Rio 5, [Nenhum])],
  "Teste Rios Contiguos 05" ~: True ~=? restricaoRiosContiguos[(Rio 5, [Nenhum]), (Rio (-5), [Nenhum]), (Rio 5, [Nenhum])],
  "Teste Rios Contiguos 06" ~: False ~=? restricaoRiosContiguos[(Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum])],
  "Teste Rios Contiguos 07" ~: True ~=? restricaoRiosContiguos[(Rio 5, [Nenhum]), (Rio (-5), [Nenhum]), (Rio 5, [Nenhum]), (Rio (-5), [Nenhum])],
  "Teste Rios Contiguos 08" ~: True ~=? restricaoRiosContiguos[(Rio 5, [Nenhum]), (Estrada (-5), [Nenhum]), (Rio 5, [Nenhum]), (Rio (-5), [Nenhum])],
  "Teste Rios Contiguos 09" ~: False ~=? restricaoRiosContiguos[(Rio 5, [Nenhum]), (Estrada (-5), [Nenhum]), (Rio 5, [Nenhum]), (Rio (5), [Nenhum])],
  "Teste Rios Contiguos 10" ~: True ~=? restricaoRiosContiguos[(Estrada (-5), [Nenhum]), (Rio 5, [Nenhum]), (Relva, [Nenhum])]
  ]

restricaoTamanhoObstaculosTestes = TestList [
  "Teste Troncos no Rio 01" ~: True ~=? restricaoTamanhoObstaculos [(Rio 5, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum])],
  "Teste Troncos no Rio 02" ~: True ~=? restricaoTamanhoObstaculos [(Rio 5, [Nenhum, Tronco, Tronco, Tronco, Nenhum, Nenhum, Nenhum, Nenhum])],
  "Teste Troncos no Rio 03" ~: True ~=? restricaoTamanhoObstaculos [(Rio 5, [Nenhum, Tronco, Tronco, Nenhum, Nenhum, Tronco, Tronco, Tronco])],
  "Teste Troncos no Rio 04" ~: True ~=? restricaoTamanhoObstaculos [(Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum])],
  "Teste Troncos no Rio 05" ~: True ~=? restricaoTamanhoObstaculos [(Rio 5, [Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum])],
  "Teste Troncos no Rio 06" ~: True ~=? restricaoTamanhoObstaculos [(Rio 5, [Nenhum, Tronco, Tronco, Tronco, Nenhum]), (Estrada 5, [Nenhum, Carro, Carro, Nenhum, Nenhum]), (Rio 5, [Nenhum, Tronco, Tronco, Tronco, Nenhum, Nenhum])],
  "Teste Troncos no Rio 07" ~: False ~=? restricaoTamanhoObstaculos [(Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum])],
  "Teste Troncos no Rio 08" ~: False ~=? restricaoTamanhoObstaculos [(Rio 5, [Nenhum, Tronco, Tronco, Nenhum, Tronco, Nenhum]), (Estrada 5, [Nenhum, Carro, Carro, Nenhum, Nenhum]), (Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum])],

  "Teste Carros na Estada 01" ~: True ~=? restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum])],
  "Teste Carros na Estada 02" ~: True ~=? restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Carro, Carro, Carro, Nenhum, Nenhum, Nenhum, Nenhum])],
  "Teste Carros na Estada 03" ~: True ~=? restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Carro, Carro, Nenhum, Nenhum, Carro, Carro, Carro])],
  "Teste Carros na Estada 04" ~: True ~=? restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Carro, Carro, Nenhum, Nenhum])],
  "Teste Carros na Estada 05" ~: True ~=? restricaoTamanhoObstaculos [(Estrada 5, [Carro, Carro, Carro, Nenhum, Nenhum, Carro, Carro, Nenhum])],
  "Teste Carros na Estada 06" ~: True ~=? restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Carro, Carro, Carro, Nenhum]), (Rio 5, [Nenhum, Tronco, Tronco, Nenhum, Nenhum]), (Estrada 5, [Nenhum, Carro, Carro, Carro, Nenhum, Nenhum])],
  "Teste Carros na Estada 07" ~: False ~=? restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Carro, Carro, Carro, Carro, Carro, Carro, Nenhum])],
  "Teste Carros na Estada 08" ~: False ~=? restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Carro, Carro, Nenhum, Carro, Nenhum]), (Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum]), (Estrada 5, [Nenhum, Carro, Carro, Carro, Carro, Carro, Carro, Nenhum, Nenhum])]
  ]


restricaoQuantidadeObstaculosTestes = TestList [
  "Teste Quantidade Obstaculos 01" ~: True ~=? restricaoquantidadeObstaculos [(Rio 5, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum])],
  "Teste Quantidade Obstaculos 02" ~: True ~=? restricaoquantidadeObstaculos [(Relva, [Nenhum, Arvore, Arvore, Nenhum, Nenhum, Arvore, Arvore, Arvore]), (Estrada 5, [Nenhum, Carro, Carro, Carro, Nenhum, Nenhum, Nenhum, Nenhum])],
  "Teste Quantidade Obstaculos 03" ~: False ~=? restricaoquantidadeObstaculos [(Rio 5, [Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco])],
  "Teste Quantidade Obstaculos 04" ~: False ~=? restricaoquantidadeObstaculos [(Rio 5, [Tronco, Nenhum, Nenhum, Nenhum, Tronco, Tronco]), (Estrada  5, [Carro, Carro, Carro, Carro, Carro]), (Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum])]
  ]

restricaoTamanhoLinhaTestes = TestList [
  "Teste Tamanho Linha 01" ~: True ~=? restricaoTamanhoLinha (Mapa 8 [(Rio 5, [Tronco, Nenhum, Tronco, Tronco, Nenhum, Nenhum, Tronco, Nenhum])]),
  "Teste Tamanho Linha 04" ~: True ~=? restricaoTamanhoLinha (Mapa 4 [(Rio 5, [Tronco, Tronco, Tronco, Tronco]), (Relva, [Nenhum, Arvore, Nenhum, Nenhum]), (Estrada 5, [Nenhum, Carro, Nenhum, Nenhum])]),
  "Teste Tamanho Linha 02" ~: False ~=? restricaoTamanhoLinha (Mapa 10 [(Relva, [Nenhum, Arvore, Arvore, Nenhum, Nenhum, Arvore, Arvore, Arvore])]),
  "Teste Tamanho Linha 03" ~: False ~=? restricaoTamanhoLinha (Mapa 5 [(Relva, [Nenhum, Arvore, Arvore, Nenhum, Nenhum]), (Estrada 5, [Nenhum, Carro, Carro, Carro, Nenhum, Nenhum, Nenhum, Nenhum]), (Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum])])
  ]

restricaoQuantidadeTerrenosTestes = TestList [
  "Teste Quantidade Terrenos 01" ~: True ~=? restricaoQuantidadeTerrenos  [(Rio 5, [Tronco]), (Rio 5, [Tronco])],
  "Teste Quantidade Terrenos 04" ~: True ~=? restricaoQuantidadeTerrenos  [(Rio 5, [Tronco]), (Relva, [Nenhum]), (Estrada 5, [Nenhum]), (Rio 5, [Tronco]), (Relva, [Nenhum])],
  "Teste Quantidade Terrenos 03" ~: False ~=? restricaoQuantidadeTerrenos  [(Relva, [Nenhum]), (Estrada 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Relva, [Nenhum])],
  "Teste Quantidade Terrenos 02" ~: False ~=? restricaoQuantidadeTerrenos [(Relva, [Nenhum]), (Relva, [Nenhum]), (Relva, [Nenhum]), (Relva, [Nenhum]), (Relva, [Nenhum]), (Relva, [Nenhum])],
  "Teste Quantidade Terrenos 02" ~: False ~=? restricaoQuantidadeTerrenos [(Estrada 5, [Nenhum]), (Estrada 5, [Nenhum]), (Estrada 5, [Nenhum]), (Estrada 5, [Nenhum]), (Estrada 5, [Nenhum]), (Estrada 5, [Nenhum])]
  ]

testsT1 = TestList [
  restricaoObstaculosTests,
  restricaoRiosContiguosTestes,
  restricaoTamanhoObstaculosTestes,
  restricaoQuantidadeObstaculosTestes,
  restricaoTamanhoLinhaTestes,
  restricaoQuantidadeTerrenosTestes
  ] 