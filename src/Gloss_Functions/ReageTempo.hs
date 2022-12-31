{- |
Module      : Gloss_Functions.ReageEvento
Description : Funções que é executada a cada frame
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageTempo where

import Gloss_Functions.GlossData ( Estado, PaginaAtual(JOGO, DERROTA) )
import Gloss_Functions.ReageTempo.ReageTempoJogo (reageTempoJogo)

{- | A função reageEvento recebe um evento do gloss, e transmite a às suas funções auxiliares.
  Cada `Gloss_Functions.GlossData.PaginaAtual` tem a sua função auxiliar no Pacote `Gloss_Functions.ReageTempo`
-}

reageTempo :: Float -> Estado -> IO Estado
reageTempo timeElapsed estado@(_, _, _, JOGO, _, _, _, _,_) = reageTempoJogo timeElapsed estado
reageTempo _ estado = return estado