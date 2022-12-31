{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `desenharNovoEstado` para página de sobre
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.DesenhaEstados.DesenhaSobre where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( green, circle, color, Picture (Translate) )

{- | Função auxiliar à `desenharNovoEstado` para página de sobre -}

desenhaEstadoSobre :: Estado -> IO Picture
desenhaEstadoSobre (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
 return $ Translate 0 0 $ texturas !! 20
  