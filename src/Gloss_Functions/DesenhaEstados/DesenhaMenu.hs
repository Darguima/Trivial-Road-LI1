module Gloss_Functions.DesenhaEstados.DesenhaMenu where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( green, circle, color, Picture )

desenhaEstadoMenu :: Estado -> IO Picture
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa) = do
  return $ color green $ circle 20
  