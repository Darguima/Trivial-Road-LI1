{- |
Module      : Tarefa3_2022li1g031
Description : Movimentação do personagem e obstáculos
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2022/23.
-}
module Tarefa3_2022li1g031 where

import LI12223

{- |A função estendeMapa usa duas outras funções auxiliares:
  * proximosTerrenosValidos
  * proximosObstaculosValidos

A função anima jogo movimenta os obst aculos (de acordo com a velocidade) do terreno em
que se encontram), e o personagem, de acordo com a jogada dada (Cima,Baixo,Esquerda,Direita,Parado), e tendo em conta as seguintes restrições: 
(De relembrar que, quando o jogador se move horizontalmente, apenas a coordenada em X sofre alterações, e verticalmente, tanto o X como o Y podem sofrer alterações)
1-Numa estrada ou rio com velocidade v, os obst+aculos devem mover-se
|v| unidades na direção determinada.
2- As jogadas Move Cima, Move Baixo, etc. fazem com que o jogador se
mova 1 unidade para cima, baixo, etc, respectivamente.
3- Mesmo quando o jogador não efectua qualquer movimento (i.e. a sua
jogada  ́e Parado), se o personagem se encontrar em cima de um tronco,
o jogador acompanha o movimento tronco.
4- O jogador não consegue escapar do mapa através dos seus movimentos.
Por exemplo, se o jogador se encontrar na linha de topo do mapa,
então mover-se para cima não tem qualquer efeito, uma vez que já se
encontra no limite do mapa.
5- Ao deslocar os obstáculos de uma linha, estes , assim que
desaparecerem por um dos lados do mapa, devem reaparecer no lado
oposto.

 Para tal , foram criadas 5 funções auxiliares, de modo a tornar o processo mais simples.


== Exemplos de utilização:
>>> animaJogo  (Jogo (Jogador (0,0) (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Tronco,Tronco]), (Estrada 2, [Nenhum,Carro,Carro,Nenhum,Carro])])))  (Move Baixo)
(Jogo (Jogador (0,1) (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Tronco,Tronco]), (Estrada 2, [Nenhum,Carro,Nenhum,Carro,Carro])])))  (Move Baixo)

-}


animaJogo :: Jogo -> Jogada -> Jogo
animaJogo jogo (Move Cima) = auxiliarCima jogo
animaJogo jogo (Move Baixo) = auxiliarBaixo jogo
animaJogo jogo (Move Esquerda) = auxiliarEsquerda jogo
animaJogo jogo (Move Direita) = auxiliarDireita jogo
animaJogo jogo _ = jogo

animaJogador :: Jogo -> Jogada -> Jogo
animaJogador jogo (Move Cima) = auxiliarCima jogo
animaJogador jogo (Move Baixo) = auxiliarBaixo jogo
animaJogador jogo (Move Esquerda) = auxiliarEsquerda jogo
animaJogador jogo (Move Direita) = auxiliarDireita jogo
animaJogador jogo _ = jogo

auxiliarDireita :: Jogo-> Jogo
auxiliarDireita (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa))
 | x+1<l && not (emArvoreDireita (x,y) linhasDoMapa) = Jogo (Jogador (x+1,y)) (Mapa l  linhasDoMapa)
 | otherwise = Jogo (Jogador (x ,y)) (Mapa l  linhasDoMapa)

auxiliarEsquerda :: Jogo-> Jogo
auxiliarEsquerda (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa))
 | x-1>=0 && not (emArvoreEsquerda (x,y) linhasDoMapa) = Jogo (Jogador (x-1,y)) (Mapa l  linhasDoMapa)
 | otherwise = Jogo (Jogador (x,y)) (Mapa l  linhasDoMapa)

auxiliarBaixo :: Jogo -> Jogo
auxiliarBaixo (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa))
 | y+1 < l &&  not (emArvoreBaixo (x,y) linhasDoMapa) = Jogo (Jogador (x,y+1)) (Mapa l linhasDoMapa)
 | otherwise =  Jogo (Jogador (x,y)) (Mapa l linhasDoMapa)

auxiliarCima :: Jogo -> Jogo
auxiliarCima (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa) )
  | y-1>=0 && not (emArvoreCima (x,y) linhasDoMapa) = Jogo (Jogador (x,y-1)) (Mapa l linhasDoMapa)
  | otherwise = Jogo (Jogador (x,y)) (Mapa l linhasDoMapa)

animaMapa :: Jogo -> Jogo
animaMapa (Jogo (Jogador pos) (Mapa l linhasDoMapa) )
  | emTronco pos linhasDoMapa = Jogo (Jogador (moveComTronco pos ( Mapa l linhasDoMapa))) (Mapa l  (moveObstaculos pos 0 linhasDoMapa) )
  | otherwise = Jogo (Jogador pos) (Mapa l (moveObstaculos pos 0 linhasDoMapa) )

emTronco :: Coordenadas -> [LinhaDoMapa] -> Bool
emTronco (x,y) linhasDoMapa
 | ( snd (linhasDoMapa !! y) !! x ) == Tronco = True
 | otherwise= False

moveComTronco :: Coordenadas -> Mapa -> Coordenadas
moveComTronco (x,y) (Mapa l linhasDoMapa)
  | velocidade > 0 && x+velocidade>=l = (l,y)
  | velocidade <0 && x+velocidade <0 = (-1,y)
  | velocidade>0 && x+velocidade<l = (x+velocidade,y)
  | otherwise = (x+velocidade,y)
  where
      (Rio velocidade, obstaculos) = linhasDoMapa !! y

emArvoreDireita :: Coordenadas -> [LinhaDoMapa]-> Bool
emArvoreDireita (x,y) linhasDoMapa
 | ( snd (linhasDoMapa !! y) !! (x+1) ) == Arvore = True
 | otherwise= False

emArvoreEsquerda :: Coordenadas -> [LinhaDoMapa]-> Bool
emArvoreEsquerda (x,y) linhasDoMapa
 | ( snd (linhasDoMapa !! y) !! (x-1) ) == Arvore = True
 | otherwise= False

emArvoreCima :: Coordenadas -> [LinhaDoMapa] -> Bool
emArvoreCima (x,y) linhasDoMapa
 | ( snd (linhasDoMapa !! (y-1)) !! x ) == Arvore = True
 | otherwise= False

emArvoreBaixo :: Coordenadas -> [LinhaDoMapa]-> Bool
emArvoreBaixo (x,y) linhasDoMapa
 | ( snd (linhasDoMapa !! (y+1)) !! x ) == Arvore = True
 | otherwise= False

moveObstaculos :: Coordenadas -> Int ->[LinhaDoMapa]-> [LinhaDoMapa]
moveObstaculos _ _  [] = []
moveObstaculos pos currentLine ((Rio velocidade, obstaculos) : t)
    | velocidade > 0 =  (Rio velocidade , rotateRight pos currentLine velocidade obstaculos) : moveObstaculos pos (currentLine + 1) t
    | otherwise = (Rio velocidade , rotateLeft pos currentLine(abs velocidade) obstaculos) : moveObstaculos pos (currentLine + 1) t
moveObstaculos pos currentLine ((Estrada  velocidade, obstaculos ):t)
    |  velocidade>0 =  (Estrada velocidade , rotateRight pos currentLine velocidade obstaculos) : moveObstaculos pos (currentLine + 1) t
    | otherwise = (Estrada  velocidade , rotateLeft pos currentLine (abs velocidade) obstaculos) : moveObstaculos pos (currentLine + 1) t

moveObstaculos pos currentLine (h:t) = h : moveObstaculos pos (currentLine + 1) t

rotateRight :: Coordenadas -> Int -> Int -> [Obstaculo] -> [Obstaculo]
rotateRight _ _ _ [] = []
rotateRight _ _ 0 obstaculos = obstaculos
rotateRight pos@(posX, posY) currentLine velocidade obstaculos 
  | newObstaculos !! posX == Carro && posY == currentLine = newObstaculos
  | otherwise = rotateRight pos currentLine (velocidade - 1) newObstaculos
 where newObstaculos = last obstaculos : init obstaculos

rotateLeft :: Coordenadas -> Int-> Int -> [Obstaculo]-> [Obstaculo]
rotateLeft _ _ _ [] = []
rotateLeft _ _ 0 obstaculos = obstaculos
rotateLeft  pos@(posX, posY) currentLine velocidade obstaculos@(x:xs)  
 | newObstaculos !! posX == Carro && posY == currentLine = newObstaculos
 | otherwise = rotateLeft pos currentLine (velocidade - 1) newObstaculos
  where newObstaculos = xs ++ [x]
