module Gloss_Functions.DesenhaEstados.DesenhaSobre where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( green, circle, color, Picture )

desenhaEstadoSobre :: Estado -> IO Picture
desenhaEstadoSobre (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa) = do
  return $ color green $ circle 20
  