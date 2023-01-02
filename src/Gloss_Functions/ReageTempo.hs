module Gloss_Functions.ReageTempo where

import Gloss_Functions.GlossData ( Estado, PaginaAtual(JOGO, DERROTA, BOT) )
import Gloss_Functions.ReageTempo.ReageTempoJogo (reageTempoJogo)
import Gloss_Functions.ReageTempo.ReageTempoBot (reageTempoBot)

reageTempo :: Float -> Estado -> IO Estado
reageTempo timeElapsed estado@(_, _, _, JOGO, _, _, _, _,_) = reageTempoJogo timeElapsed estado
reageTempo timeElapsed estado@(_, _, _, BOT, _, _, _, _,_) = reageTempoBot timeElapsed estado
reageTempo _ estado = return estado