{- |
Module      : Gloss_Functions.ReageTempo.ReageTempoJogo
Description : Função auxiliar à `reageEvento` para página de Sobre
Copyright   : Afonso Gonçalves Pedreira <a104537@alunos.uminho.pt>
              Dário Silva Guimarães  <a104344@alunos.uminho.pt>
-}

module Gloss_Functions.ReageEventos.ReageEventoSobre where

import Gloss_Functions.GlossData (Estado, OpcoesMenu (OPCAO_JOGAR, OPCAO_SOBRE), PaginaAtual (Menu, SOBRE))

import Graphics.Gloss.Interface.IO.Game (Event (EventKey), SpecialKey (KeyDown, KeyEsc), Key (SpecialKey), KeyState (Down))

{- | Função auxiliar à `reageEvento` para página de Sobre -}

reageEventoSobre :: Event -> Estado -> IO Estado
reageEventoSobre (EventKey  (SpecialKey KeyEsc) Down  _ _) (newGame, texturas, tamanhoJanela, SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,ypontos) =
  return (newGame, texturas, tamanhoJanela,  Menu OPCAO_SOBRE, pontuacaoAtual, pontuacoes, larguraMapa, frameAtual,ypontos)
reageEventoSobre _ estado = return estado