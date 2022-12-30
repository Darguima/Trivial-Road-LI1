{- |
Module      : Tarefa4_2022li1g031
Description : Determinar se o jogo terminou
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2022/23.
-}
module Tarefa4_2022li1g031 where

import LI12223

{- | A função jogoTerminou indica se o jogador perdeu o jogo, onde True significa que sim. Para isso
ela testa se o jogador se encontra fora do mapa, na água, ou “debaixo”
de um carro (i.e. na mesma posição de um carro.)

Para tal foram criadas duas funções auxiliares: `auxObstaculos` e `auxPosicao` para analisar se está a colidir com um obstaculos e se ainda 
está dentro do mapa respetivamente.

== Exemplos de utilização:
>>> jogoTerminou (Jogo (Jogador (0,0))  (Mapa 4 [ (Rio 5 , [Tronco, Tronco, Tronco, Nenhum] )]))
False

>>> jogoTerminou (Jogo (Jogador (0,0))  (Mapa 4 [ (Estrada 5 , [Carro, Carro, Nenhum, Nenhum] )]))
True

-}

-- Não utilizar esta função, utilizar antes a Gloss_Functions.JogoFluido.JogoFluidoTerminou
jogoTerminou :: Jogo -> Bool
jogoTerminou (Jogo (Jogador (x,y)) (Mapa largura linhasMapa)) = auxPosicao x ||  auxPosicao y || auxObstaculos terrenoLinhaAtual (obstaculosLinhaAtual !! x) 
  where (terrenoLinhaAtual, obstaculosLinhaAtual) = linhasMapa !! y
        auxPosicao :: Int -> Bool
        auxPosicao posicao = posicao < 0 || largura <= posicao

        auxObstaculos :: Terreno -> Obstaculo -> Bool
        auxObstaculos (Rio _) Nenhum = True
        auxObstaculos (Estrada _) Carro = True
        auxObstaculos _ _ = False
