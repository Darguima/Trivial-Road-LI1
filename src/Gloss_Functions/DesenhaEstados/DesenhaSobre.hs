module Gloss_Functions.DesenhaEstados.DesenhaSobre where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( green, circle, color, Picture (Translate) )

desenhaEstadoSobre :: Estado -> IO Picture
desenhaEstadoSobre (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
 return $ Translate 0 0 $ texturas !! 20
  