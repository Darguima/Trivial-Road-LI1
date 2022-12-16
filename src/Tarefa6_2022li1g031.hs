{- |
Module      : Tarefa6_2022li1g031
Description : Implementação Gráfica
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2022/23.
-}

module Tarefa6_2022li1g031 where
import Gloss_Functions.PlayGame (startGame)

play :: IO ()
play = startGame

{-|
O objetivo desta tarefa consiste em aproveitar todas as funcionalidades já
elaboradas nas outras Tarefas e construir uma aplicação gráfica que permita
um utilizador jogar. Para o interface gráfico deverá utilizar a biblioteca
Gloss1 , que terá oportunidade de estudar durante as aulas práticas.
O grafismo e as funcionalidades disponibilizadas ficam à criatividade dos
alunos, sendo que, no mı́nimo, a aplicação deverá:

1. Ser capaz de gerar um mapa e permitir ao utilizador jogá-lo.
2. Implementar o efeito de deslize do mapa ao fim de um determinado tempo (à escolha do grupo.)
3. Implementar um sistema de pontuação, e.g. em função do tempo que o jogador está a jogar, ou quão longe o jogador já conseguiu chegar.
4. Detetar quando o jogador perde e reagir adequadamente, e.g mostrando uma mensagem, reiniciando o jogo, etc.
-}