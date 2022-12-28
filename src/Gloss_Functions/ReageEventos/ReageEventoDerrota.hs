module Gloss_Functions.ReageEventos.ReageEventoDerrota where

import Gloss_Functions.GlossData (Estado, PaginaAtual (DERROTA, Menu), OpcoesMenu (OPCAO_JOGAR), estadoInicial)

import Graphics.Gloss.Interface.IO.Game

reageEventoDerrota :: Event -> Estado -> IO Estado
reageEventoDerrota (EventKey (SpecialKey KeyEsc) Down _ _) (newGame, texturas, tamanhoJanela,  DERROTA, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) =
  return $ estadoInicial texturas tamanhoJanela
reageEventoDerrota _ estado = return estado
