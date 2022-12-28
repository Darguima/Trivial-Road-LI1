module Gloss_Functions.ReageEventos.ReageEventoSobre where

import Gloss_Functions.GlossData (Estado, OpcoesMenu (OPCAO_JOGAR, OPCAO_SOBRE), PaginaAtual (Menu, SOBRE))

import Graphics.Gloss.Interface.IO.Game (Event (EventKey), SpecialKey (KeyDown, KeyEsc), Key (SpecialKey), KeyState (Down))

reageEventoSobre :: Event -> Estado -> IO Estado
reageEventoSobre (EventKey  (SpecialKey KeyEsc) Down  _ _) (newGame, texturas, tamanhoJanela, SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual)
reageEventoSobre _ estado = return estado