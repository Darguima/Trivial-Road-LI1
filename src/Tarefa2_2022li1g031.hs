{- |
Module      : Tarefa2_2022li1g031
Description : Geração contínua de um mapa
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 2 do projeto de LI1 em 2022/23.
-}
module Tarefa2_2022li1g031 where

import LI12223
import Tarefa1_2022li1g031 (checkarTamanhoObstaculosLinha)


{- |A função estendeMapa usa duas outras funções auxiliares:
  * proximosTerrenosValidos
  * proximosObstaculosValidos

A função estendeMapa gera e adiciona uma nova
linha válida ao topo (i.e. primeira linha, visto de cima para baixo) de um
dado mapa. Assume-se que o mapa dado é válido. O parâmetro do tipo Int
é um inteiro aleatório (no intervalo [0, 100]) que é usado para acrescentar
alguma pseudo-aleatoriedade à geração da nova linha.

== Exemplos de utilização:
>>> estendeMapa (Mapa 5 []) 5
Mapa 5 [(Relva,[Arvore,Arvore,Arvore,Arvore,Nenhum])] 

>>> estendeMapa (Mapa 5 [(Rio (-2), [Tronco,Tronco,Tronco,Tronco,Nenhum])]) 4
Mapa 5 [(Relva,[Arvore,Arvore,Arvore,Arvore,Nenhum])] 

-}

estendeMapa :: Mapa -> Int -> Mapa
estendeMapa (Mapa largura linhas) seed = correctMap ( Mapa largura ((novoTerreno, novaLinha) : linhas) ) seed

  where novoTerreno = randomChoice (proximosTerrenosValidos (Mapa largura linhas)) seed
        novaLinha = gerarObstaculos largura (novoTerreno, []) seed

        randomChoice :: [a] -> Int -> a
        randomChoice options seed = options !! mod seed (length options)

        gerarObstaculos :: Int -> LinhaDoMapa -> Int -> [Obstaculo]
        gerarObstaculos largura (terreno, obstaculosAtuais) seed
          | null novoObstaculo = obstaculosAtuais
          | otherwise = gerarObstaculos largura ( terreno, obstaculosAtuais ++ novoObstaculo) seed
          where novoObstaculo = proximoObstaculo largura (terreno, obstaculosAtuais) seed


        proximoObstaculo :: Int -> LinhaDoMapa -> Int -> [Obstaculo]
        proximoObstaculo largura linhaDoMapa seed
          | null options = []
          | otherwise = [randomChoice options seed]
          where options = proximosObstaculosValidos largura linhaDoMapa
        
        correctMap :: Mapa -> Int -> Mapa
        correctMap (Mapa largura ((Rio _, obst1) : (Rio k, obst2) : t)) seed
          | k < 0 = Mapa largura ((Rio (randomChoice [1, 2, 3, 4] seed ), obst1) : (Rio k, obst2) : t)
          | otherwise = Mapa largura ((Rio (randomChoice [-4, -3, -2, -1] seed), obst1) : (Rio k, obst2) : t)
        

        correctMap (Mapa largura ((Rio k, obst) : t)) seed = Mapa largura ((Rio (randomChoice [-3, -2, -1, 1, 2, 3] seed), obst) : t)
        correctMap (Mapa largura ((Estrada k, obst) : t)) seed = Mapa largura ((Estrada (randomChoice [-3, -2, -1, 1, 2, 3] seed), obst) : t)
        correctMap (Mapa largura ((Relva, obst) : t)) seed = Mapa largura ((Relva, obst) : t)
        correctMap (Mapa largura obst) seed = Mapa largura obst



{- |A função próximosTerrenosVálidos deve gerar a lista de terrenos passı́veis
de serem usados numa nova linha no topo do mapa dado. Ignore, para os
propósitos desta função, o parâmetro velocidade, assumindo, para este, o
valor 0. Por exemplo, quando o mapa dado é vazio, então todos os terrenos
são válidos. Assim devemos considerar os vários casos de aplicação desta função. Devemos ter em atenção a existência de mais do que 5 estradas/relvas ou 4 rios contiguos.

== Exemplos de utilização:
>>> próximosTerrenosVálidos (Mapa 10 [])
[Rio 1, Estrada 1, Relva]

>>> próximosTerrenosVálidos (Mapa 3 [(Rio 1, []), (Rio 1, []), (Rio 1, []), (Rio 1, [])])
[Estrada 1, Relva]

-}

proximosTerrenosValidos :: Mapa -> [Terreno]
proximosTerrenosValidos (Mapa _ [(Rio _, _), (Rio _, _), (Rio _, _), (Rio _, _)]) = [Estrada 0, Relva]
proximosTerrenosValidos (Mapa _ [(Estrada _, _), (Estrada _, _), (Estrada _, _), (Estrada _, _), (Estrada _, _)]) = [Rio 0, Relva]
proximosTerrenosValidos (Mapa _ [(Relva, _), (Relva, _), (Relva, _), (Relva, _), (Relva, _)]) = [Estrada 0, Rio 0]

proximosTerrenosValidos (Mapa _ _) = [Estrada 0, Rio 0, Relva]

{- |A função próximosObstáculosVálidos deve gerar a lista
de obstáculos passı́veis de serem usados para continuar uma dada linha do
mapa. O parâmetro do tipo Int corresponde à largura do mapa. Esta funçaõ, 
tem em conta não só os obstáculos permitidos no tipo de
terreno indicado como as regras a respeito do comprimento dos obstáculos.

== Exemplos de utilização:
>>> proximosObstaculosValidos 4 (Rio 2, [Nenhum,Nenhum,Tronco ])
[Nenhum, Tronco]

== Exemplos de utilização:
>>> proximosObstaculosValidos 4 (Relva, [Arvore, Arvore, Arvore])
[Nenhum]

-}

proximosObstaculosValidos :: Int -> LinhaDoMapa -> [Obstaculo]

proximosObstaculosValidos largura (Rio _ , obstaculos)
  | length obstaculos == largura = []
  | length obstaculos == largura - 1  && Nenhum `notElem` obstaculos = [Nenhum]
  | length obstaculos == largura - 1  && Tronco `notElem` obstaculos = [Tronco]
  | not (checkarTamanhoObstaculosLinha 5 (obstaculos ++ [Tronco]))  = [Nenhum]
  | otherwise = [Nenhum, Tronco]


proximosObstaculosValidos largura (Estrada _ , obstaculos)
  | length obstaculos == largura = []
  | length obstaculos == largura - 1  && Nenhum `notElem` obstaculos = [Nenhum]
  | not (checkarTamanhoObstaculosLinha 3 (obstaculos ++ [Carro]))  = [Nenhum]
  | otherwise = [Nenhum, Carro]

proximosObstaculosValidos largura (Relva , obstaculos)
  | length obstaculos == largura = []
  | length obstaculos == largura - 1  && Nenhum `notElem` obstaculos = [Nenhum]
  | otherwise= [Nenhum, Arvore]
