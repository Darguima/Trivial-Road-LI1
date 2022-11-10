module Tarefa2_2022li1g031_Spec where

import LI12223
import Tarefa2_2022li1g031
import Test.HUnit

testsT2 :: Test
proximosTerrenosValidosTestes = TestList [
  "Teste Terrenos Válidos 01" ~: [Estrada 0, Rio 0 , Relva] ~=?   proximosTerrenosValidos  (Mapa 3 [(Estrada 2 , [Nenhum, Carro, Nenhum]), (Estrada 1, [Carro, Nenhum, Nenhum]), (Rio 1, [Tronco, Nenhum, Nenhum]), (Rio (-5), [Nenhum, Nenhum, Tronco]), (Rio 1, [Nenhum, Nenhum, Tronco]), (Rio 5, [Nenhum, Tronco, Nenhum])]),
  "Teste Terrenos Válidos 02" ~: [Estrada 0,  Relva] ~=? proximosTerrenosValidos  (Mapa 4 [(Rio 5, [Nenhum, Tronco, Nenhum]), (Rio 2 , [Nenhum,Tronco, Nenhum, Nenhum]), (Rio  1, [Tronco, Nenhum, Nenhum]),  (Rio 1, [Nenhum, Nenhum, Tronco])]),
  "Teste Terrenos Válidos 03" ~: [Estrada 0, Rio 0 , Relva] ~=?  proximosTerrenosValidos  (Mapa 4 [(Rio 5, [Nenhum, Tronco, Nenhum]), (Relva , [Nenhum, Arvore, Nenhum]), (Relva , [Nenhum, Arvore, Nenhum]), (Relva , [Nenhum, Arvore, Nenhum]), (Relva, [Nenhum, Arvore, Nenhum]), (Relva, [Nenhum, Arvore, Nenhum])]),
  "Teste Terrenos Válidos 04" ~: [Estrada 0, Rio 0] ~=? proximosTerrenosValidos  (Mapa 4 [(Relva, [Nenhum, Arvore, Nenhum]), (Relva, [Nenhum, Arvore, Nenhum, Nenhum]), (Relva, [Arvore, Nenhum, Nenhum]),  (Relva, [Nenhum, Nenhum, Arvore]),(Relva, [Nenhum, Nenhum, Tronco])]),
  "Teste Terrenos Válidos 05" ~: [Estrada 0, Rio 0 , Relva] ~=?  proximosTerrenosValidos  (Mapa 4 [(Rio 5, [Nenhum, Tronco, Nenhum]), (Estrada 2 , [Nenhum, Carro, Nenhum]), (Estrada 2 , [Nenhum, Carro, Nenhum]), (Estrada 2 , [Nenhum, Carro, Nenhum]), (Estrada 2 , [Nenhum, Carro, Nenhum]), (Estrada 2 , [Nenhum, Carro, Nenhum])]),
  "Teste Terrenos Válidos 06" ~: [Rio 0, Relva] ~=? proximosTerrenosValidos  (Mapa 4 [(Estrada 5, [Nenhum, Carro, Nenhum]), (Estrada 5, [Nenhum, Carro, Carro, Nenhum]), (Estrada 5, [Carro, Nenhum, Nenhum]),  (Estrada 5, [Nenhum, Nenhum, Carro]),(Estrada 5, [Nenhum, Nenhum, Carro])])
  ] 

proximosObstaculosValidosTestes = TestList [
  "Teste Obstáculos Válidos Rio 01" ~: [Nenhum, Tronco] ~=?   proximosObstaculosValidos 4 (Rio 2, [Nenhum,Nenhum,Tronco ]),
  "Teste Obstáculos Válidos Rio 02" ~: [] ~=?   proximosObstaculosValidos 3 (Rio 2, [Nenhum,Nenhum,Tronco ]),
  "Teste Obstáculos Válidos Rio 03" ~: [Nenhum] ~=?   proximosObstaculosValidos 4 (Rio 2, [Tronco, Tronco, Tronco]),
  "Teste Obstáculos Válidos Rio 04" ~: [Nenhum, Tronco] ~=?   proximosObstaculosValidos 7 (Rio 2, [Nenhum, Tronco, Tronco, Tronco, Tronco]),
  "Teste Obstáculos Válidos Rio 05" ~: [Nenhum] ~=?   proximosObstaculosValidos 7 (Rio 2, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco]),
  "Teste Obstáculos Válidos Rio 05" ~: [Tronco] ~=?   proximosObstaculosValidos 7 (Rio 2, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum]),

  "Teste Obstáculos Válidos Estrada 01" ~: [Nenhum, Carro] ~=?   proximosObstaculosValidos 4 (Estrada 2, [Nenhum,Nenhum,Carro ]),
  "Teste Obstáculos Válidos Estrada 02" ~: [] ~=?   proximosObstaculosValidos 3 (Estrada 2, [Nenhum,Nenhum,Carro ]),
  "Teste Obstáculos Válidos Estrada 03" ~: [Nenhum] ~=?   proximosObstaculosValidos 4 (Estrada 2, [Carro, Carro, Carro]),
  "Teste Obstáculos Válidos Estrada 04" ~: [Nenhum, Carro] ~=?   proximosObstaculosValidos 7 (Estrada 2, [Nenhum, Carro, Carro, Nenhum, Carro]),
  "Teste Obstáculos Válidos Estrada 05" ~: [Nenhum] ~=?   proximosObstaculosValidos 7 (Estrada 2, [Nenhum, Carro, Carro, Carro]),

  "Teste Obstáculos Válidos Relva 01" ~: [Nenhum, Arvore] ~=?   proximosObstaculosValidos 4 (Relva, [Nenhum,Nenhum,Arvore ]),
  "Teste Obstáculos Válidos Relva 02" ~: [] ~=?   proximosObstaculosValidos 3 (Relva, [Nenhum,Nenhum,Arvore ]),
  "Teste Obstáculos Válidos Relva 03" ~: [Nenhum] ~=?   proximosObstaculosValidos 4 (Relva, [Arvore, Arvore, Arvore]),
  "Teste Obstáculos Válidos Relva 04" ~: [Nenhum, Arvore] ~=?   proximosObstaculosValidos 7 (Relva, [Nenhum, Arvore, Arvore, Arvore, Arvore])
  ]
  
estendeMapaTestes = TestList [
  "Teste Estende Mapa 01" ~: Mapa 5 [(Relva,[Arvore,Arvore,Arvore,Arvore,Nenhum])] ~=? estendeMapa (Mapa 5 []) 5,
  "Teste Estende Mapa 02" ~: Mapa 5 [(Estrada 1,[Carro,Nenhum,Carro,Carro,Nenhum]),(Rio 2,[Tronco,Tronco,Tronco,Tronco,Nenhum])] ~=? estendeMapa (Mapa 5 [(Rio 2, [Tronco,Tronco,Tronco,Tronco,Nenhum])]) 3,
  "Teste Estende Mapa 03" ~: Mapa 5 [(Rio 1,[Nenhum,Nenhum,Nenhum,Nenhum,Tronco]),(Rio (-2),[Tronco,Tronco,Tronco,Tronco,Nenhum])] ~=? estendeMapa (Mapa 5 [(Rio (-2), [Tronco,Tronco,Tronco,Tronco,Nenhum])]) 4,
  "Teste Estende Mapa 04" ~: Mapa 5 [(Rio (-4),[Nenhum,Nenhum,Nenhum,Nenhum,Tronco]),(Rio 1,[Nenhum,Tronco,Tronco,Tronco,Nenhum]),(Rio (-2),[Tronco,Tronco,Tronco,Tronco,Nenhum])] ~=? estendeMapa (Mapa 5 [(Rio 1,[Nenhum,Tronco,Tronco,Tronco,Nenhum]),(Rio (-2),[Tronco,Tronco,Tronco,Tronco,Nenhum])]) 4,

  "Teste Estende Mapa 05" ~: Mapa 5 [(Rio 2,[Nenhum,Nenhum,Nenhum,Nenhum,Tronco]),(Estrada (-1),[Tronco,Tronco,Tronco,Tronco,Nenhum])] ~=? estendeMapa (Mapa 5 [(Estrada (-1), [Tronco,Tronco,Tronco,Tronco,Nenhum])]) 4
  ]

testsT2 = TestList [
  proximosTerrenosValidosTestes,
  proximosObstaculosValidosTestes,
  estendeMapaTestes
  ]