{- |
Module      : Tarefa1_2022li1g031
Description : Validação de um mapa
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2022/23.
-}
module Tarefa1_2022li1g031 where

import LI12223
import Data.List (group)

mapaValido :: Mapa -> Bool

mapaValido (Mapa _ []) = True
mapaValido (Mapa largura linhaMapa) = restricaoObstaculos linhaMapa

-- Obstáculos têm os seus sítios corretos para aparecer 
restricaoObstaculos :: [(Terreno, [Obstaculo])] -> Bool

restricaoObstaculos [] = True
restricaoObstaculos ((Rio _, obstaculos) : t)  = 
  not (Carro `elem` obstaculos || Arvore `elem` obstaculos) && restricaoObstaculos t
restricaoObstaculos ((Estrada _, obstaculos) : t) =
  not (Tronco `elem` obstaculos || Arvore `elem` obstaculos) && restricaoObstaculos t
restricaoObstaculos ((Relva, obstaculos) : t) = 
  not (Carro `elem` obstaculos || Tronco `elem` obstaculos) && restricaoObstaculos t

-- Rios contiguos tem direcoes opostas 
restricaoRiosContiguos :: [LinhaDoMapa] -> Bool
 
restricaoRiosContiguos [] = True
restricaoRiosContiguos ((Rio v1, _) : (Rio v2, obstaculos) : t)
  | v1 * v2 < 0 = restricaoRiosContiguos ((Rio v2, obstaculos) : t)
  | otherwise = False

restricaoRiosContiguos (h : t) = restricaoRiosContiguos t

--Obstáculos têm no maximo n unidades de comprimento
-- Troncos (no Rio) tem no maximo 5 unidades de comprimento 
--Carros (na Estrada) têm no maximo 3 unidades de comprimento
restricaoTamanhoObstaculos :: [LinhaDoMapa] -> Bool 

restricaoTamanhoObstaculos [] = True 
restricaoTamanhoObstaculos ((Rio _ , obstaculos) : t) = checkarLinha 5 obstaculos && restricaoTamanhoObstaculos t
restricaoTamanhoObstaculos ((Estrada _ , obstaculos) : t) = checkarLinha 3 obstaculos && restricaoTamanhoObstaculos  t
restricaoTamanhoObstaculos ((Relva, obstaculos) : t) = restricaoTamanhoObstaculos t
      
checkarLinha :: Int -> [Obstaculo] -> Bool
       
checkarLinha tamanhoMaximo obstaculos = not (any (\ grupo -> length grupo > tamanhoMaximo && head grupo /= Nenhum) (group obstaculos)) 
