module Gloss_Functions.ReageEventos.ReageEventoMenu where

import Gloss_Functions.GlossData (Estado, PaginaAtual (JOGO))

import Graphics.Gloss.Interface.IO.Game
    ( Key(SpecialKey),
      KeyState(Down),
      SpecialKey(KeyEnter),
      Event(EventKey) )

reageEventoMenu :: Event -> Estado -> IO Estado
reageEventoMenu (EventKey (SpecialKey KeyEnter) Down _ _) (newGame, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) =
  return (newGame, texturas, tamanhoJanela, JOGO, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual)
reageEventoMenu _ estado = return estado
