module Gloss_Functions.ReageTempo where

import Gloss_Functions.GlossData ( Estado, PaginaAtual(JOGO, DERROTA) )
import Gloss_Functions.ReageTempo.ReageTempoJogo (reageTempoJogo)

reageTempo :: Float -> Estado -> IO Estado
reageTempo timeElapsed estado@(_, _, _, JOGO, _, _, _, _,_) = reageTempoJogo timeElapsed estado
reageTempo _ estado = return estado