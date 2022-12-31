{- |
Module      : Tarefa3_2022li1g031
Description : Movimentação do personagem e obstáculos
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2022/23.
-}
module Tarefa3_2022li1g031 where

import LI12223 
import Utils.Utils (extrairVelocidade)

{- | A função animaJogo chama a função `animaMapa` e `animaJogador`.

== Exemplos de utilização:
>>> animaJogo (Jogo (Jogador (0,0))  (Mapa 5 [(Relva , [Nenhum,Nenhum,Nenhum,Arvore,Arvore]), (Estrada 2, [Carro, Carro ,Carro,Nenhum,Nenhum])])) (Move Baixo)
Jogo (Jogador (0,1)) (Mapa 5 [(Relva,[Nenhum,Nenhum,Nenhum,Arvore,Arvore]),(Estrada 2,[Nenhum,Nenhum, Carro, Carro ,Carro])])
-}

animaJogo :: Jogo -> Jogada -> Jogo
animaJogo jogo jogada = animaMapa (animaJogador jogo jogada)

{- | A função animaJogador movimenta o personagem, de acordo com a jogada dada.
  Esta função evita que o jogador saia do mapa ou que ocupe posições de árvores

@
data Direção = Cima
  | Baixo
  | Esquerda
  | Direita
data Jogada = Parado | Move Direção
@
-}
animaJogador :: Jogo -> Jogada -> Jogo
animaJogador jogo (Move Cima) = auxiliarCima jogo
  where auxiliarCima :: Jogo -> Jogo
        auxiliarCima (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa) )
          | y-1>=0 && not (emArvoreCima (x,y) linhasDoMapa) = Jogo (Jogador (x,y-1)) (Mapa l linhasDoMapa)
          | otherwise = Jogo (Jogador (x,y)) (Mapa l linhasDoMapa)

        emArvoreCima :: Coordenadas -> [LinhaDoMapa] -> Bool
        emArvoreCima (x,y) linhasDoMapa = ( snd (linhasDoMapa !! (y-1)) !! x ) == Arvore

animaJogador jogo (Move Baixo) = auxiliarBaixo jogo
  where auxiliarBaixo :: Jogo -> Jogo
        auxiliarBaixo (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa))
          | y+1 < l &&  not (emArvoreBaixo (x,y) linhasDoMapa) = Jogo (Jogador (x,y+1)) (Mapa l linhasDoMapa)
          | otherwise =  Jogo (Jogador (x,y)) (Mapa l linhasDoMapa)

        emArvoreBaixo :: Coordenadas -> [LinhaDoMapa]-> Bool
        emArvoreBaixo (x,y) linhasDoMapa = ( snd (linhasDoMapa !! (y+1)) !! x ) == Arvore

animaJogador jogo (Move Esquerda) = auxiliarEsquerda jogo
  where auxiliarEsquerda :: Jogo-> Jogo
        auxiliarEsquerda (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa))
          | x-1>=0 && not (emArvoreEsquerda (x,y) linhasDoMapa) = Jogo (Jogador (x-1,y)) (Mapa l linhasDoMapa)
          | otherwise = Jogo (Jogador (x,y)) (Mapa l linhasDoMapa)

        emArvoreEsquerda :: Coordenadas -> [LinhaDoMapa]-> Bool
        emArvoreEsquerda (x,y) linhasDoMapa = ( snd (linhasDoMapa !! y) !! (x-1) ) == Arvore

animaJogador jogo (Move Direita) = auxiliarDireita jogo
  where auxiliarDireita :: Jogo-> Jogo
        auxiliarDireita (Jogo (Jogador (x,y)) (Mapa l linhasDoMapa))
          | x+1<l && not (emArvoreDireita (x,y) linhasDoMapa) = Jogo (Jogador (x+1,y)) (Mapa l linhasDoMapa)
          | otherwise = Jogo (Jogador (x ,y)) (Mapa l linhasDoMapa)

        emArvoreDireita :: Coordenadas -> [LinhaDoMapa]-> Bool
        emArvoreDireita (x,y) linhasDoMapa = ( snd (linhasDoMapa !! y) !! (x+1) ) == Arvore


animaJogador jogo _ = jogo

{- | A função animaMapa movimenta os obstáculos (de acordo com a velocidade) do terreno em que se encontram e
  move o personagem caso este esteja em cima de um tronco.

Não utilizar esta função ao renderizar o jogo, utilizar antes a `Gloss_Functions.JogoFluido.AnimaMapaFluido`.
-}

animaMapa :: Jogo -> Jogo
animaMapa (Jogo (Jogador pos) (Mapa l linhasDoMapa) )
  | emTronco pos linhasDoMapa = Jogo (Jogador (moveComTronco pos ( Mapa l linhasDoMapa))) (Mapa l  novosObstaculos )
  | otherwise = Jogo (Jogador pos) (Mapa l novosObstaculos)
  where novosObstaculos = moveObstaculos pos 0 linhasDoMapa

        emTronco :: Coordenadas -> [LinhaDoMapa] -> Bool
        emTronco (x,y) linhasDoMapa = ( snd (linhasDoMapa !! y) !! x ) == Tronco

        moveComTronco :: Coordenadas -> Mapa -> Coordenadas
        moveComTronco (x,y) (Mapa _ linhasDoMapa) = (x + velocidade, y)
          where velocidade = extrairVelocidade (fst $ linhasDoMapa !! y)

        moveObstaculos :: Coordenadas -> Int -> [LinhaDoMapa] -> [LinhaDoMapa]
        moveObstaculos _ _  [] = []
        moveObstaculos pos linhaAtual ((terreno, obstaculos) : restantesLinhasMapa) =
          (terreno, rotate pos linhaAtual velocidade obstaculos) : moveObstaculos pos (linhaAtual + 1) restantesLinhasMapa
            where velocidade = extrairVelocidade terreno

        rotate :: Coordenadas -> Int -> Int -> [Obstaculo] -> [Obstaculo]
        rotate _ _ _ [] = []
        rotate _ _ 0 obstaculos = obstaculos
        rotate pos@(posX, posY) linhaAtual velocidade obstaculos@(x:xs) 
          | novosObstaculos !! posX == Carro && posY == linhaAtual = novosObstaculos
          | otherwise = rotate pos linhaAtual novaVelocidade novosObstaculos
          where novaVelocidade = velocidade + if velocidade > 0 then -1 else 1
                novosObstaculos
                  | velocidade > 0 = last obstaculos : init obstaculos
                  | velocidade < 0 = xs ++ [x]
