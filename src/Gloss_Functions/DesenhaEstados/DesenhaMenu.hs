module Gloss_Functions.DesenhaEstados.DesenhaMenu where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( Picture(Text, Translate, Scale, Color), white )

desenhaEstadoMenu :: Estado -> IO Picture
desenhaEstadoMenu (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual) = do
  return $ Translate (-200) 0 $ Scale 0.5 0.5 $ Color white $ Text "Press Enter to Play"
  