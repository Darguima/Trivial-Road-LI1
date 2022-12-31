{- |
Module      : Gloss_Functions.ReageEvento
Description : Funções que reage aos eventos do jogador
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageEvento where

import Gloss_Functions.GlossData ( Estado, PaginaAtual(SOBRE, Menu, JOGO, DERROTA) )
import Gloss_Functions.ReageEventos.ReageEventoMenu (reageEventoMenu)
import Gloss_Functions.ReageEventos.ReageEventoJogo (reageEventoJogo)
import Gloss_Functions.ReageEventos.ReageEventoPausa (reageEventoPausa)
import Gloss_Functions.ReageEventos.ReageEventoDerrota (reageEventoDerrota)
import Gloss_Functions.ReageEventos.ReageEventoSobre (reageEventoSobre)

import Graphics.Gloss.Interface.IO.Game ( Event(EventKey))

{- | A função reageEvento recebe um evento do gloss, e transmite a às suas funções auxiliares.
  Cada `Gloss_Functions.GlossData.PaginaAtual` tem a sua função auxiliar no Pacote `Gloss_Functions.ReageEventos`
-}

reageEvento :: Event -> Estado -> IO Estado

reageEvento evento estado@(_, _, _, Menu _, _, _, _, _,_) = reageEventoMenu evento estado
reageEvento evento estado@(_, _, _, JOGO, _, _, _, _,_) = reageEventoJogo evento estado
reageEvento evento estado@(_, _, _, DERROTA, _, _, _, _,_) = reageEventoDerrota evento estado
reageEvento evento estado@(_, _, _, SOBRE, _, _, _, _,_) = reageEventoSobre evento estado
