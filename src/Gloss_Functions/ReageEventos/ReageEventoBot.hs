module Gloss_Functions.ReageEventos.ReageEventoBot where

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, Menu, BOT), OpcoesMenu (OPCAO_JOGAR, OPCAO_CONTINUAR), estadoInicial)

import Graphics.Gloss.Interface.IO.Game

reageEventoBot :: Event -> Estado -> IO Estado
reageEventoBot (EventKey (SpecialKey KeyEsc) Down _ _) (newGame, texturas, tamanhoJanela,  BOT, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return $ (newGame, texturas, tamanhoJanela,  Menu OPCAO_CONTINUAR, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y)
reageEventoBot _ estado = return estado