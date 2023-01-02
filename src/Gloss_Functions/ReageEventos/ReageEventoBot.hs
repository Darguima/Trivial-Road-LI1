{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoBot
Description : Função auxiliar à `reageEvento` para página do Bot
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}


module Gloss_Functions.ReageEventos.ReageEventoBot where

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, Menu, BOT), OpcoesMenu (OPCAO_JOGAR, OPCAO_CONTINUAR), estadoInicial)

import Graphics.Gloss.Interface.IO.Game

reageEventoBot :: Event -> Estado -> IO Estado
reageEventoBot (EventKey (SpecialKey KeyEsc) Down _ _) (newGame, texturas, tamanhoJanela,  BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return $ (newGame, texturas, tamanhoJanela,  Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)
reageEventoBot _ estado = return estado