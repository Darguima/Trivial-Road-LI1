module Gloss_Functions.DesenhaEstados.DesenhaDerrota where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( green, circle, color, Picture (Translate, Pictures, Text, Color), white )

desenhaEstadoDerrota :: Estado -> IO Picture
desenhaEstadoDerrota (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
   return $ Pictures  $ (Translate 0 0 $ texturas !! 25)  : [Translate 0 0   $ Color  white $ Text  $ show pontuacaoAtual ]
  