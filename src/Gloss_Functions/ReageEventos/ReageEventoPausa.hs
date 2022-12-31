{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `reageEvento` para página de Pausa
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageEventos.ReageEventoPausa where

import Gloss_Functions.GlossData (Estado)

import Graphics.Gloss.Interface.IO.Game (Event)

{- | Função auxiliar à `reageEvento` para página de Pausa -}

reageEventoPausa :: Event -> Estado -> IO Estado
reageEventoPausa _ = return
