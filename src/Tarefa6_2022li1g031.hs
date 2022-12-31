{- |
Module      : Tarefa6_2022li1g031
Description : Implementação Gráfica
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2022/23.
-}

module Tarefa6_2022li1g031 where
import Gloss_Functions.PlayGame (startGame)

{-| A função play chama a função `Gloss_Functions.PlayGame.startGame` que utiliza a biblioteca Gloss
  para desenhar tudo o que foi feito até aqui
-}

play :: IO ()
play = startGame