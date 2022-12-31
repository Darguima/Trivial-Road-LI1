{- |
Module      : Gloss_Functions.DesenhaEstado
Description : Funções que desenha o estado do jogo
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.DesenhaEstado where

import Gloss_Functions.GlossData ( Estado, PaginaAtual(DERROTA, Menu, JOGO,  SOBRE) )
import Gloss_Functions.DesenhaEstados.DesenhaMenu (desenhaEstadoMenu)
import Gloss_Functions.DesenhaEstados.DesenhaJogo (desenhaEstadoJogo)
-- import Gloss_Functions.DesenhaEstados.DesenhaPausa (desenhaEstadoPausa)
import Gloss_Functions.DesenhaEstados.DesenhaDerrota (desenhaEstadoDerrota)
import Gloss_Functions.DesenhaEstados.DesenhaSobre (desenhaEstadoSobre)

import Graphics.Gloss ( Picture )

{- | A função desenharNovoEstado recebe um o último estado e desenha o no ecrã.
  Cada `Gloss_Functions.GlossData.PaginaAtual` tem a sua função auxiliar no Pacote `Gloss_Functions.DesenhaEstados`
-}

desenharNovoEstado :: Estado -> IO Picture
desenharNovoEstado estado@(_, _, _, Menu _, _, _, _, _,_) = desenhaEstadoMenu estado
desenharNovoEstado estado@(_, _, _, JOGO, _, _, _, _,_) = desenhaEstadoJogo estado
desenharNovoEstado estado@(_, _, _, DERROTA, _, _, _, _,_) = desenhaEstadoDerrota estado
desenharNovoEstado estado@(_, _, _, SOBRE, _, _, _, _,_) = desenhaEstadoSobre estado
