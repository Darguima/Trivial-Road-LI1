{- |
Module      : Gloss_Functions.JogoFluido.JogoFluidoTerminou
Description : Função alternativa à `jogoTerminou` com efeito de fluidez
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.JogoFluido.JogoFluidoTerminou where
import LI12223 ( Jogador(Jogador), Jogo(..), Mapa(Mapa), Obstaculo(Carro, Nenhum), Terreno(Estrada, Rio) )
import Gloss_Functions.GlossData (fr)

{- | Função jogoFluidoTerminou, com a ideia da `Tarefa4_2022li1g031.jogoTerminou` mas com efeito de fluidez.
  Esta função é necessária para a fluidez vertical do jogo.
  
  Esta função é originalmente responsável por verificar se o jogador saiu do mapa ou colidiu com um obstáculo.
  Aqui adicionalmente verifica se saiu do ecrã, ou seja, a 9ª (última) linha tem de estar metade visível, metade escondida, e isto
    acontece quando estamos a meio do segundo (30º frame, a 60fps) e com o jogador na posção (x, 8).
-}

jogoFluidoTerminou :: Jogo -> Bool -> Int -> Bool
jogoFluidoTerminou (Jogo (Jogador (posX, posY)) (Mapa largura linhasMapa)) changeGameStatus frameAtual
  | changeGameStatus || metadeDoFrameRate = saiuLimitesX ||  saiuLimitesY || auxObstaculos terrenoLinhaAtual (obstaculosLinhaAtual !! posX) 
  | otherwise = False

  where (terrenoLinhaAtual, obstaculosLinhaAtual) = linhasMapa !! posY
        metadeDoFrameRate = frameAtual == div fr 2
        
        saiuLimitesX = posX < 0 || largura <= posX
        saiuLimitesY = posY < 0 || (metadeDoFrameRate && largura <= posY)

        auxObstaculos :: Terreno -> Obstaculo -> Bool
        auxObstaculos (Rio _) Nenhum = True
        auxObstaculos (Estrada _) Carro = True
        auxObstaculos _ _ = False
