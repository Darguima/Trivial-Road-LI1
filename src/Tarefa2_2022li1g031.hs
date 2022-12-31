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
import System.Random

type Comprimento = Int
type Semente = Int
geraListaAleatorios :: Semente -> Comprimento -> [Int]
geraListaAleatorios s c = take c $ randoms (mkStdGen s)

{- |A função estendeMapa usa duas outras funções auxiliares:
  * proximosTerrenosValidos
  * proximosObstaculosValidos

A função estendeMapa gera e adiciona uma nova
linha válida ao topo (i.e. primeira linha, visto de cima para baixo) de um
dado mapa. Assume-se que o mapa dado é válido. O parâmetro do tipo Int
é um inteiro aleatório (no intervalo [0, 100]) que é usado para acrescentar
alguma pseudo-aleatoriedade à geração da nova linha.

Esta função tem o cuidado de verificar se nos terrenos de Relva o caminho é possível,
  ou seja, se as árvores não bloqueiam o caminho. Isso é feito, verificando se existe
  pelo menos um Nenhum acessível na linha seguinte, sem precisar recuar no mapa.
  -> Função `verificarRelvas`

== Exemplos de utilização:
>>> estendeMapa (Mapa 5 []) 5
Mapa 5 [(Relva,[Arvore,Arvore,Arvore,Arvore,Nenhum])] 

>>> estendeMapa (Mapa 5 [(Rio (-2), [Tronco,Tronco,Tronco,Tronco,Nenhum])]) 4
Mapa 5 [(Relva,[Arvore,Arvore,Arvore,Arvore,Nenhum])] 

-}

estendeMapa :: Mapa -> Int -> Mapa
estendeMapa (Mapa largura linhas) seed = adicionarVelocidade ( Mapa largura linhaMapaPossivel) seed

  where novoTerreno = randomChoice (proximosTerrenosValidos (Mapa largura linhas)) seed
        novaLinha = gerarObstaculos largura (novoTerreno, []) seed
        linhaMapaPossivel = verificarRelvas ((novoTerreno, novaLinha) : linhas)
        -- certificar me que o ma+a gerado não tem caminhos impossiveis com arvores

        randomChoice :: [a] -> Int -> a
        randomChoice options randomNumber = options !! mod randomNumber (length options)

        gerarObstaculos :: Int -> LinhaDoMapa -> Int -> [Obstaculo]
        gerarObstaculos largura (terreno, obstaculosAtuais) seed
          | null novoObstaculo = obstaculosAtuais
          | otherwise = gerarObstaculos largura ( terreno, obstaculosAtuais ++ novoObstaculo) (abs ( last randomNumbers))
          where novoObstaculo = proximoObstaculo largura (terreno, obstaculosAtuais) (abs (head randomNumbers))
                randomNumbers = geraListaAleatorios seed 2

        proximoObstaculo :: Int -> LinhaDoMapa -> Int -> [Obstaculo]
        proximoObstaculo largura linhaDoMapa randomNumber
          | null options = []
          | otherwise = [randomChoice options randomNumber]
          where options = proximosObstaculosValidos largura linhaDoMapa
        
        {- |A função verificarRelvas vai:

        1. analisar as posições que estão disponíveis na linha de Relva - `encontrarPosicoesLivres`
        2. Agrupar essas posições por posições vizinhas - `agruparNumerosVizinhos`
        3. Verificar se dentro destes grupos existe pelo menos algum que à sua frente tenha um Nenhum
        4. Em caso negativo reescreve um Nenhum no elemento mais à esquerda

        == Exemplos de utilização:
        >>> verificarRelvas [(Relva, [Arvore, Arvore, Arvore, Arvore]), (Relva, [Arvore, Nenhum, Nenhum, Arvore])]
        [(Relva, [Arvore, Nenhum, Arvore, Arvore]), (Relva, [Arvore, Nenhum, Nenhum, Arvore])]
        -}
        verificarRelvas :: [LinhaDoMapa] -> [LinhaDoMapa]
        verificarRelvas ((Relva, obstaculosNovos) : (Relva, obstaculosAnteriores) : outrasLinhas) = abrirCaminho obstaculosNovos obstaculosAnteriores ++ outrasLinhas
          where abrirCaminho :: [Obstaculo] -> [Obstaculo] -> [LinhaDoMapa]
                abrirCaminho obstaculosNovos obstaculosAnteriores = [(Relva, obstaculosNovosPossiveis), (Relva, obstaculosAnteriores)]

                {- |A função encontrarPosicoesLivres vai retornar os indices de todos os `Nenhum` dentro de uma linha

                == Exemplos de utilização:
                >>> encontrarPosicoesLivres [Arvore, Nenhum, Nenhum, Arvore]
                [1, 2]
                -}
                encontrarPosicoesLivres :: [Obstaculo] -> [Int]
                encontrarPosicoesLivres obstaculos = aux obstaculos 0
                  where aux (Nenhum : proximosObstaculos) index = index : aux proximosObstaculos (index + 1)
                        aux (_ : proximosObstaculos) index = aux proximosObstaculos (index + 1)
                        aux _ _ = []

                {- |A função agruparNumerosVizinhos vai agrupar números vizinhos na reta numérica

                == Exemplos de utilização:
                >>> agruparNumerosVizinhos [1, 2, 3, 5, 7, 8]
                [[1, 2, 3], [5], [7, 8]]
                -}
                agruparNumerosVizinhos :: [Int] -> [[Int]]
                agruparNumerosVizinhos [] = []
                agruparNumerosVizinhos [x] = [[x]]
                agruparNumerosVizinhos (h:t)
                    | (h + 1) == head (head r) = (h : head r) : tail r
                    | otherwise = [h] : r
                    where r = agruparNumerosVizinhos t

                posicoesLivresLinhaAnterior = agruparNumerosVizinhos $ encontrarPosicoesLivres obstaculosAnteriores

                {- |A função temPassagem vai dizer se na linha seguinte, cada grupo de números vizinhos tem pelo menos
                  uma casa sem obstáculos (com Nenhum)

                == Exemplos de utilização:
                >>> temPassagem [Nenhum, Arvore, Nenhum, Nenhum] [[1, 2, 3]]
                True

                >>> temPassagem [Arvore, Arvore, Arvore, Nenhum] [[1, 2, 3]]
                False
                -}
                temPassagem :: [Obstaculo] -> [Int] -> Bool
                temPassagem obstaculos (posicao : posicoesSeguintes) = obstaculos !! posicao == Nenhum || temPassagem obstaculos posicoesSeguintes
                temPassagem _ [] = False

                {- |A função encontrarArvoresACortar e lenhador trabalham juntas para descobrirem, com a ajuda da `temPassagem`
                      qual das posições têm arvores que precisam de desaparecer para tornar o caminho possível. Todos os grupos
                      de números vizinhos que não tinham passagem para a frente vão ter a sua árvore mais à esquerda aqui selecionada
                -}

                encontrarArvoresACortar :: [Obstaculo] -> [[Int]] -> [Int]
                encontrarArvoresACortar obstaculos (posicoes : outrasPosicoes)
                  | temPassagem obstaculos posicoes = encontrarArvoresACortar obstaculos outrasPosicoes
                  | otherwise = head posicoes : encontrarArvoresACortar obstaculos outrasPosicoes
                encontrarArvoresACortar _ _ = []
                
                lenhador :: [Obstaculo] -> [Int] -> [Obstaculo]
                lenhador obstaculos (indexArvore : indexesOutrasArvores) = lenhador linhaComMenosUmaArvore indexesOutrasArvores
                  where linhaComMenosUmaArvore = x ++ [Nenhum] ++ ys
                        (x,_:ys) = splitAt indexArvore obstaculos
                lenhador obstaculos _ = obstaculos
                
                arvoresACortar = encontrarArvoresACortar obstaculosNovos posicoesLivresLinhaAnterior
                obstaculosNovosPossiveis = lenhador obstaculosNovos arvoresACortar
        
        verificarRelvas linhas = linhas

        {- |A função adicionarVelocidade é responsável por receber o mapa com velocidades geradas a 0 e aleatoriamente atribuir lhes uma entre -3 e 3 -}
        
        adicionarVelocidade :: Mapa -> Int -> Mapa
        adicionarVelocidade (Mapa largura ((Rio _, obst1) : (Rio k, obst2) : t)) seed
          | k < 0 = Mapa largura ((Rio (randomChoice [1, 2, 3, 4] seed ), obst1) : (Rio k, obst2) : t)
          | otherwise = Mapa largura ((Rio (randomChoice [-4, -3, -2, -1] seed), obst1) : (Rio k, obst2) : t)
        adicionarVelocidade (Mapa largura ((Rio k, obst) : t)) seed = Mapa largura ((Rio (randomChoice [-3, -2, -1, 1, 2, 3] seed), obst) : t)
        adicionarVelocidade (Mapa largura ((Estrada k, obst) : t)) seed = Mapa largura ((Estrada (randomChoice [-3, -2, -1, 1, 2, 3] seed), obst) : t)
        adicionarVelocidade (Mapa largura ((Relva, obst) : t)) seed = Mapa largura ((Relva, obst) : t)
        adicionarVelocidade (Mapa largura obst) seed = Mapa largura obst



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
