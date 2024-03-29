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

{- |Esta função verifica se um dado mapa não viola nenhuma das seguintes restrições:

1. Não existem obstáculos em terrenos impróprios, e.g. troncos em estradas ou relvas, árvores em rios ou estradas, etc.
2. Rios contı́guos têm direcções opostas.
3. Troncos têm, no máximo, 5 unidades de comprimento.
4. Carros têm, no máximo, 3 unidades de comprimento.
5. Em qualquer linha existe, no mı́nimo, um “obstáculo” Nenhum. Ou seja, uma linha não pode ser composta exclusivamente por obstáculos, precisando de haver pelo menos um espaço livre.
6. O comprimento da lista de obstáculos de cada linha corresponde exactamente à largura do mapa.
7. Contiguamente, não devem existir mais do que 4 rios, nem 5 estradas ou relvas.

== Exemplos de utilização:
>>> mapaValido (Mapa 3 [(Rio 5, [Nenhum, Tronco, Nenhum]), (Estrada 2 , [Nenhum,Carro,Nenhum]), (Estrada 1, [Carro,Nenhum,Nenhum]), (Rio 1, [Tronco,Nenhum,Nenhum]), (Rio (-5), [Nenhum, Nenhum, Tronco]), (Rio 1, [Nenhum, Nenhum, Tronco])])
True

>>> mapaValido (Mapa 4 [(Rio 5, [Nenhum, Tronco, Nenhum]), (Estrada 2 , [Nenhum,Carro,Nenhum, Nenhum]), (Estrada 1, [Carro,Nenhum,Nenhum]), (Rio 1, [Tronco,Nenhum,Nenhum]), (Rio (-5), [Nenhum, Nenhum, Tronco]), (Rio 1, [Nenhum, Nenhum, Tronco])])
False

-}

mapaValido :: Mapa -> Bool

mapaValido (Mapa largura linhasMapa) = restricaoObstaculos linhasMapa && restricaoRiosContiguos linhasMapa && restricaoTamanhoObstaculos linhasMapa && restricaoquantidadeObstaculos linhasMapa && restricaoTamanhoLinha (Mapa largura linhasMapa) && restricaoQuantidadeTerrenos linhasMapa

{- |Não existem obstáculos em terrenos impróprios, e.g. troncos em es-
tradas ou relvas, árvores em rios ou estradas, etc.

== Exemplos de utilização:
>>> restricaoObstaculos[(Rio 5, [Nenhum, Nenhum, Nenhum]), (Rio 3 , [Nenhum,Tronco,Nenhum]), (Rio 2 , [Tronco,Tronco,Tronco])]
True

>>> restricaoObstaculos[(Rio 3, [Carro, Tronco, Nenhum]), (Rio 3 , [Nenhum,Nenhum,Tronco]), (Rio 1, [Carro, Nenhum, Nenhum])]
False
-}

restricaoObstaculos :: [(Terreno, [Obstaculo])] -> Bool

restricaoObstaculos [] = True
restricaoObstaculos ((Rio _, obstaculos) : t)  = 
  not (Carro `elem` obstaculos || Arvore `elem` obstaculos) && restricaoObstaculos t
restricaoObstaculos ((Estrada _, obstaculos) : t) =
  not (Tronco `elem` obstaculos || Arvore `elem` obstaculos) && restricaoObstaculos t
restricaoObstaculos ((Relva, obstaculos) : t) = 
  not (Carro `elem` obstaculos || Tronco `elem` obstaculos) && restricaoObstaculos t


{- |Rios contíguos têm direções opostas.

== Exemplos de utilização:
>>> restricaoRiosContiguos[(Rio 5, [Nenhum]), (Rio (-5), [Nenhum]), (Rio 5, [Nenhum]), (Rio (-5), [Nenhum])]
True

>>> restricaoRiosContiguos[(Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum])]
False

-}

restricaoRiosContiguos :: [LinhaDoMapa] -> Bool
 
restricaoRiosContiguos [] = True
restricaoRiosContiguos ((Rio v1, _) : (Rio v2, obstaculos) : t)
  | v1 * v2 < 0 = restricaoRiosContiguos ((Rio v2, obstaculos) : t)
  | otherwise = False

restricaoRiosContiguos (h : t) = restricaoRiosContiguos t


{- |Troncos têm no máximo 5 unidades de comprimento e Carros têm no máximo 3 unidades de comprimento.

== Exemplos de utilização:
>>> restricaoTamanhoObstaculos [(Rio 5, [Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum])]
True

>>> restricaoTamanhoObstaculos [(Estrada 5, [Nenhum, Carro, Carro, Carro, Carro, Carro, Carro, Nenhum])]
False

-}

restricaoTamanhoObstaculos :: [LinhaDoMapa] -> Bool 

-- tronco ___ tronco tronco tronco  

restricaoTamanhoObstaculos [] = True 
restricaoTamanhoObstaculos ((Rio _ , obstaculos) : t) = checkarTamanhoObstaculosLinha 5 obstaculos && restricaoTamanhoObstaculos t
restricaoTamanhoObstaculos ((Estrada _ , obstaculos) : t) = checkarTamanhoObstaculosLinha 3 obstaculos && restricaoTamanhoObstaculos  t
restricaoTamanhoObstaculos ((Relva, obstaculos) : t) = restricaoTamanhoObstaculos t
      
checkarTamanhoObstaculosLinha :: Int -> [Obstaculo] -> Bool  
checkarTamanhoObstaculosLinha tamanhoMaximo obstaculos = 
  not (any (\ grupo -> length grupo > tamanhoMaximo && head grupo /= Nenhum) grupos || firstLineElement == lastLineElement && firstLineElement /= Nenhum && (length firstLineGroup + length lastLineGroup) > tamanhoMaximo)  
  where grupos = group obstaculos 
        firstLineGroup = head grupos
        firstLineElement = head firstLineGroup
        lastLineGroup = last grupos
        lastLineElement = last lastLineGroup
  

{- |Em qualquer linha existe, no mínimo, um “obstáculo” Nenhum. Ou seja, uma linha não pode ser composta exclusivamente por obstáculos, precisando de haver pelo menos um espaço livre.

== Exemplos de utilização:
>>> restricaoquantidadeObstaculos [(Rio 5, [Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum, Nenhum])]
True

>>> restricaoquantidadeObstaculos [(Rio 5, [Tronco, Nenhum, Nenhum, Nenhum, Tronco, Tronco]), (Estrada  5, [Carro, Carro, Carro, Carro, Carro]), (Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum])]
False

-}

restricaoquantidadeObstaculos :: [LinhaDoMapa] -> Bool 

restricaoquantidadeObstaculos [] = True 
restricaoquantidadeObstaculos ((_, obstaculos) : t) = Nenhum `elem` obstaculos && restricaoquantidadeObstaculos t

{- |O comprimento da lista de obstáculos de cada linha corresponde exatamente à largura do mapa

== Exemplos de utilização:
>>> restricaoTamanhoLinha (Mapa 8 [(Rio 5, [Tronco, Nenhum, Tronco, Tronco, Nenhum, Nenhum, Tronco, Nenhum])])
True

>>> restricaoTamanhoLinha (Mapa 5 [(Relva, [Nenhum, Arvore, Arvore, Nenhum, Nenhum]), (Estrada 5, [Nenhum, Carro, Carro, Carro, Nenhum, Nenhum, Nenhum, Nenhum]), (Rio 5, [Nenhum, Tronco, Tronco, Tronco, Tronco, Tronco, Tronco, Nenhum, Nenhum])])
False
 
-}

restricaoTamanhoLinha :: Mapa -> Bool 
restricaoTamanhoLinha (Mapa _ []) = True 
restricaoTamanhoLinha (Mapa largura ((_, obstaculos) : t))
    | length obstaculos /= largura = False
    | otherwise = restricaoTamanhoLinha (Mapa largura t)

{- | Contiguamente, não devem existir mais do que 4 rios, nem 5 estradas ou relvas.

== Exemplos de utilização:
>>> restricaoQuantidadeTerrenos  [(Rio 5, [Tronco]), (Rio 5, [Tronco])]
True 

>>> restricaoQuantidadeTerrenos  [(Relva, [Nenhum]), (Estrada 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Rio 5, [Nenhum]), (Relva, [Nenhum])]
False
-}

restricaoQuantidadeTerrenos :: [LinhaDoMapa] -> Bool 
restricaoQuantidadeTerrenos [] = True 
restricaoQuantidadeTerrenos ((Rio _, _) : (Rio _, _) : (Rio _, _) : (Rio _, _) : (Rio _, _) : t ) = False
restricaoQuantidadeTerrenos ((Estrada _, _) : (Estrada _, _) : (Estrada _, _) : (Estrada _, _) : (Estrada _, _) : (Estrada _, _) : t) = False
restricaoQuantidadeTerrenos ((Relva, _) : (Relva, _) : (Relva, _) : (Relva, _) : (Relva, _) : (Relva, _) : t) = False
restricaoQuantidadeTerrenos (h : t) = restricaoQuantidadeTerrenos t


