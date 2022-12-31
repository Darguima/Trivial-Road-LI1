{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `desenharNovoEstado` para página de derrota
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.DesenhaEstados.DesenhaDerrota where

import LI12223 ( Jogador(Jogador), Jogo(Jogo) )
import Gloss_Functions.GlossData ( Estado )
import Graphics.Gloss ( green, circle, color, Picture (Translate, Pictures, Text, Color), white )

{- | Função auxiliar à `desenharNovoEstado` para página de derrota -}

desenhaEstadoDerrota :: Estado -> IO Picture
desenhaEstadoDerrota (Jogo (Jogador pos) mapa, texturas, tamanhoJanela, paginaAtual, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,y) = do
   return $ Pictures  $ (Translate 0 0 $ texturas !! 25)  : [Translate 0 0   $ Color  white $ Text  $ show pontuacaoAtual ]
  